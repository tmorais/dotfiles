#!/bin/bash

# https://stackoverflow.com/questions/58419658/bash-shell-calculating-sum-of-all-video-durations-inside-a-folder-in-mac-os

sum=0
while read line; do
    duration=$(mdls -name kMDItemDurationSeconds "$line" | cut -d "=" -f 2)
    sum=$(echo "$duration+$sum"|bc)
done <<< "$(find .  -type f -name "*.mp4")"
h=$(bc <<< "$sum/3600")
m=$(bc <<< "($sum%3600)/60")
s=$(bc <<< "$sum%60")
printf "%02d:%02d:%05.2f\n" $h $m $s
