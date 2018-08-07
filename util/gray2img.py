import os
import io
import csv
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm

data = []

# File should be (320x240) = 76800 bytes long
infile = open(os.path.expanduser("~/Documents/analyzerdata/fulltest1_process_xt.csv"), "r+")

with infile as csvfile:
	spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
	tmp = ''
	count = 0
	for row in spamreader:
	    data.append(int(', '.join(row), 0))


arr = np.asarray(data).reshape(240, 320)
plt.imshow(arr, cmap=cm.gray)
plt.show()