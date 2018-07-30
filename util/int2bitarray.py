import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm

#img_list = [0,0,0,0,0,15840,32752,16176,816,1008,480,0,0,0,0,0] #9, last col->first col
#img_list = [0,0,0,0,960,2016,1632,1632,2016,960,224,224,224,224,64,0] #9, first row->last row
img_list = [0,0,0,896,984,3680,7216,6204,14456,14448,8160,3840,0,0,0,0] #0

bmp = []
for n in img_list:
    row = [1 if digit=='1' else 0 for digit in '{0:016b}'.format(n)]
    bmp.append(row)

arr = np.asarray(bmp)
transformed = np.flip(np.rot90(arr), 1)

# display original array
print(arr)
# plt.imshow(arr, cmap=cm.gray)
# plt.show()

# convert other form
new_list = []
for row in transformed:
    print(row)
    out = 0
    for bit in row:
        out = (out << 1) | bit
    new_list.append(out)

print(new_list)

