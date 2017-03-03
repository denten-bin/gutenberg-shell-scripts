#!/bin/sh

# This script will iterate over all files in the current directory to create a
# manifest of documents using the gutenberg.org meta data fields. These
# include file name, title, author, language, and encoding. The output is in
# .csv format.

# write first line to manifest file
echo "file_name, title, author, language" > MANIFEST.csv

# loop through all .txt files in folder
for f in *.txt
do

    # file name, -n for no carriage
    echo -n $f', ' >> MANIFEST.csv

    # append title
    # Title: War and Peace
    # Cut at the colon, return second term, cut initial space, remove punct & carriage
    title=$(grep "Title:" $f | cut -d':' -f2- | sed -e 's/ //' | tr -d \
    "[:punct:]" | tr -d '\r' )

    author=$(grep "Author:" $f | cut -d':' -f2- | sed -e 's/ //' | tr -d \
    "[:punct:]" | tr -d '\r' )

    lang=$(grep "Language:" $f | cut -d':' -f2- | sed -e 's/ //' | tr -d \
    "[:punct:]" | tr -d '\r' )

    echo -n $title', ' >> MANIFEST.csv
    echo -n $author', ' >> MANIFEST.csv
    echo $lang >> MANIFEST.csv

done

echo "MANIFEST.csv created in this directory"
