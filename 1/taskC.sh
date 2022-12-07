#!/bin/bash
PATH=/home/maria/LinuxBash:/home/maria/.nvm/versions/node/v12.18.0/bin:/home/maria/.opam/coreboot/bin:/home/maria/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/maria/homework:/home/maria/LinuxBash


sourced=$(pwd)/$1
dest=$(pwd)/$2

for file in $(find $sourced -printf "%P\n") ; do
	if [ -a $dest/$file ] ;
	then 
		if [ -N $sourced/$file ] ; then
			echo "Newer $file detected. copying..."
			stat -c ‘%y’ $sourced/$file
			cp -r $sourced/$file $dest/$file
		else
			echo "File $file exists. skipping."
		fi
	else
		echo "$file is being copied over to $dest"
		stat -c ‘%y’ $sourced/$file
		cp -r $sourced/$file $dest/$file
	fi
done
for file in $(find $dest -printf "%P\n") ; do
        if [ -a $sourced/$file ] ;
        then
		continue
        else
                echo "$file is being deleted from $source"
		stat -c ‘%y’ $sourced/$file
                rm -r  $dest/$file
        fi
done
 

