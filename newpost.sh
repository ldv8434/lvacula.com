#!/bin/bash

# Get location of script, posts root
parent_path=$(cd "$(dirname "$BASH_SOURCE[0]}")" ; pwd -P)
posts_root="$parent_path/content/posts"

# Get time
year=$(date +%Y)
month=$(date +%m)
day=$(date +%d)

post_name="$year$month$day"
OPTSTRING=":n:"

# Get options 
while getopts ${OPTSTRING} opt; do
	case ${opt} in 
		n)
			post_name=${OPTARG}
			;;
		:)
			echo "Option -${OPTARG} requires an argument"
			exit 1
			;;
		?)
			echo "-n <name> :: post name"
			exit 1
			;;
	esac
done


# Fix post name for filesystem
post_file_name=$(echo $post_name | sed "s/[ _]/-/g" | tr '[:upper:]' '[:lower:]')

# Verify year path
if ! [ -d $posts_root/$year ]; then
	# Create new year 
	mkdir $posts_root/$year
	cp $posts_root/2023/_index.md $posts_root/$year/_index.md
fi

# Verify month path
if ! [ -d $posts_root/$year/$month ]; then
        # Create new year
        mkdir $posts_root/$year/$month
        cp $posts_root/2023/_index.md $posts_root/$year/$month/_index.md
fi

# Create folder for post (in case of images)
mkdir -p "$posts_root/$year/$month/$post_file_name"

# Create template file 
read -r -d '' TEMPLATE << EOF
+++
title = "$post_name"
# description = ""
date = $year-$month-$day
# updated = $year-$month-$day
draft = true
[taxonomies]
tags = []
+++

EOF

# Skip overwrite if exists
if ! [ -f $posts_root/$year/$month/$post_file_name/index.md ]; then
	echo "Creating a new post..."
	echo "$TEMPLATE" >> $posts_root/$year/$month/$post_file_name/index.md
fi

echo "Post file is at $posts_root/$year/$month/$post_file_name/index.md"

# Open vim/vi/nano
if command -v vim &> /dev/null; then
	vim $posts_root/$year/$month/$post_file_name/index.md 
elif command -v vi &> /dev/null; then
	vi $posts_root/$year/$month/$post_file_name/index.md
else 
	nano $posts_root/$year/$month/$post_file_name/index.md
fi 
