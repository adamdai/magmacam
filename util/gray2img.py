import os
import io
import csv
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm
import pandas as pd

data = []

# File should be (320x240) = 76800 bytes long
# expects raw analyzer data from process.UART channel

df = pd.read_csv(r"~/Documents/analyzerdata/numtest3_process.csv", usecols=[1])
for val in df.values[3:76803]:
    data.append(int(', '.join(val), 0))


arr = np.asarray(data).reshape(240, 320)
plt.imshow(arr, cmap=cm.gray)
plt.show()