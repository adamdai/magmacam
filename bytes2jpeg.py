import csv
import os
import io
import numpy as np 
import cv2
from PIL import Image

bayer = []

infile = open(os.path.expanduser("~/Documents/arducam_uart_jpegdata3.csv"), "r+")

with infile as csvfile:
	spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
	for row in spamreader:
		bayer.append(int(', '.join(row), 0))

jpeg  = bytearray(bayer)

f = open('/tmp/test_img.jpeg', 'wb')
f.write(jpeg)
f.close()

# print(len(bayer))

# data = bytes(bayer)

# im = Image.frombytes('P', (320, 240), data)
# im.show()

# -----JPEG------ #



# imsize = 320*240
# with infile as rawimage:
#     img = np.fromfile(rawimage, np.dtype('u1'), imsize).reshape((320, 240))
#     colour = cv2.cvtColor(img, cv2.COLOR_BAYER_RG2BGR)

#     cv2.imshow('image',colour)
#     cv2.waitKey(0)
#     cv2.destroyAllWindows()