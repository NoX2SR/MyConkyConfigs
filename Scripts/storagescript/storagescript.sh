#!/usr/bin/env bash
color="color1"
textcolor="color"
tabspace=35

while getopts c:s:t: flag
do
    case "${flag}" in
        c) color="$OPTARG";;
        s) showcity="$OPTARG";;
        t) showcountry="$OPTARG";;
    esac
done

find -P /media/nemanja/ -maxdepth 1 -mindepth 0 -type d | while IFS= read -r d; do 
    if [ "$d" != "/media/nemanja/" ]; then
        # echo "$d"
        echo "\${$color}\${goto $tabspace}$(basename "$d") : \${color}\${fs_used $d}/\${fs_size $d} \${alignr}\${fs_used_perc $d}% \${fs_bar 4,100 $d}"
    fi
done