#!/bin/bash
# usage sh match-random.sh

#if comments.csv doesn't exist, download it
if [ ! -f comments.csv ]; then
  echo "comments.csv not found, downloading..."
  wget https://github.com/markegge/fr-2017-09490-comments/blob/master/dataset/comments.csv?raw=true -nv --show-progress -O comments.csv
else
  echo "Found comments.csv, not downloading new comments..."
fi

# now clean it and add line numbers
echo "Cleaning comments.csv and adding line numbers..."
csvclean -l comments.csv && mv comments_out.csv clean.csv

# print a reality check
echo "Column list: "
csvstat -n clean.csv

# generate random numbers
sh generate-random.sh 1000 clean.csv

# match random numbers to full dataset
echo "Matching comments to random numbers..."
python join-then-export-files.py clean.csv random-1000.csv
csvcut -c 2-6 joined.csv > export-1000-random.csv
echo "Cleaning up..."
rm joined.csv
rm random-1000.csv
echo "Done! Selected comments are in export-1000-random.csv."
