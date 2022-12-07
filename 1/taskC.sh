#!/bin/bash

sourced=$(pwd)/$1
dest=$(pwd)/$2

for file in $(find $sourced -printf "%P\n") ; do
	if [ -a $dest/$file ] ;
	then 
		if [ -N $sourced/$file ] ; then
			echo "File $file was modified. copying..."
			stat -c ‘%y’ $sourced/$file
			cp -r $sourced/$file $dest/$file
		else
			echo "File $file exists already, skip"
		fi
	else
		echo "New file $file is being copied over to $dest"
		stat -c ‘%y’ $sourced/$file
		cp -r $sourced/$file $dest/$file
	fi
done
for file in $(find $dest -printf "%P\n") ; do
        if [ -a $sourced/$file ] ;
        then
		continue
        else
                echo "$file is being deleted from $sourced"
		stat -c ‘%y’ $sourced/$file
                rm -r  $dest/$file
        fi
done
 

