#! /bin/bash

#Trying to clear Downloads follder. Moving file to different
#directories and group them by modification time
function move_to_quarantine {
    mv ~/Downloads/*.jpg ~/Downloads/.Quarantine/Pictures
    mv ~/Downloads/*.png ~/Downloads/.Quarantine/Pictures

    mv ~/Downloads/*.pdf ~/Downloads/.Quarantine/Docs
    mv ~/Downloads/*.doc ~/Downloads/.Quarantine/Docs
    mv ~/Downloads/*.docx ~/Downloads/.Quarantine/Docs

    mv ~/Downloads/*.mp4 ~/Downloads/.Quarantine/Video
    mv ~/Downloads/*.mkv ~/Downloads/.Quarantine/Video

    mv ~/Downloads/* ~/Downloads/.Quarantine/Others
}

function group_by_modtime {
    if [ $# -eq 0 ]
    then
        echo "Internal error in group_by_modtime."
	echo "Function must get directory to work"
	exit 1
    fi

    if [ -d "$1" ]
    then
	echo "$1 Found!"
	for entry in $1/*
	do
	    echo "$entry"
	    if [ -f "$entry" ]
	    then
	        modtime=$(stat "$entry" | grep Modify | awk '{print $2}')
		echo $modtime
		dest="$1/$modtime"
		if [ -d "$dest" ]
		then
		    mv "$entry" "$dest"
	        else
		    mkdir "$dest"
		    mv "$entry" "$dest"
		fi
	    fi
        done
    else
        echo "$1 directory does not exist"
    fi
}

group_by_modtime /home/infer/Pictures/Other
