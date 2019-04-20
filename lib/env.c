// Can't trust libc not to leak enviornment variable memory, so...

#include "toys.h"

// In libc, populated by start code,used by getenv() and exec() and friends.
extern char **environ;

// Returns the number of bytes taken by the environment variables. For use
// when calculating the maximum bytes of environment+argument data that can
// be passed to exec for find(1) and xargs(1).
long environ_bytes()
{
  long bytes = sizeof(char *);
  char **ev;

  for (ev = environ; *ev; ev++) bytes += sizeof(char *) + strlen(*ev) + 1;

  return bytes;
}

// This will clear the inherited environment if called first thing.
// Use this instead of envc so we keep track of what needs to be freed.
void xclearenv(void)
{
  toys.envc = 0;
  *environ = 0;
}

// Frees entries we set earlier. Use with libc getenv but not setenv/putenv.
// if name has an equals and !val, act like putenv (name=val must be malloced!)
// if !val unset name. (Name with = and val is an error)
void xsetenv(char *name, char *val)
{
  unsigned i, len, envc;
  char *new;

  // If we haven't snapshot initial environment state yet, do so now.
  if (!toys.envc) {
    while (environ[toys.envc++]);
    memcpy(new = xmalloc(((toys.envc|0xff)+1)*sizeof(char *)),
      environ, toys.envc*sizeof(char *));
    environ = (void *)new;
  }

  new = strchr(name, '=');
  if (new) {
    len = new-name;
    if (val) error_exit("xsetenv %s to %s", name, val);
    new = name;
  } else {
    len = strlen(name);
    if (val) new = xmprintf("%s=%s", name, val);
  }

  envc = toys.envc-1;
  for (i = 0; environ[i]; i++) {
    // Drop old entry, freeing as appropriate. Assumes no duplicates.
    if (!memcmp(name, environ[i], len) && environ[i][len]=='=') {
      if (i>=envc) free(environ[i]);
      else {
        char **delete = environ+i;

        // move old entries down, add at end of old data
        toys.envc = envc--;
        for (i=0; new ? i<envc : !!delete[i]; i++) delete[i] = delete[i+1];
        i = envc;
      }
      break;
    }
  }

  if (!new) return;

  // resize and null terminate if expanding
  if (!environ[i]) {
    len = i+1;
    if (!(len&255)) environ = xrealloc(environ, len*sizeof(char *));
    environ[len] = 0;
  }
  environ[i] = new;
}

// reset environment for a user, optionally clearing most of it
void reset_env(struct passwd *p, int clear)
{
  int i;

  if (clear) {
    char *s, *stuff[] = {"TERM", "DISPLAY", "COLORTERM", "XAUTHORITY"};

    for (i=0; i<ARRAY_LEN(stuff); i++)
      stuff[i] = (s = getenv(stuff[i])) ? xmprintf("%s=%s", stuff[i], s) : 0;
    xclearenv();
    for (i=0; i < ARRAY_LEN(stuff); i++) if (stuff[i]) xsetenv(stuff[i], 0);
    if (chdir(p->pw_dir)) {
      perror_msg("chdir %s", p->pw_dir);
      xchdir("/");
    }
  } else {
    char **ev1, **ev2;

    // remove LD_*, IFS, ENV, and BASH_ENV from environment
    for (ev1 = ev2 = environ;;) {
      while (*ev2 && (strstart(ev2, "LD_") || strstart(ev2, "IFS=") ||
        strstart(ev2, "ENV=") || strstart(ev2, "BASH_ENV="))) ev2++;
      if (!(*ev1++ = *ev2++)) break;
    }
  }

  setenv("PATH", _PATH_DEFPATH, 1);
  setenv("HOME", p->pw_dir, 1);
  setenv("SHELL", p->pw_shell, 1);
  setenv("USER", p->pw_name, 1);
  setenv("LOGNAME", p->pw_name, 1);
}
