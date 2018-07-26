import serial
import time
import sys
#from uart import BAUD_RATE, message

# MODES:
# 1. Display raw image data (RGB), 153600 bytes, cam.UART
# 2. Display grayscale image data, 76800 bytes, 
# 3. DIsplay downscaled binary data, 16 bits

# argument should be something like
# /dev/tty.usbserial-142B
# /dev/ttyUSB1

data = []

with serial.Serial(sys.argv[1], 750000, timeout=1) as ser:
    while True:
        try:
            print(ser.read(), end="\n")

        except UnicodeDecodeError as e:
            print("Experienced {}".format(str(e)))
            print("Possible framing issue, continueing")
