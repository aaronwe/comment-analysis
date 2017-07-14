#!/bin/bash
#usage: sh random-from-search.sh [number] [file]

if [ $# -eq 0 ]
  then
    echo "No filenames supplied. Exiting."
    exit 1
fi

num=$1
filename=$2
name=$(echo $filename | cut -f 1 -d '.')

# generate random numbers
# how many lines in the file?
echo "Counting rows in" $filename
rows="$(csvstat --count $filename | tr -dc '0-9')"

#renumber the original file
renumbered=$name-renumbered.csv
csvcut -l -c 1-4 $filename > $renumbered

# put num random numbers in a file
printf "Choosing " && printf $num && printf " unique random numbers between 1 and " && printf $rows && printf "...\n"

# start with num * 2, get rid of duplicates, shuffle, use first num, sort, save
echo "line_number" > random-$num.csv
extra=$(expr $num + $num)
#echo $extra
jot -r $extra 1 $rows | sort -u | gshuf | head -n $num | sort -n >> random-$num.csv

# do we have a good list?
csvstat --count random-$num.csv

# match random numbers to full dataset
echo "Matching comments to random numbers..."
python join-then-export-files.py $renumbered random-$num.csv
csvcut -c 2-6 joined.csv > $name-random.csv
#clean up after yourself
rm joined.csv
rm $renumbered
rm random-$num.csv
echo "Done! Selected comments are in" $name"-random.csv."
