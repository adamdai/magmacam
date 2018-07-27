import magma as m
import mantle


# n-bit UART transmitter
def DefineUART(n):
    class _UART(m.Circuit):
        name = "UART"+str(n)
        IO = ['CLK', m.In(m.Clock), 'BAUD', m.In(m.Bit),
              'DATA', m.In(m.Bits(n)), 'LOAD', m.In(m.Bit),
              'O', m.Out(m.Bit)]

        @classmethod
        def definition(io):
            # create array with LSB first and 0 at end as start bit, we do this
            # by zero extending the value, then reversing it
            u_data = m.zext(io.DATA, 1)[::-1]

            # shift register to output one bit at a time
            uart = mantle.PISO(n+1, has_ce=True)
            uart(1, u_data, io.LOAD)
            m.wire(io.BAUD, uart.CE)

            m.wire(uart.O, io.O)
    return _UART


def UART(n, **kwargs):
    return DefineUART(n)(**kwargs)
