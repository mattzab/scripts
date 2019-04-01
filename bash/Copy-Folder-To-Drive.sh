#!/bin/bash

echo "Drag the folder you want to upload to your OneDrive into this window."
echo " "
read folder
echo " "
echo "Type the name of the folder you want it to end up in, on OneDrive."
echo " "
read target
echo "Working..."
echo " "
rclone copy -vv "$folder" onedrive:"$target"

echo "All done!"
