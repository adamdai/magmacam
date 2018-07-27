from magma import *
from mantle import *

def REG16s(n):
    return [Register(16) for i in range(n)]

def MUX16s(n):
    return [Mux(2,16) for i in range(n)]

def ROM16(logn, init, A):
    n = 1 << logn
    assert len(A) == logn
    assert len(init) == n

    muxs = MUX16s(n-1)
    for i in range(n//2):
        muxs[i](init[2*i], init[2*i+1], A[0])

    k = 0
    l = 1 << (logn-1)
    for i in range(logn-1):
        for j in range(l//2):
            muxs[k+l+j](muxs[k+2*j], muxs[k+2*j+1], A[i+1])
        k += l
        l //= 2

    return muxs[n-2]


def REG8s(n):
    return [Register(8) for i in range(n)]

def MUX8s(n):
    return [Mux(2,8) for i in range(n)]

def ROM8(logn, init, A):
    n = 1 << logn
    assert len(A) == logn
    assert len(init) == n

    muxs = MUX8s(n-1)
    for i in range(n//2):
        muxs[i](init[2*i], init[2*i+1], A[0])

    k = 0
    l = 1 << (logn-1)
    for i in range(logn-1):
        for j in range(l//2):
            muxs[k+l+j](muxs[k+2*j], muxs[k+2*j+1], A[i+1])
        k += l
        l //= 2

    return muxs[n-2]

