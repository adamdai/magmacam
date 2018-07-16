import csv
import os
import io
import numpy as np 
import cv2
from PIL import Image
from PyQt5 import QtGui

# Takes a csv containing RGB565 BMP data and creates a PNG image

data = []

# File should be 2x(320x240) = 153600 bytes long
infile = open(os.path.expanduser("~/Documents/analyzerdata/greyscale_test_img.csv"), "r+")

with infile as csvfile:
	spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
	tmp = ''
	count = 0
	for row in spamreader:
	    data.append(int(', '.join(row), 0))

bmp = bytearray(data)

print(len(data))

Image = QtGui.QImage(bmp, 320, 240, QtGui.QImage.Format_RGB16)

Image.save("test.png","PNG",-1)
