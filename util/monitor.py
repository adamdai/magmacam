import serial
import time
import sys
import io
import struct

# MODES:
# 1. Display raw image data (RGB), 153600 bytes, cam.UART
# 2. Display grayscale image data, 76800 bytes, 
# 3. DIsplay downscaled binary data, 16 bits

# argument should be something like
# /dev/tty.usbserial-142B
# /dev/ttyUSB1

# on Linux 
# $ sudo /home/adam/miniconda3/bin/python monitor.py /dev/ttyUSB1

data = []

with open('../logs/UART.txt', 'w') as f:

    with serial.Serial(sys.argv[1], 750000, timeout=1) as ser:
        while True:
            try:
                #data = ser.read(1).hex()
                val = struct.unpack("<h", ser.read(2))[0]
                print(val, end="\n")
                #f.write(data+'\n')

            except UnicodeDecodeError as e:
                print("Experienced {}".format(str(e)))
                print("Possible framing issue, continueing")
