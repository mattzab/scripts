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














