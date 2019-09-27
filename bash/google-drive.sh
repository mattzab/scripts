sleep 1
echo "Run in tmux if you want to close this window!"
echo " "
sleep 1
echo "What would you like your Google Drive folder to be called?"
read gdrivef
mkdir $HOME/.tempgdrive $HOME/.tempgdrive/remote $HOME/.tempgdrive/local $HOME/"$gdrivef" 
echo " "
echo "Your Google Drive folder was created at ~/'$gdrivef'"
sleep 1
echo " "
echo "Which rclone remote would you like to use?"
rclone listremotes
echo " "
read rcloneremote
sleep 1
echo " "
echo "Cloud and local data will synchronize every 1 minute."
echo " "
echo "Starting Google Drive at '$gdrivef' using mount '$rcloneremote'."

/usr/bin/rclone mount "$rcloneremote" $HOME/.tempgdrive/remote --vfs-cache-mode writes &
/usr/bin/mergerfs -o rw,async_read=false,use_ino,allow_other,func.getattr=newest,category.action=all,category.create=ff,cache.files=partial,dropcacheonclose=true $HOME/.tempgdrive/local:$HOME/.tempgdrive/remote $HOME/"$gdrivef" 
while :; do /usr/bin/rclone move $HOME/.tempgdrive/local "$rcloneremote" -P; /bin/sleep 1m; done
fusermount -u $HOME/.tempgdrive/remote
fusermount -u $HOME/"$gdrivef"
