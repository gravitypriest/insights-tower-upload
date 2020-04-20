#!/bin/bash

verbose=""
default_content_type="application/vnd.redhat.tower.test+tgz" # subject to change, don't know tower's type

help_me() {
	echo "Usage: $0 -u USERNAME -p PASSWORD -f FILE -c CONTENT-TYPE"
	echo -e "\t-u USERNAME\tRed Hat Customer Portal username"
	echo -e "\t-p PASSWORD\tRed Hat Customer Portal password (optional, can input interactively)"
	echo -e "\t-f FILE\t\tFile to upload"
	echo -e "\t-c CONTENT-TYPE\tContent-type of the file (optional, defaults to $default_content_type)"
	echo -e "\t-v\t\tGet verbose output from curl"
	echo -e "\t-h\t\tPrint this help message"
}

while getopts "u:p:f:c:vh" o
do
	case "$o" in
		u ) user="$OPTARG" ;;
		p ) pass="$OPTARG" ;;
		f ) file="$OPTARG" ;;
		c ) content_type="$OPTARG" ;;
		v ) verbose=' -v' ;;
		h ) help_me; exit 0 ;;
		? ) help_me; exit 1 ;;
	esac
done

if [ -z "$user" ]
then
	echo "Error: Missing authentication username."
	help_me; exit 1
fi

if [ -z "$file" ]
then
	echo "Error: Missing file to upload."
	help_me; exit 1
fi

if [ -z $content_type ]
then
	content_type="$default_content_type"
fi

user_arg_string="$user"
if [ "$pass" ]
then
	# add password to arg if specified
	user_arg_string="$user:$pass"
fi

# send curl output to stderr, but write http status to stdout so we can check it
http_status=$(curl -u "$user_arg_string" -X POST https://cloud.redhat.com/api/ingress/v1/upload -F "file=@$file;type=$content_type" -o /dev/stderr --write-out "%{http_code}" $verbose)

if [ "$http_status" == "202" ]
then
	echo "Upload successful."
	exit 0
else
	echo "Upload failed. HTTP code: $http_status"
	exit 1
fi