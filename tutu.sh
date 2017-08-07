#!/bin/bash

# tutu.sh is a simple intrusion detection system (IDS) that does a file
# intregtity check by comparing checksums of selected system files against
# a remote http database.

# The 'OS' directive allows support for multiple OS versions. For example:
# you might have some machines running Ubuntu 10.04 'Lucid' and others on
# Debian "Squeeze". With the appropiate configuration here and on the remote
# http database you can support all the things. 

OS='lucid'
IDS_DATABASE='http://ids.example.com'

# Let's put all the files we want to check into this array. This list
# includes the basic utilites you need to see if you've been rooted.
# These are the most common ones that nefarious folks modify or replace 
# when you've been compromised. There's others and you might have other 
# stuff you want to watch. Just add 'em here.

declare -a files=( 
	/usr/bin/awk 
	/bin/bash 
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

# This interates though the file array and does an md5sum of each and 
# an equality check with pre-calculated checksums stored in a simple 
# plain-text database on a remote http server.

# If the checksums don't match an error message is sent to stdout. 

for i in "${files[@]}"
do
	if [[ $(/usr/bin/md5sum $i | sed 's/ .*//') != $(curl -s "$IDS_DATABASE/$OS/$i") ]]; then
		echo "BARK! $i md5 checksum fails!"
	fi
done

exit 0
