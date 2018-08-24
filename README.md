This repo contains applications and demos for embedded FPGA systems developed using the [magma HDL](https://github.com/phanrahan/magma).

Here is a breakdown of the various directories.

(32x32 vs 16x16)
-tf_size (arducam)
-rescale vs rescale32
-I2C regs


## IceStick/HX8K
This directory contains Magma programs written for the Lattice ICE40 IceStick architecture (either the IceStick or the HX8KBoard). They consist of modules (high-level circuits) that perform a specific function and link together to form a contiguous pipeline for capturing, processing, and classifying handwritten digits, and unit tests for some of these modules to test their functionality standalone.

### arducam.py
A magma module which exposes the SPI interface of an ArduCAM Mini 2MP  peripheral for initiating a capture and receiving image data. 

The module has three phases or states: a capture command phase, a wait phase, and a burst read phase. During the capture command phase, the programs steps through a set of 2-byte commands consisting of a register and value, which are pre-loaded in ROM during initialization, and sends them to the ArduCAM over the MOSI line. When the ArduCAM slave received these commands, it initiates a capture, and the program goes into the wait phase, continually checking the MISO line for the capture completion flag to be set. Once the flag is read as set, the program sends the burst read command to the ArduCAM, then proceeds to contiually read image data from the MISO line.

In order to initialize the ArduCAM for operation, as Raspberry Pi Model A+ is used. The library https://github.com/ArduCAM/RaspberryPi is installed and the `arducam_ov2640_capture.c` is modified to set the capture format to BMP instead of JPEG. Now, everytime the ArduCAM is first powered up, the `ov2640_capture` program must be run to properly initialize the I2C registers. A way to setup the ArduCAM so it may be used standalone with the FPGA is to first power the ArduCAM with the FPGA, connect the remaining SPI and I2C headers to the appropriate GPIO on the Raspberry Pi, and also connect the grounds of the FPGA and Pi. Then, run `ov2640_capture` to initialize the camera settings and now the I2C connections may be disconnected and the SPI connections wired to the FPGA's GPIOs.

Here are the pin mappings for the ArduCAM / Raspberry Pi interface
```
ArduCAM           Raspberry Pi 
CS                pin 11
MOSI              pin 19
MISO              pin 21
SCK               pin 23
GND               pin 6, 9
VCC               pin 1
SDA               pin 3
SCL               pin 5
```

Currently the I2C registers of the ArduCAM are configured for a 320x240 BMP capture, and thus the image data send over the MISO line consists of 153600 bytes (2 bytes per pixel, 320x240 = 76800 pixels). The 2 byte, 16-bit pixels are formatted as RGB565, where the red, green, and blue values are allocated 5, 6, and 5 bits respectively. 

### process.py
A magma module which processes RGB pixel data converting it to grayscale values. It is designed to accept 2 bytes of pixel data at a time from the arducam module output, then interprets it as an 16-bit RGB565 pixel and extracts the red, green, and blue color values and sums them obtain a grayscale value for that pixel. These grayscale values range from 0 to a maximum of 31 + 63 + 31 = 125. 

### rescale.py
This magma module takes grayscale image data output from the process module, and resizes the image to scale it down, while also converting it to binary. It first makes use of the `downscale` aetherling module (more details below), to map over the 320x240 image with a 20x15 sliding window, summing the pixel values in each window to downscale to a 16x16 image. Then a binary threshold is applied so that pixels below a certain value are binarized to 0 and one above at set to 1. This produces a 16x16 binary version of the original 320x240 RGB image captured by the ArduCAM.

### pipeline.py
BNN digit classifier adapted from https://github.com/MIT-HAN-LAB/BNN_IceStick.
Instead of the loading the image into ROM at initialization time, the circuit
has a RAM for storing image bits so that the input of the BNN may be wired to
another circuit (e.g. the output of the ArduCAM).

The network consists only of a single fully connected layer. It flattens the 16x16 image into a size 256 vector and dots it with 10 (number of classes) size 256 weight vectors. The multiply-accumulate operation of the dot product is computed using an XNOR followed by a popcount in order to take advantage of the binary nature of the data. The results of the veector product are succesively compared to each other in order to determine the maximum, which is then chosen as the output of the classifer.

### main.py
The main program which defines a top level module (`main`).  It uses the
ArduCAM circuit (defined in `arducam.py`), which exposes the SPI interface of
an ArduCAM Mini 2MP peripheral for initiating a capture and receiving image
data, and the Process circuit (defined in `process.py`), which processes RGB
pixel data converting it to grayscale values. 

**TODO:** It would be good to document how to run these tests (using the logic
analyzer?) Also, maybe these should be moved to a `tests` directory. We could
also consider writing some tests for these using the Python or CoreIR
simulator, so we could run them on Travis.
### stencil.py
Test program for the STEN aetherling module (see below).

### downscale_test.py
Test program to downscale a 320x240 ArduCAM image to a 16x16 using the
Downscale aetherling module. Currently too large to run on the IceStick.

### RAM_test.py
Test program which feeds an image stored in ROM to the RAM in the `pipeline.py`
circuit and runs the BNN classifier. Can be used to test the BNN on a custom image. 

## aetherling
This folder contains high level magma circuits defined using the [aetherling
library](https://github.com/David-Durst/aetherling). It contains the STEN
module (in `test_linebuffer.py`) which downscales a 4x4 image to a 2x2 using a
window size of 2x2 and summing over the pixel values in each window to obtain
each new output pixel value, 
(**TODO:** Should this average the pixels? Are they grayscale?)
and the Downscale module (in`downscale.py`) which
is designed to downscale a 320x240 image (taken by the ArduCAM) to a 16x16 (to
feed into the BNN classifier) using a window size of 20x15. 

## util
This folder contains some miscellaneous python scripts. `bmp2png.py` creates a
png image from a csv file of 16-bit RGB pixel values (as bytes),
`bytes2jpeg.py` creates a jpg image from a a csv of raw JPEG bytes, and
`gray2img.py` displays a grayscale image from a csv file of grayscale values.
`monitor.py` is a simple program to receive UART data from the IceStick.
(**TODO:** Would be good to note what these are used for, such as example use
case. E.g. the bmp2png can be used with the logic analyzer)
