#!/bin/bash

sudo su

apt update
apt install apt-cacher-ng
export http_proxy=http://127.0.0.1:3142
apt update

apt install ccache apt-build

echo 'Package: *
Pin: origin ""
Pin-Priority: 800' > /etc/apt/preferences.d/aptpinning

dpkg --get-selections | \
	awk '{if ($2=="install") print $1}' > /etc/apt/apt-build.list
  
apt-build world
