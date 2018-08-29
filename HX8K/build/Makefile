NAME = main
#NAME = RAM_test
#NAME = reduce_test
#NAME = conv_test

PCF = $(NAME).pcf

DEVICE = 8k
QUIET = -q

$(NAME).bin: $(NAME).v $(PCF)
	yosys $(QUIET) -p 'synth_ice40 -top main -blif $(NAME).blif' $(NAME).v
	arachne-pnr $(QUIET) -d $(DEVICE) -o $(NAME).txt -p $(PCF) $(NAME).blif
	icepack $(NAME).txt $(NAME).bin

upload: $(NAME).bin
	iceprog $(NAME).bin

clean:
	rm -f *.bin *.txt *.blif *.rpt

.PHONY: all explain install clean