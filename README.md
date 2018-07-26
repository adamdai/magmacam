This repo contains applications and demos for embedded FPGA systems developed using the magma HDL (https://github.com/phanrahan/magma).
## IceStick
Magma programs written for the Lattice ICE40 IceStick architecture.
### main
Main program in which top level modules are defined are wired together. Currently uses the ArduCAM circuit (defined in `arducam.py`), which exposes the SPI interface of an ArduCAM Mini 2MP peripheral for initiating a capture and receiving image data, and the Process circuit (defined in `process.py`), which processes RGB pixel data converting it to grayscale values.
### pipeline
BNN digit classifier taken from https://github.com/MIT-HAN-LAB/BNN_IceStick with some modifications. 

## aetherling
This folder contains high level magma circuits defined using the aetherling library (https://github.com/David-Durst/aetherling) 

