This repo contains applications and demos for embedded FPGA systems developed using the magma HDL (https://github.com/phanrahan/magma).

## IceStick
Magma programs written for the Lattice ICE40 IceStick architecture.

### main.py
Main program in which top level modules are defined are wired together. Currently uses the ArduCAM circuit (defined in `arducam.py`), which exposes the SPI interface of an ArduCAM Mini 2MP peripheral for initiating a capture and receiving image data, and the Process circuit (defined in `process.py`), which processes RGB pixel data converting it to grayscale values.

### pipeline.py
BNN digit classifier taken from https://github.com/MIT-HAN-LAB/BNN_IceStick with some modifications. Instead of the loading the image into ROM in initialization, the circuit has a RAM for storing image bits so that the input of the BNN may be wired to another circuit (e.g. the output of the ArduCAM).

### stencil.py
Test program for the STEN aetherling module (see below).

### downscale_test.py
Test program to downscale a 320x240 ArduCAM image to a 16x16 using the Downscale aetherling module. Currently too large to run on the IceStick.

### RAM_test.py
Test program which feeds an image stored in ROM to the RAM in the `pipeline.py` circuit and runs the BNN classifier.

## aetherling
This folder contains high level magma circuits defined using the aetherling library (https://github.com/David-Durst/aetherling). Currently contains the testcircuit/STEN module (in `test_linebuffer.py`) which downscales a 4x4 image to a 2x2 using a window size of 2x2 and summing over the pixel values in each window to obtain each new output pixel value, and the Downscale module (in`downscale.py`) which is designed to downscale a 320x240 image (taken by the ArduCAM) to a 16x16 (to feed into the BNN classifier) using a window size of 20x15. 

## util
This folder contains some miscellaneous python scripts. `bmp2png.py` creates a png image from a csv file of 16-bit RGB pixel values (as bytes), `bytes2jpeg.py` creates a jpg image from a a csv of raw JPEG bytes, and `gray2img.py` displays a grayscale image from a csv file of grayscale values. `monitor.py` is a simple program to receive UART data from the IceStick.
