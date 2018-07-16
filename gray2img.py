import os
import io
import csv
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm

data = []

# File should be 2x(320x240) = 153600 bytes long
infile = open(os.path.expanduser("~/Documents/analyzerdata/greyscale_test_grey.csv"), "r+")

with infile as csvfile:
	spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
	tmp = ''
	count = 0
	for row in spamreader:
	    data.append(int(', '.join(row), 0))


#img = Image.open('image.tiff')
arr = np.asarray(data).reshape(240, 320)
plt.imshow(arr, cmap=cm.gray)
plt.show()