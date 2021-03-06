# !/bin/sh -eu

# "set -e" is short for "set -o errexit", that is, abort the script if a
# command returns with a non-zero exit code.

# "set -u" is short for "set -o nounset", that is, abort the script if a
# variable name is dereferenced when the variable hasn't been set.ty

# This script will iterate over all files in the current directory to create a
# manifest of documents using the gutenberg.org meta data fields. These
# include file name, title, author, and language. The output is in .csv
# format.

# write first line to new manifest file
echo "file_name, title, author, language" > MANIFEST.csv

# loop through all .txt files in folder
for f in *.txt
do

    # Title: War and Peace
    # Cut at the colon, return second term, cut initial space, remove punct & carriage
    title=$(grep "Title:" "$f" | cut -d':' -f2- | sed -e 's/ //' | tr -d \
    "[:punct:]" | tr -d '\r' )

    author=$(grep "Author:" "$f" | cut -d':' -f2- | sed -e 's/ //' | tr -d \
    "[:punct:]" | tr -d '\r' )

    lang=$(grep "Language:" "$f" | cut -d':' -f2- | sed -e 's/ //' | tr -d \
    "[:punct:]" | tr -d '\r' )

    # %s for no carriage
    # printf is more portable than echo
    # redirect once with grouping
    {
        printf "%s" "$f"', '
        printf "%s" "$title"', '
        printf "%s" "$author"', '
        echo "$lang"
    } >> MANIFEST.csv

done

echo "MANIFEST.csv created in this directory"
