# Linux Terminal & Other Scripts Cheat Sheet
Triple click to copy/paste command.
# CONTENTS
### [Install Stuff](#install)
### [Use youtube-dl](#youtube-dl-usage-examples--explanations)
### [File Converstion](#file-conversion)
### [Text Manipulation](#text-manipulation-1)
### [System Maintenance](#system-maintenance-1)
### [Browser Bookmarklets](#bookmarklets)
### [Other Cool Stuff](#other-stuff)

# Install
## Restic
`sudo apt install golang-go git -y; git clone https://github.com/restic/restic; cd restic; go run build.go -v; sudo mv restic /usr/bin; cd ..; sudo rm -rf restic/`
## Ubuntu Chroot in Chromebook using Crouton
```
curl -o ~/Downloads/crouton https://raw.githubusercontent.com/dnschneid/crouton/master/installer/crouton
sudo sh ~/Downloads/crouton -t xiwi,touch,extension,cli-extra,audio -n ubuntu
```
## Rclone
`curl https://rclone.org/install.sh | sudo bash`
## youtube-dl
```
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
```
## Pi-Hole
`curl -sSL https://install.pi-hole.net | bash`
## Aptik
```
sudo add-apt-repository -y ppa:teejee2008/ppa
sudo apt-get install aptik aptik-gtk
```
## TimeShift
```
sudo add-apt-repository -y ppa:teejee2008/ppa
sudo apt-get install timeshift
```
## mkUSB
```bash
sudo add-apt-repository ppa:mkusb/ppa
sudo apt install mkusb mkusb-nox usb-pack-efi
```
## mergerfs
`curl https://github.com/trapexit/mergerfs/releases/download/2.28.2/mergerfs_2.28.2.ubuntu-bionic_amd64.deb -o mergerfs.deb | sudo dpkg -i`

## youtube-dl usage examples & explanations
### Download a video or playlist (URL to individual video or playlist)
`youtube-dl -f best -vic -o '%(title)s.%(ext)s' URL`

`-f best` passes flag to request Format: Best.

`-v` Verbose, `-i` Ignore Errors, `-c` Continue partial downloads 

`-o '%(title)s.%(ext)s` Output to a file, with the Name of the video, and the file extension
### Download a list of videos from a file
`youtube-dl -f best -vic -o '%(title)s.%(ext)s' -a list.txt`
`-a list.txt` will read list.txt line by line and download each video
### Download a list of playlists
`while read url; do youtube-dl -f best -vic -o '%(title)s.%(ext)s' $url; done <playlists.txt`
This uses a `while` loop to read each line from the file `playlists.txt`, and assigns each line the variable called `url`.
It then passes the playlist url to the end of the youtube-dl command with the variable `$url`. This repeats until it is done. `<` is passing `playlists.txt` as input to the previous command, similar to how `>` passes a command's output to a file.




## Merge SWORD Modules
`awk '/^\$\$\$/{k=$0;next}{g[k]=g[k]"\n"$0}END{for(k in g)print k g[k]}' file1 file2`

## CD to ISO
`(pv -n /dev/cdrom | dd of="$HOME/Desktop/CDROM.iso" bs=128M conv=notrunc,noerror) 2>&1 | dialog --gauge "Running dd if=/dev/cdrom of=$HOME/Desktop/CDROM.iso, please wait..." 10 70 0`
## Copy Folder to Drive
`curl https://raw.githubusercontent.com/mattzab/scripts/master/bash/Copy-Folder-To-Drive.sh | bash`
## Move Files To Directory Above
`for d in ./*/ ; do (cd "$d" && mv * ..); done`
## Mirror Website
`wget -mkEpnp http://example.org`
(Span Hosts Version)
`wget -mkEpnpH http://example.org`
## Start Command in tmux
`/usr/bin/tmux send-keys -t name "/usr/bin/command --arguments" C-m`

# FILE CONVERSION
## TS to MP4
`ffmpeg -i input.ts -c copy output.mp4`
### All the TS files in this folder to MP4
`for f in *.ts ; do (ffmpeg -i "$f" -c copy "$f.mp4"); done`
### Recurse through directories 1 layer deep converting TS to MP4
`for d in ./* ; do (cd "$d"; for f in ./* ; do (ffmpeg -i "$f" -c copy "$f.mp4"); done; rm *.ts; rename 's/.ts//' *); done`
## MKV to MP4
`HandBrakeCLI -Z "Android 720p30" -s scan -F --subtitle-burned -N eng -i "$f" -o ~/work/"${f%.mkv}.mp4"`
### Convert .mkv files to .mp4 and upload with rclone
`for f in *.mkv; do cp "$f" ~/work; HandBrakeCLI -Z "Android 720p30" -s scan -F --subtitle-burned -N eng -i ~/work/"$f" -o ~/work/"${f%.mkv}.mp4"; rm ~/work/"$f"; rclone move ~/work plex:Transcoded -P; done`
## Horizontally flip a video file
`ffmpeg -i INPUT -vf hflip -c:a copy OUTPUT`
***
# TEXT MANIPULATION
## Delete up to line
sed '2,4d' file
## Delete empty lines in a file
`sed  '/^$/d'`
## Reverse all lines of a file
`tac a.txt > b.txt`

## Reverse list of files in a folder
`ls * | tac | while read f; do echo "$f"; done`

## Search for file containing contents
`grep -rnwl '/path/to/somewhere/' -e 'pattern'`

## Delete line by filter
`sed '${/filter/d;}' file`

## Delete from filter to end
`sed '/filter/,$d' file`

# Syntax
## Cut off part of a file name
`mv $f "${f%.*}.mp4"`
## Rename images with random trailing numbers
`for f in *.jpg; do mv $f "${f%.jpg}-$RANDOM.jpg"; done`


***
# SYSTEM MAINTENANCE
## Remove Apt Translation Hits
Paste
`Acquire::Languages "none";`
Into a new file called `/etc/apt/apt.conf.d/99translations`
## Move Live User's Home Folder to a new name
Log in as a new admin user,
`usermod -m -d /home/new user`
## Disable all logging (Save USB Drive from wear & tear)
`service rsyslog stop`

`systemctl disable rsyslog`



***
# REGEX
## Match All Except
`^(?!http).*$`
Will match all lines except ones beginning with `http`

`^(?!http).*$\n`
Will match all "carriage return" lines, with the exception of ones beginning with `http`


***
# Bookmarklets
## Plex-dl
`javascript:(function()%7Bif (typeof plxDwnld %3D%3D 'undefined') %7Bvar jsCode %3D document.createElement('script')%3BjsCode.setAttribute('src'%2C 'https%3A%2F%2Fpiplong.run%2Fplxdwnld%2Fbookmarklet.js%3Fts%3D' %2B Math.floor(Date.now()%2F1000))%3Bdocument.body.appendChild(jsCode)%3B%7D else %7BplxDwnld.init()%3B%7D%7D)()`

## Lazyload
`javascript:(function(){function I(u){var t=u.split('.'),e=t[t.length-1].toLowerCase();return {gif:1,jpg:1,jpeg:1,png:1,mng:1}[e]}function hE(s){return s.replace(/&/g,'&amp;').replace(/>/g,'&gt;').replace(/</g,'&lt;').replace(/"/g,'&quot;');}var q,h,i,z=open().document;z.write('<center>');for(i=0;q=document.links[i];++i){h=q.href;if(h&&I(h))z.write('<img src="'+hE(h)+'" width="50%" loading="lazy"><br><br>');}z.close();})()`

## Expose Passwords
`javascript:(function(){var s,F,j,f,i; s = ""; F = document.forms; for(j=0; j<F.length; ++j) { f = F[j]; for (i=0; i<f.length; ++i) { if (f[i].type.toLowerCase() == "password") s += f[i].value + "\n"; } } if (s) alert("Passwords in forms on this page:\n\n" + s); else alert("There are no passwords in forms on this page.");})();`

## Sort Table
`javascript:function toArray (c){var a, k;a=new Array;for (k=0; k<c.length; ++k)a[k]=c[k];return a;}function insAtTop(par,child){if(par.childNodes.length) par.insertBefore(child, par.childNodes[0]);else par.appendChild(child);}function countCols(tab){var nCols, i;nCols=0;for(i=0;i<tab.rows.length;++i)if(tab.rows[i].cells.length>nCols)nCols=tab.rows[i].cells.length;return nCols;}function makeHeaderLink(tableNo, colNo, ord){var link;link=document.createElement('a');link.href='javascript:sortTable('+tableNo+','+colNo+','+ord+');';link.appendChild(document.createTextNode((ord>0)?'a':'d'));return link;}function makeHeader(tableNo,nCols){var header, headerCell, i;header=document.createElement('tr');for(i=0;i<nCols;++i){headerCell=document.createElement('td');headerCell.appendChild(makeHeaderLink(tableNo,i,1));headerCell.appendChild(document.createTextNode('/'));headerCell.appendChild(makeHeaderLink(tableNo,i,-1));header.appendChild(headerCell);}return header;}g_tables=toArray(document.getElementsByTagName('table'));if(!g_tables.length) alert("This page doesn't contain any tables.");(function(){var j, thead;for(j=0;j<g_tables.length;++j){thead=g_tables[j].createTHead();insAtTop(thead, makeHeader(j,countCols(g_tables[j])))}}) ();function compareRows(a,b){if(a.sortKey==b.sortKey)return 0;return (a.sortKey < b.sortKey) ? g_order : -g_order;}function sortTable(tableNo, colNo, ord){var table, rows, nR, bs, i, j, temp;g_order=ord;g_colNo=colNo;table=g_tables[tableNo];rows=new Array();nR=0;bs=table.tBodies;for(i=0; i<bs.length; ++i)for(j=0; j<bs[i].rows.length; ++j){rows[nR]=bs[i].rows[j];temp=rows[nR].cells[g_colNo];if(temp) rows[nR].sortKey=temp.innerHTML;else rows[nR].sortKey="";++nR;}rows.sort(compareRows);for (i=0; i < rows.length; ++i)insAtTop(table.tBodies[0], rows[i]);}`

## Enlarge Textareas
`javascript:(function(){var i,x; for(i=0;x=document.getElementsByTagName("textarea")[i];++i) x.rows += 5; })()`

***
# Other Stuff
## Make a Google Drive Mount
### Run this interactive script:
`curl https://raw.githubusercontent.com/mattzab/scripts/master/bash/google-drive.sh | bash`
### Or do it manually:
```
mkdir ~/rclone-folder ~/local-folder "~/Google Drive"
rclone mount googledrive: /rclone-folder --vfs-cache-mode writes
mergerfs -o rw,async_read=false,use_ino,allow_other,func.getattr=newest,category.action=all,category.create=ff,cache.files=partial,dropcacheonclose=true ~/local-folder:~/rclone-folder "~/Google Drive"
while :; do rclone move ~/local-folder googledrive: -P; sleep 1m; done
```
