#!/bin/sh

# This script will remove all Gutenberg heads and tails for every file in the
# current directory and place them in a new directory

newdir='chop-head-tail'

# make folder for new files
if [ ! -d "$newdir" ]
then
    mkdir "$newdir"
fi

# loop through all .txt files in folder
for f in *.txt
do

    # chop head sed 1,/STRING/d
    # chop tail sed /STRING/,$d

    # notes from stackoverflow.com/questions/7103531/
    # 1,/TERMINATE/ is an address (line) range selection meaning the first
    # line for the input to the 1st line matching the regular expression
    # between //, and d is the delete command which delete the current line
    # and skip to the next line. As sed default behavior is to print the
    # lines, it will print the lines after /EXPRESSION/ to the end of input.

    # This will print from the line that follows the line matching
    # /EXPRESSION/ till the end of the file: (from AFTER the matching line to
    # EOF, NOT including the matching line)

    sed -e '1,/START OF/d' "$f" | \
    sed -e '/End of the Project Gutenberg/,$d' | \
    sed -e '/END OF THIS PROJECT GUTENBERG/,$d' | \
    sed -e '/END OF THE PROJECT GUTENBERG/,$d' \
    > "$newdir"/"$f"c

    # encountered tails
    # End of the Project Gutenberg EBook of Mansfield Park, by Jane Austen
    # *** END OF THIS PROJECT GUTENBERG EBOOK MANSFIELD PARK ***
    # ***END OF THE PROJECT GUTENBERG EBOOK BLEAK HOUSE***

    # encountered headers
    # ***START OF THE PROJECT GUTENBERG EBOOK BLEAK HOUSE***
    # *** START OF THIS PROJECT GUTENBERG EBOOK PERSUASION ***
done

