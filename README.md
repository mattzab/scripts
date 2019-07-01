# Terminal One Liners
Triple click to copy/paste command.
## Install Ubuntu with Crouton
`curl -o ~/Downloads/crouton https://raw.githubusercontent.com/dnschneid/crouton/master/installer/crouton; sudo sh ~/Downloads/crouton -t xiwi,touch,extension,cli-extra,audio -n ubuntu`
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
## Mirror Website
`wget -mkEpnp http://example.org`
(Span Hosts Version)
`wget -mkEpnpH http://example.org`
## Convert .ts files to .mp4
`for d in ./* ; do (cd "$d"; for f in ./* ; do (ffmpeg -i "$f" -c copy "$f.mp4"); done; rm *.ts; rename 's/.ts//' *); done`




***
# REGEX
## Match All Except
`^(?!http).*$`
Will match all lines except ones beginning with `http`

`^(?!http).*$\n`
Will match all "carriage return" lines, with the exception of ones beginning with `http`
