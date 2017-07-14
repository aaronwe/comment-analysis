# coding: utf-8
#import libraries
import sys
import pandas as pd
import numpy as np

# first command line argument is filename
filename = sys.argv[1]
random = sys.argv[2]
clean = pd.read_csv(filename)

#needs random.csv with random line numbers
random = pd.read_csv(random)

#merge the random numbers and dataset
joined = pd.merge(random,clean,on="line_number")

#export to csv
joined.to_csv('joined.csv')
