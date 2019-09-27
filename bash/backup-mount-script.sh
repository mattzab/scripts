/usr/bin/rclone mount backups: /.backups/remote --allow-other --dir-cache-time 96h --timeout 1h --umask 000 --vfs-cache-mode writes &
/usr/bin/mergerfs -o rw,async_read=false,use_ino,allow_other,func.getattr=newest,category.action=all,category.create=ff,cache.files=partial,dropcacheonclose=true /.backups/local:/.backups/remote /backups" 
while :; do /usr/bin/rclone move /.backups/local backups: -P; /bin/sleep 1h; done
