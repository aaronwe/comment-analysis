# comment-analysis
For [analyzing comments submitted to regulations.gov](https://medium.com/westwise/america-to-trump-and-zinke-dont-touch-national-monuments-8f4b40c43599).

Yes, this is a bit messy and could get a whole lot cleaner if we used this all the time. It's basically a one-off, so it's not the cleanest bit of scripting you've ever seen. I'd probably build the whole thing in Python/Pandas if I had to do it again, but csvkit and bash get the job done. Searching is significantly slower than if you used Pandas, however.

## Prerequisites
- [Jupyter Notebook](https://jupyter.org) (Highly recommend using virtual environments. `pip install jupyter` if you're already using Python)
- [Pandas](http://pandas.pydata.org/) (`pip install pandas`)
- markegge's [get-comments-with-api](https://github.com/markegge/fr-2017-09490-comments/blob/master/get-comments-with-api.ipynb) notebook
- [csvkit](https://csvkit.readthedocs.io/en/1.0.2/) (`pip install csvkit`)
- jot (included in MacOS, must [compile from source](http://unix.ittoolbox.com/groups/technical-functional/shellscript-l/jot-on-linux-4025237) on other platforms. Alternately, use another random number generator in line 18 of generate-random.sh.)
- GNU core utilities (included in Linux, must install on MacOS using `brew install coreutils`)

## Step-by-step
1. Run [get-comments-with-api](https://github.com/markegge/fr-2017-09490-comments/blob/master/get-comments-with-api.ipynb) from Jupyter Notebook to download the full comment set. (Alternately, export the notebook to a .py file and run that from the command line.) Note that you [need an API key from data.gov](https://regulationsgov.github.io/developers/key/) to download all the comments.
1. Copy comments.csv into your working directory.
1. Run `sh match-random.sh` to clean comments.csv and pick 1000 random comments from it.
1. Run `sh search-comments.sh utah-residents.txt` to find *possible* comments from Utah residents (output is in utah-residents.csv)
1. Run `sh random-from-search.sh 1000 utah-residents.csv` to pick 1000 random comments.
1. Import `export-1000-random.csv` and `utah-residents-random.csv` into a spreadsheet (we used Google Docs for simultaneous editing) and code each comment by hand.

## Notes
- If you just want to search the comment set for a bunch of terms, first generate a `clean.csv` file: `csvclean -l comments.csv && mv comments_out.csv clean.csv`
- Then put your search terms into a .txt file, one term per line. (csvgrep uses [regex](https://regex101.com), so terms like `liv(e|ed|ing) in utah` will find people who live, lived, or are living in Utah. `, utah (\d*)` finds digits (like a zip code) after comma-space-utah.)
- run `sh search-comments.sh [myfile.txt]` to search clean.csv for all the terms in your text file. Output will be in `[myfile].csv`.
