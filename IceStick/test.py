from magma import *
set_mantle_target("ice40")
from mantle import *
from rom import ROM8, ROM16
from mantle.lattice.ice40 import ROMB, SB_LUT4
from mantle.util.edge import falling, rising
from loam.boards.icestick import IceStick


img_list = [0, 0, 0, 0, 0, 3696, 7152, 6616, 4120, 12312, 12312, 8192, 0, 0, 0, 0]
num_data = [uint(img_list[i], 16) for i in range(16)]

@cache_definition
def DefAdd(n):
    class Sad(Circuit):
        T = Bits(n)
        args = ["I0", In(T), "I1", In(T), "O", Out(T)]
        name = 'Sad'
        IO = args
        @classmethod
        def definition(io):
            def f(y):
                return FullAdder()

            sad = braid( col(f, n), foldargs={"CIN":"COUT"})

            wire(io.I0, sad.I0)
            wire(io.I1, sad.I1)
            wire(sad.O, io.O)
    return Sad



icestick = IceStick()
#icestick.Clock.on()
for i in range(3):
    icestick.J3[i].output().on()


main = icestick.main()


test = DefAdd(3)()

a = bits(0,3)
b = bits(2,3)

wire(a, test.I0)
wire(b, test.I1)
wire(test.O[0], main.J3[0])
wire(test.O[1], main.J3[1])
wire(test.O[2], main.J3[2])