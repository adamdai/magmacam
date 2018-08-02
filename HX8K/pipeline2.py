import magma as m
import mantle 
import math
import pickle
from mantle.lattice.ice40 import ROMB, SB_LUT4
from mantle.util.edge import falling, rising

image_id = 9
num_cycles = 16
num_classes = 10
# operand width
N = 16
# number of bits for num_cycles
n = int(math.ceil(math.log2(num_cycles)))
# number of bits for num_classes
b = int(math.ceil(math.log2(num_classes)))
# number of bits for bit counter output
n_bc = int(math.floor(math.log2(N))) + 1
# number of bits for bit counter output accumulator
n_bc_adder = int(math.floor(math.log2(N*num_cycles))) + 1


# read weight and images
# weight matrix is of image_size x num_classes, here is 10 x 256, each is 1 bit
# image vector is of image_size, here is 256, each is 1 bit
filename = 'nn_train/BNN.pkl'
with open(filename, 'rb') as input_file:
    checkpoint = pickle.load(input_file)
# weights is ndarray of size 10 (rows) x 256 / 16 = 160, each entry standing for 16 bits
weights = checkpoint['weights_int16']
weights_f = weights.flatten()
# weight_list is list of size 160, each entry standing for 16 bits
weights_list = weights_f.tolist()
# weight_list is list of size 256, each entry standing for 16 bits
for i in range(256 - len(weights_list)):
    weights_list.append(0)
# imgs is ndarray of size 10 (images) x 16 x 16 / 16 = 160, each entry standing for 16 bits
imgs = checkpoint['imgs_int16']
imgs_f = imgs.flatten()
# imgs_list is list of size 160, every 16 entries standing for one image
imgs_list = imgs_f.tolist()
#print(imgs)