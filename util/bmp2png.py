import csv
import os
import io
import numpy as np 
import cv2
from PIL import Image
from PyQt5 import QtGui
import pandas as pd

# Takes a csv containing RGB565 BMP data and creates a PNG image

data = []

# File should be 2x(320x240) = 153600 bytes long
# expects raw analyzer data from cam.UART channel


df = pd.read_csv(r"~/Documents/analyzerdata/numtest3_cam.csv", usecols=[1])
for val in df.values[3:153603]:
    data.append(int(', '.join(val), 0))

bmp = bytearray(data)

print(len(bmp))

Image = QtGui.QImage(bmp, 320, 240, QtGui.QImage.Format_RGB16)

Image.save("../images/test.png","PNG",-1)
