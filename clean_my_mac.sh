#!/bin/sh

#A free and simple single script to clean and speed up your Mac, built for OS X 10.10
#Note that this will Reset Notification Center and Notification Center settings, and also may cause lock screen and desktop image to be different - a fix is being prepared.

#calculate used space
ifs=$(df -H / | egrep '/$' | awk '{print $4}' | cut -d "G" -f 1)
echo "Total free space before cleanup is "$ifs"GB"

#Saving for later...
#inspace=$(df -h | grep -A1 /dev/disk1 | sed -n 1p | awk '{ print $7 }')
#ins="${inspace:0:2}.${inspace:2:2}"
#echo "Total free space before cleanup is "$ins"GB and "$inspace"kb"

#user cache file
echo "cleaning user cache file from ~/Library/Caches"
rm -rf ~/Library/Caches/*
echo "done cleaning from ~/Library/Caches"
#user logs
echo "cleaning user log file from ~/Library/logs"
rm -rf ~/Library/logs/*
echo "done cleaning from ~/Library/logs"
#user preference log
echo "cleaning user preference logs"
#rm -rf ~/Library/Preferences/*
echo "done cleaning from /Library/Preferences"
#system caches
echo "cleaning system caches"
sudo rm -rf /Library/Caches/*
echo "done cleaning system cache"
#system logs
echo "cleaning system logs from /Library/logs"
sudo rm -rf /Library/logs/*
echo "done cleaning from /Library/logs"
echo "cleaning system logs from /var/log"
sudo rm -rf /var/log/*
echo "done cleaning from /var/log"
echo "cleaning from /private/var/folders"
sudo rm -rf /private/var/folders/*
echo "done cleaning from /private/var/folders"
#ios photo caches
echo "cleaning ios photo caches"
var=$(whoami)
rm -rf /Users/$var/Pictures/iPhoto\ Library/iPod\ Photo\ Cache/*
echo "done cleaning from /Users/$var/Pictures/iPhoto Library/iPod Photo Cache"
#application caches and logs
echo "cleaning application caches and logs"
for x in $(ls ~/Library/Containers/) 
do 
    echo "cleaning ~/Libarary/Containers/$x/Data/Library/Caches"
    rm -rf ~/Library/Containers/$x/Data/Library/Caches/*
    rm -rf ~/Library/Containers/$x/Data/Library/Logs/*
    echo "done cleaning ~/Library/Containers/$x/Data/Library/Caches"
done
echo "done cleaning for application caches"
#Terminal Caches (.asl)
echo "If your Terminal is running slow, cleaning out the *.asl log files may help speed it up - would you like to move the files to the Trash [y/n]?"
read line
case "$line" in
    n|N) echo "Skipping Terminal cleaning..."
         sleep 2
        ;;
    y|Y) sudo mv /private/var/log/asl/*.asl ~/.Trash
         #sudo rm -rf /private/var/log/asl/*.asl
         #sudo rm -i /private/var/log/asl/*.asl
        ;;
esac
#Xcode DerivedData & Archives (if Xcode exists in /Applications directory)
if [ -d "/Applications/Xcode.app" ]; then
echo "Do you want to clean Xcode DerivedData, Archives, and iOS Device Logs [y/n]?"
read line
case "$line" in
    n|N) echo "Skipping Xcode cleaning..."
         sleep 2
        ;;
    y|Y) echo "cleaning Xcode DerivedData Archives, and iOS Device Logs"
         rm -rf ~/Library/Developer/Xcode/DerivedData/*
         rm -rf ~/Library/Developer/Xcode/Archives/*
	 rm -rf ~/Library/Developer/Xcode/iOS\ Device\ Logs/*
        ;;
esac
fi
#Mail Downloads Attachments
echo "Would you like to delete downloaded Mail attachments [y/n]?"
read line
case "$line" in
    n|N) echo "Skipping removing downloaded Mail attachments..."
         sleep 2
        ;;
    y|Y) rm -rf ~/Library/Containers/com.apple.mail/Data/Library/Mail\ Downloads/*
        ;;
esac
#Permissions Repair (OS X 10.11 gets rid of permission repair)
ver=`sw_vers -productVersion | cut -d "." -f 2`
if (( $ver < 11 )); then
echo "Would you like to Repair your Disk Permissions [y/n]?"
read line
case "$line" in
    n|N) echo "Skipping Disk Permissions Fix..."
         sleep 2
        ;;
    y|Y) sudo diskutil repairPermissions /
        ;;
esac
else
echo ""
fi
#Empty Trash if their are any items in the Trash
if [ "$(ls -A ~/.Trash 2> /dev/null | cut -f1 -d".")" == "" ]; then
echo ""
else
echo "There are items in your Trash, do you want to empty it now [y/n]?"
read line
case "$line" in
    n|N) echo "Skipping Emptying the Trash..."
         sleep 2
        ;;
    y|Y) echo "Emptying the Trash..."
         rm -rf ~/.Trash/*
        ;;
esac
fi
echo "To gain even more free space, download and run Monolingual to remove language packs you don't use from http://ingmarstein.github.io/Monolingual/"

#Calculate used space
ffs=$(df -H / | egrep '/$' | awk '{print $4}' | cut -d "G" -f 1)
echo "Total free space after cleanup is "$ffs"GB"
a="$ifs"
b="$ffs"
tot=`echo "$ffs - $ifs" | bc`
if (( $tot >= 1 )); then
echo "You saved a total of "$tot"GB of space"
else
echo "You saved less than 1GB of space"
fi

#Saving for later...
#fispace=$(df -h | grep -A1 /dev/disk1 | sed -n 1p | awk '{ print $7 }')
#fis="${fispace:0:2}.${fispace:2:2}"
#echo "Total free space after cleanup is "$fis"GB and "$fispace"kb"
#a="$inspace"
#b="$fispace"
#tot=`echo "$b - $a" | bc`
#echo "You saved a total of "$tot"kb of space"
#echo "Before you had "$ins"GB of free space, now you have "$fis"GB free!"
