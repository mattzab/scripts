sleep 3
echo "Run in tmux if you want to close this window!"
echo " "
sleep 3
echo "What would you like your Google Drive folder to be called?"
read gdrivef
sleep 3
echo " "
echo "Your Google Drive folder will be created at ~/'$gdrivef'"
sleep 3
echo " "
echo "Which rclone remote would you like to use?"
rclone listremotes
read rcloneremote
sleep 3
echo " "
echo "Cloud and local data will synchronize every 1 minute."
echo " "
echo "Starting Google Drive at '$gdrivef' using mount '$rcloneremote'."
mkdir ~/.tempgdrive ~/.tempgdrive/remote ~/.tempgdrive/local "~/$gdrivef" 
rclone mount "$rcloneremote" "~/$gdrivef" --vfs-cache-mode writes
mergerfs -o rw,async_read=false,use_ino,allow_other,func.getattr=newest,category.action=all,category.create=ff,cache.files=partial,dropcacheonclose=true ~/.tempgdrive/local:~/.tempgdrive/remote "~/$gdrivef" 
while :; do rclone move ~/.tempgdrive/local "$rcloneremote" -P; sleep $time; done
