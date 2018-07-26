from magma import *
from mantle import *


# n-bit UART transmitter
def DefineUART(n):
    class _UART(Circuit):
        name = "UART"+str(n)
        IO = ['CLK', In(Clock), 'BAUD', In(Bit), 'DATA', In(Bits(n)), 'LOAD', In(Bit),
              'O', Out(Bit)]
        @classmethod
        def definition(io):
            # create array with LSB first and 0 at end as start bit, we do this
            # by zero extending the value, then reversing it
            u_data = zext(io.DATA, 1)[::-1]

            # shift register to output one bit at a time
            uart = PISO(n+1, has_ce=True)
            uart(1, u_data, io.LOAD)
            wire(io.BAUD, uart.CE)

            wire(uart.O, io.O)
    return _UART


def UART(n, **kwargs):
    return DefineUART(n)(**kwargs)

