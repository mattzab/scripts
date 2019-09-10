# Linux Terminal Cheat Sheet
Triple click to copy/paste command.

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

# SED
## Delete up to line
sed '2,4d' file

tac a.txt > b.txt

ls * | tac | while read f; do echo "$f"; done

grep -rnwl '/path/to/somewhere/' -e 'pattern'

## Delete line by filter
sed '${/ubuntu/d;}' file

## Delete from filter to end
sed '/fedora/,$d' file

# Syntax
## Cut off part of a file name
mv $f "${f%.*}.mp4"


***
# System Maintenance
## Remove Apt Translation Hits
Paste
`Acquire::Languages "none";`
Into a new file called `/etc/apt/apt.conf.d/99translations`



***
# REGEX
## Match All Except
`^(?!http).*$`
Will match all lines except ones beginning with `http`

`^(?!http).*$\n`
Will match all "carriage return" lines, with the exception of ones beginning with `http`


***
# Bookmarks
`javascript:(function()%7Bif (typeof plxDwnld %3D%3D 'undefined') %7Bvar jsCode %3D document.createElement('script')%3BjsCode.setAttribute('src'%2C 'https%3A%2F%2Fpiplong.run%2Fplxdwnld%2Fbookmarklet.js%3Fts%3D' %2B Math.floor(Date.now()%2F1000))%3Bdocument.body.appendChild(jsCode)%3B%7D else %7BplxDwnld.init()%3B%7D%7D)()`
