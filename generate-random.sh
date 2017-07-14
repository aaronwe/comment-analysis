#!/bin/bash
# usage: sh generate-random.sh [number] [filename]

num=$1
filename=$2

# how many lines in clean.csv
echo "Counting rows in" $filename
rows="$(csvstat --count $filename| tr -dc '0-9')"

# put 2000 random numbers in a file
printf "Choosing " && printf $num && printf " unique random numbers between 1 and " && printf $rows && printf "...\n"

# start with 2500, get rid of duplicates, shuffle, use first 2000, sort, save
echo "line_number" > random-$num.csv
extra=$(expr $num + $num)
#if you don't have OS X, compile jot from source or use a differen random number generator.
#on linux, use shuf instead of gshuf.
jot -r $extra  1 $rows | sort -u | gshuf | head -n $num | sort -n >> random-$num.csv

# do we have a good list?
csvstat --count random-$num.csv
