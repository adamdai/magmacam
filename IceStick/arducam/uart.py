from magma import *
from mantle import *

__all__  = ['DefineUART', 'UART']


#
# 8-bit UART TX module
#
# D : In(Bits(8)), V : In(Bit), DIV : In(Bits(16)), O : Out(Bit)
#
@cache_definition
def DefineUART(n, init=0, has_ce=False, has_reset=False):

    class _UART(Circuit):
        name = _RegisterName('UART', n, init, has_ce, has_reset)
        IO = ['D', In(Bits(8)), 'V', In(Bit), 'DIV', In(Bits(16)),
              'O', Out(Bit)] + ClockInterface(has_ce,has_reset)
        @classmethod
        def definition(uart):


            clock = CounterModM(uart.DIV, 8)
            baud = clock.COUT

            counter = Counter(4, has_ce=True, has_reset=True)
            count = counter.O
            done = Decode(15, 4)(count)

            run = DFF(has_ce=True)
            run_n = LUT3([0,0,1,0, 1,0,1,0])
            run_n(done, uart.V, run)
            run(run_n)
            wire(baud, run.CE)

            reset = LUT2(I0&~I1)(done, run)
            counter(CE=baud, RESET=reset)

            shift = PISO(9, has_ce=True)
            load = LUT2(I0&~I1)(uart.V,run)
            shift(1,uart.D,load)
            wire(baud, shift.CE)

            ready = LUT2(~I0 & I1)(run, baud)
            wire(ready, printf.CE)

    return _UART

def UART(n, init=0, has_ce=False, has_reset=False, **kwargs):
    return DefinePISO(n, init, has_ce, has_reset)(**kwargs)

