#!/bin/sh

# "set -e" is short for "set -o errexit", that is, abort the script if a
# command returns with a non-zero exit code.

# "set -u" is short for "set -o nounset", that is, abort the script if a
# variable name is dereferenced when the variable hasn't been set.ty

set -eu

# A rudimentary script that attempts to remove Gutenberg heads and tails for
# every file in the current directory and place them in a new directory.

newdir='chop-head-tail'

# make folder for new files
if [ ! -d "$newdir" ]
then
    mkdir "$newdir"
fi

# loop through all .txt files in folder
for f in *.txt
do

    # chop head to title sed 1,/STRING/d
    # extra six lines at the end to catch random exclaimers

    sed -e '1,/PROJECT GUTENBERG/d
    /End of the Project Gutenberg/,$d
    /End of Project Gutenberg/,$d
    /END OF THIS PROJECT GUTENBERG/,$d
    /END OF THE PROJECT GUTENBERG/,$d' "$f" |\
    sed -e '1,6d' > "$newdir"/"$f"c

done
