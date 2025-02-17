#!/bin/bash

# Get location of script, posts root
parent_path=$(cd "$(dirname "$BASH_SOURCE[0]}")" ; pwd -P)
posts_root="$parent_path/content/posts"
shortnotes_root="$parent_path/content/shortnotes"

# Get time
year=$(date +%Y)
month=$(date +%m)
day=$(date +%d)

post_name="$year$month$day"
OPTSTRING=":n:s"

shortnotestag=""
shortnote=false

# Get options 
while getopts ${OPTSTRING} opt; do
	case ${opt} in 
		n)
			post_name=${OPTARG}
			;;
		s)
			shortnote=true
			shortnotestag="\"shortnotes\""
			posts_root=$shortnotes_root
			;;
		
		:)
			echo "Option -${OPTARG} requires an argument"
			exit 1
			;;
		?)
			echo "-n <name> :: post name"
			echo "-s        :: create post as shortnote"
			exit 1
			;;
	esac
done


# Fix post name for filesystem
post_file_name=$(echo $post_name | sed "s/[ _,]/-/g" | tr '[:upper:]' '[:lower:]')

post_path="$posts_root/$post_file_name"

if [[ $shortnote == false ]] ; then
	# Verify year path
	if ! [ -d $posts_root/$year ]; then
		# Create new year 
		mkdir $posts_root/$year

		read -r -d '' TEMPLATE << EOF
+++
title = "$year"
sort_by = "date"
template = "posts.html"
page_template = "post.html"
transparent = true
+++

Posts

EOF

		echo "$TEMPLATE" >> $posts_root/$year/_index.md
	fi

	# Verify month path
	if ! [ -d $posts_root/$year/$month ]; then
		# Create new year
		mkdir $posts_root/$year/$month
		read -r -d '' TEMPLATE << EOF
+++
title = "$year-$month"
sort_by = "date"
template = "posts.html"
page_template = "post.html"
transparent = true
+++

Posts

EOF

		echo "$TEMPLATE" >> $posts_root/$year/$month/_index.md
	fi

	post_path="$posts_root/$year/$month/$post_file_name"
fi

echo $post_file_name
echo $post_path

# Create folder for post (in case of images)
mkdir -p "$post_path"


# Create template file 
read -r -d '' TEMPLATE << EOF
+++
title = "$post_name"
# description = ""
date = $year-$month-$day
# updated = $year-$month-$day
#draft = true
[taxonomies]
tags = [$shortnotestag]
+++

EOF

# Skip overwrite if exists
if ! [ -f $post_path/index.md ]; then
	echo "Creating a new post..."
	echo "$TEMPLATE" >> $post_path/index.md
fi

echo "Post file is at $post_path/index.md"

# Open vim/vi/nano
if command -v vim &> /dev/null; then
	vim $post_path/index.md 
elif command -v vi &> /dev/null; then
	vi $post_path/index.md
else 
	nano $post_path/index.md
fi 
