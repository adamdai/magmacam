# magmacam
coreir -i stencil.json -o stencil.v -p 'rungenerators,wireclocks-coreir,verifyconnectivity-noclkrst,flattentypes,flatten,verifyconnectivity-noclkrst,deletedeadinstances' -n 'aetherlinglib,commonlib,mantle,coreir,global' --load_libs 'libcoreir-aetherlinglib.so,libcoreir-commonlib.so'
