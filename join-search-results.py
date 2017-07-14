# coding: utf-8
# In[1]:
import pandas as pd
# In[2]:
import numpy as np
# In[3]:
clean = pd.read_csv('clean.csv')
# In[4]:
matches = pd.read_csv('tostack/matches.csv')
# In[5]:
joined = pd.merge(matches,clean,on="line_number")
# In[6]:
joined.to_csv('search-results.csv')
# In[ ]:
