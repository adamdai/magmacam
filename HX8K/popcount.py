import magma as m
import mantle
from mantle.lattice.ice40 import SB_LUT4

# 4-bit pop count
class BitCounter4(m.Circuit):
    name = "BitCounter4"
    IO = ['I', m.In(m.Bits(4)), 'O', m.Out(m.Bits(3))]
    @classmethod
    def definition(io):
        lut_list = []
        lut_list.append(SB_LUT4(LUT_INIT=int('0110100110010110', 2)))
        lut_list.append(SB_LUT4(LUT_INIT=int('0111111011101000', 2)))
        lut_list.append(SB_LUT4(LUT_INIT=int('1000000000000000', 2)))
        for i in range(3):
            m.wire(io.I, m.bits([lut_list[i].I0, lut_list[i].I1, lut_list[i].I2, lut_list[i].I3]))
            m.wire(lut_list[i].O, io.O[i])


# 8-bit pop count
class BitCounter8(m.Circuit):
    name = "BitCounter8"
    IO = ['I', m.In(m.Bits(8)), 'O', m.Out(m.Bits(4))]
    @classmethod
    def definition(io):
        counter_1 = BitCounter4()
        counter_2 = BitCounter4()
        m.wire(io.I[:4], counter_1.I)
        m.wire(io.I[4:], counter_2.I)
        adders = [mantle.HalfAdder()] + [mantle.FullAdder() for _ in range(2)]
        for i in range(3):
            m.wire(counter_1.O[i], adders[i].I0)
            m.wire(counter_2.O[i], adders[i].I1)
            if i > 0:
                m.wire(adders[i-1].COUT, adders[i].CIN)
            m.wire(adders[i].O, io.O[i])
        m.wire(adders[-1].COUT, io.O[-1])


# 16-bit pop count
class BitCounter16(m.Circuit):
    name = 'BitCounter16'
    IO = ['I', m.In(m.Bits(16)), 'O', m.Out(m.Bits(5))]
    @classmethod
    def definition(io):
        counter_1 = BitCounter8()
        counter_2 = BitCounter8()
        m.wire(io.I[:8], counter_1.I)
        m.wire(io.I[8:], counter_2.I)
        adders = [mantle.HalfAdder()] + [mantle.FullAdder() for _ in range(3)]
        for i in range(4):
            m.wire(counter_1.O[i], adders[i].I0)
            m.wire(counter_2.O[i], adders[i].I1)
            if i > 0:
                m.wire(adders[i-1].COUT, adders[i].CIN)
            m.wire(adders[i].O, io.O[i])
        m.wire(adders[-1].COUT, io.O[-1])


# pop count
def DefineBitCounter(n):
    if n <= 4:
        return BitCounter4
    elif n <= 8:
        return BitCounter8
    elif n <= 16:
        return BitCounter16
    else:
        return None