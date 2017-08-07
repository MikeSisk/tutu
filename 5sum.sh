#!/bin/bash

declare -a files=( 
	/usr/bin/awk 
	/bin/bash 
	/usr/bin/cksum 
	/usr/bin/cut 
	/usr/bin/du 
	/bin/echo 
	/bin/egrep 
	/usr/bin/find 
	/usr/bin/head 
	/usr/bin/id 
	/bin/ls 
	/bin/netstat 
	/bin/ps 
	/bin/sed 
	/usr/bin/strings 
	/usr/sbin/sshd 
	/usr/bin/top 
	/bin/uname
)

for i in "${files[@]}"
do
    echo "$(/usr/bin/md5ksum $i | sed 's/ .*//') $i"
done

exit 0
