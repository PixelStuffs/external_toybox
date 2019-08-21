#!/bin/sh

PATH='/usr/lib/google-golang/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/google/home/enh/bin:/usr/local/google/home/enh/bin'

BUILD='cc -Wall -Wundef -Wno-char-subscripts -Werror=implicit-function-declaration -funsigned-char -I . -Os -ffunction-sections -fdata-sections -fno-asynchronous-unwind-tables -fno-strict-aliasing -DTOYBOX_VERSION="android-o-mr1-iot-release-1.0.14-80-g88dfc8df55f2"'

LINK='-Wl,--gc-sections -o generated/unstripped/toybox -Wl,--as-needed -lutil -lcrypt -lm -lresolv -lselinux -lcrypto -lz'

FILES='lib/args.c
lib/commas.c
lib/deflate.c
lib/dirtree.c
lib/env.c
lib/lib.c
lib/linestack.c
lib/llist.c
lib/net.c
lib/password.c
lib/portability.c
lib/tty.c
lib/xwrap.c lib/help.c main.c toys/android/getenforce.c
toys/android/load_policy.c
toys/android/log.c
toys/android/restorecon.c
toys/android/runcon.c
toys/android/sendevent.c
toys/android/setenforce.c
toys/lsb/dmesg.c
toys/lsb/gzip.c
toys/lsb/hostname.c
toys/lsb/killall.c
toys/lsb/md5sum.c
toys/lsb/mknod.c
toys/lsb/mktemp.c
toys/lsb/mount.c
toys/lsb/pidof.c
toys/lsb/seq.c
toys/lsb/sync.c
toys/lsb/umount.c
toys/net/ifconfig.c
toys/net/microcom.c
toys/net/netcat.c
toys/net/netstat.c
toys/net/ping.c
toys/net/rfkill.c
toys/net/tunctl.c
toys/other/acpi.c
toys/other/base64.c
toys/other/blkid.c
toys/other/blockdev.c
toys/other/chcon.c
toys/other/chroot.c
toys/other/chrt.c
toys/other/clear.c
toys/other/devmem.c
toys/other/dos2unix.c
toys/other/fallocate.c
toys/other/flock.c
toys/other/fmt.c
toys/other/free.c
toys/other/freeramdisk.c
toys/other/fsfreeze.c
toys/other/fsync.c
toys/other/help.c
toys/other/hwclock.c
toys/other/i2ctools.c
toys/other/inotifyd.c
toys/other/insmod.c
toys/other/ionice.c
toys/other/losetup.c
toys/other/lsattr.c
toys/other/lsmod.c
toys/other/lspci.c
toys/other/lsusb.c
toys/other/makedevs.c
toys/other/mkswap.c
toys/other/modinfo.c
toys/other/mountpoint.c
toys/other/nbd_client.c
toys/other/nsenter.c
toys/other/partprobe.c
toys/other/pivot_root.c
toys/other/pmap.c
toys/other/printenv.c
toys/other/pwdx.c
toys/other/readlink.c
toys/other/realpath.c
toys/other/rev.c
toys/other/rmmod.c
toys/other/setfattr.c
toys/other/setsid.c
toys/other/stat.c
toys/other/swapoff.c
toys/other/swapon.c
toys/other/sysctl.c
toys/other/tac.c
toys/other/taskset.c
toys/other/timeout.c
toys/other/truncate.c
toys/other/uptime.c
toys/other/usleep.c
toys/other/uuidgen.c
toys/other/vconfig.c
toys/other/vmstat.c
toys/other/watch.c
toys/other/which.c
toys/other/xxd.c
toys/other/yes.c
toys/pending/bc.c
toys/pending/dd.c
toys/pending/diff.c
toys/pending/expr.c
toys/pending/getfattr.c
toys/pending/lsof.c
toys/pending/modprobe.c
toys/pending/more.c
toys/pending/stty.c
toys/pending/tr.c
toys/pending/traceroute.c
toys/posix/basename.c
toys/posix/cal.c
toys/posix/cat.c
toys/posix/chgrp.c
toys/posix/chmod.c
toys/posix/cksum.c
toys/posix/cmp.c
toys/posix/comm.c
toys/posix/cp.c
toys/posix/cpio.c
toys/posix/cut.c
toys/posix/date.c
toys/posix/df.c
toys/posix/dirname.c
toys/posix/du.c
toys/posix/echo.c
toys/posix/env.c
toys/posix/expand.c
toys/posix/false.c
toys/posix/file.c
toys/posix/find.c
toys/posix/getconf.c
toys/posix/grep.c
toys/posix/head.c
toys/posix/iconv.c
toys/posix/id.c
toys/posix/kill.c
toys/posix/ln.c
toys/posix/ls.c
toys/posix/mkdir.c
toys/posix/mkfifo.c
toys/posix/nice.c
toys/posix/nl.c
toys/posix/nohup.c
toys/posix/od.c
toys/posix/paste.c
toys/posix/patch.c
toys/posix/printf.c
toys/posix/ps.c
toys/posix/pwd.c
toys/posix/renice.c
toys/posix/rm.c
toys/posix/rmdir.c
toys/posix/sed.c
toys/posix/sleep.c
toys/posix/sort.c
toys/posix/split.c
toys/posix/strings.c
toys/posix/tail.c
toys/posix/tar.c
toys/posix/tee.c
toys/posix/time.c
toys/posix/touch.c
toys/posix/true.c
toys/posix/tty.c
toys/posix/ulimit.c
toys/posix/uname.c
toys/posix/uniq.c
toys/posix/unlink.c
toys/posix/uudecode.c
toys/posix/uuencode.c
toys/posix/wc.c
toys/posix/xargs.c'


$BUILD $FILES $LINK
