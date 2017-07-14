#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No filenames supplied. Exiting."
    exit 1
fi

mkdir tostack

filename="$1"

while read -r line
do
    name="$line"
    echo "Searching for $name"
    csvgrep -c 5 -r "(?i)$name" clean.csv | csvcut -c 1 > tostack/$name.csv
done < "$filename"

echo "Done searching. Stacking..."
csvstack tostack/*.csv | sort -u -g > tostack/matches.csv

echo "Joining..."
python join-search-results.py
cleanname=$(echo $1 | cut -f 1 -d '.')
csvcut -c 2-6 search-results.csv > $cleanname.csv

echo "Cleaning up..."
rm search-results.csv
rm -dfr tostack

echo "Results are in" $cleanname".csv."
