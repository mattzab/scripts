# Terminal One Liners

## Crouton
`curl https://raw.githubusercontent.com/mattzab/scripts/master/bash/crouton.sh | bash`
## Merge SWORD Modules
`awk '/^\$\$\$/{k=$0;next}{g[k]=g[k]"\n"$0}END{for(k in g)print k g[k]}' file1 file2`
## Install Rclone
`curl https://rclone.org/install.sh | sudo bash`
## Install Pi-Hole
`curl -sSL https://install.pi-hole.net | bash`
## CD to ISO
`(pv -n /dev/cdrom | dd of="$HOME/Desktop/CDROM.iso" bs=128M conv=notrunc,noerror) 2>&1 | dialog --gauge "Running dd if=/dev/cdrom of=$HOME/Desktop/CDROM.iso, please wait..." 10 70 0`
## Copy Folder to Drive
`curl https://raw.githubusercontent.com/mattzab/scripts/master/bash/Copy-Folder-To-Drive.sh | bash`
## Install Wordpress
`curl https://raw.githubusercontent.com/mattzab/scripts/master/bash/Install-Wordpress.sh | bash`
## Move Files To Directory Above
`for d in ./*/ ; do (cd "$d" && mv * ..); done`
