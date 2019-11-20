#!/bin/bash

#
##
## Name: getmygithub
## 
## Author: Dr M. GUEDJ
##
##
## Description: 
##	
##    Usage: getmygithub <user>"
##    --> clone all github reposistories from <user>"
##    ____ inside the directory \"archives__github__<user>\"."
##    ____ !: There must beforehand exist a \"github__<user>.txt\" file"
##    ____ ____ inside the working directory;" 
##    ____ ____ this file contains each github repository" 
##    ____ ____ that one wants to download."
##   
##
## Version: 0.3
##
## Date: 20/11/2019
##
## License: MIT LICENSE 
## -- see the file MIT-LICENSE.txt
##


tput setaf 12; # one uses the blue color 

function usage 
{
	tput setaf 6; # color: some sort of green 
	echo "Usage: getmygithub <user>"
	echo "--> clone all github reposistories from <user>"
	echo "____ inside the directory \"archives__github__<user>\"."
	echo "____ !: There must beforehand exist a \"github__<user>.txt\" file"
	echo "____ ____ inside the working directory;" 
	echo "____ ____ this file contains each github repository" 
	echo "____ ____ that one wants to download."

	exit 1
}


if [ $# = 0 ]
then
	tput setaf 9; # red color 
	echo "!: One argument is required."
	usage
fi

user=$1

if [ ! -e "github__$user.txt" ]
then
	tput setaf 9; # red color 
	echo "!: the file \"github__$user.txt\" does not exist." 
	usage
fi

# case where "archives__github__$user" already exists
if [ -e "archives__github__$user" ]
then 
	if [ ! -e "_backups" ]
	then 
		mkdir "_backups"
	fi
	if [ -e "_backups/archives__github__$user" ]
	then
		rm -fr "_backups/archives__github__$user" 
	fi
	mv -f "archives__github__$user" "_backups"
fi


mkdir "archives__github__$user"
mv "github__$user.txt"  "archives__github__$user"
cd "archives__github__$user"


for x in $(cat "github__$user.txt")
do
	echo "get $x from github.com/$user..."
	git clone "https://github.com/$user/$x"
	tput setaf 10; echo -e "\t\t\t\t\t\t [OK]"   # echo in color "light green"
	tput setaf 12; # goes back to the blue color 
done


