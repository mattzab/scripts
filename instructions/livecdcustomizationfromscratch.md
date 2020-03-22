# Live CD Customization From Scratch
This guide is designed to be as close to copy/paste as possible, built with 18.04 bionic. Change things as needed.
This guide will occasionally break into **optional** sections. Skip those parts if you like.
## Main Guide
```
sudo apt install debootstrap syslinux syslinux-utils squashfs-tools genisoimage -y
mkdir -p work/chroot
cd work
sudo debootstrap --arch=amd64 bionic chroot
sudo mount --bind /dev chroot/dev
sudo cp /etc/hosts chroot/etc/hosts
sudo cp /etc/resolv.conf chroot/etc/resolv.conf
sudo cp /etc/apt/sources.list chroot/etc/apt/sources.list
sudo chroot chroot
mount none -t proc /proc
mount none -t sysfs /sys
mount none -t devpts /dev/pts
export HOME=/root
export LC_ALL=C
```
### Optional: Add PPAs
```
apt install nano gnupg
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 12345678  #Substitute "12345678" with the PPA's OpenPGP ID.
nano /etc/apt/sources.list #Add PPA sources using Launchpad.net
```
## Main Guide
```
apt update
apt install --yes dbus
dbus-uuidgen > /var/lib/dbus/machine-id
dpkg-divert --local --rename --add /sbin/initctl
```
### Optional: Upgrade packages
`sudo apt update; sudo apt upgrade`
## Main Guide
```
apt install -y linux-generic ubuntu-standard casper lupin-casper discover laptop-detect os-prober
```
### Optional: Add Installer
```
apt install ubiquity-frontend-gtk
```
### Optional: Install any other software
`sudo apt install any packages you want to at this point`
## Main Guide
```
rm /var/lib/dbus/machine-id
rm /sbin/initctl
dpkg-divert --rename --remove /sbin/initctl
apt-get clean
rm -rf /tmp/*
rm /etc/resolv.conf
umount -lf /proc
umount -lf /sys
umount -lf /dev/pts
exit
sudo umount chroot/dev
mkdir -p image/{casper,isolinux,install}
```

### Main Guide (?) Uncertain if this is right...
```
cp chroot/boot/vmlinuz-2.6.**-**-generic image/casper/vmlinuz
cp chroot/boot/initrd.img-2.6.**-**-generic image/casper/initrd.lz

cp /usr/lib/ISOLINUX/isolinux.bin image/isolinux/
cp /usr/lib/syslinux/modules/bios/ldlinux.c32 image/isolinux/ # for syslinux 5.00 and newer

cp /boot/memtest86+.bin image/install/memtest
```
`nano image/isolinux/isolinux.cfg`
Copy/Paste
```
DEFAULT live
LABEL live
  menu label ^Start or install Ubuntu Remix
  kernel /casper/vmlinuz
  append  file=/cdrom/preseed/ubuntu.seed boot=casper initrd=/casper/initrd.lz quiet splash --
LABEL check
  menu label ^Check CD for defects
  kernel /casper/vmlinuz
  append  boot=casper integrity-check initrd=/casper/initrd.lz quiet splash --
LABEL memtest
  menu label ^Memory test
  kernel /install/memtest
  append -
LABEL hd
  menu label ^Boot from first hard disk
  localboot 0x80
  append -
DISPLAY isolinux.txt
TIMEOUT 300
PROMPT 1

#prompt flag_val
#
# If flag_val is 0, display the "boot:" prompt
# only if the Shift or Alt key is pressed,
# or Caps Lock or Scroll lock is set (this is the default).
# If  flag_val is 1, always display the "boot:" prompt.
#  http://linux.die.net/man/1/syslinux   syslinux manpage
```

## Main Guide
Create Manifest:
```
sudo chroot chroot dpkg-query -W --showformat='${Package} ${Version}\n' | sudo tee image/casper/filesystem.manifest
sudo cp -v image/casper/filesystem.manifest image/casper/filesystem.manifest-desktop
REMOVE='ubiquity ubiquity-frontend-gtk ubiquity-frontend-kde casper lupin-casper live-initramfs user-setup discover1 xresprobe os-prober libdebian-installer4'
for i in $REMOVE
do
        sudo sed -i "/${i}/d" image/casper/filesystem.manifest-desktop
done
```
Compress Chroot:
`sudo mksquashfs chroot image/casper/filesystem.squashfs -e boot`
Create Diskdefines:
`nano image/README.diskdefines`
```
#define DISKNAME  Ubuntu Remix
#define TYPE  binary
#define TYPEbinary  1
#define ARCH  i386
#define ARCHi386  1
#define DISKNUM  1
#define DISKNUM1  1
#define TOTALNUM  0
#define TOTALNUM0  1
```
Recognition as Ubuntu Remix:
```
touch image/ubuntu

mkdir image/.disk
cd image/.disk
touch base_installable
echo "full_cd/single" > cd_type
echo "Ubuntu Remix 14.04" > info  # Update version number to match your OS version
echo "http//your-release-notes-url.com" > release_notes_url
cd ../..
```
Calculate MD5:
```
sudo -s
(cd image && find . -type f -print0 | xargs -0 md5sum | grep -v "\./md5sum.txt" > md5sum.txt)
exit
```
Create ISO:
```
cd image
sudo mkisofs -r -V "$IMAGE_NAME" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ../ubuntu-remix.iso .
cd ..
```











