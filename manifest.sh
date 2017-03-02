#!/bin/sh

# This script will iterate over all files in the current directory to create a
# manifest of documents using the gutenberg.org meta data fields. These
# include file name, title, author, language, and encoding. The output is in
# .csv format

# write first line to manifest file
echo "file_name, title, author, language, encoding" > MANIFEST.csv

# loop through all .txt files in folder
for f in *.txt
do

    # file name
    echo $f >> MANIFEST.csv

    # add comma
    echo ',' >> MANIFEST.csv

    # append title
    # Title: War and Peace
    # Cut at the colon, return second term, cut space
    grep "Title:" $f | cut -d':' -f2- | sed -e 's/ //' >> MANIFEST.csv

done

echo "MANIFEST.csv created in this directory"
