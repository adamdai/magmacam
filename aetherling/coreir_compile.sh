# args:
#  1. json filename (without extension)
#  2. board version / output directory (IceStick or HX8K)
# edit output directory for each user

coreir -i $1.json -o ../$2/build/$1.v -p 'rungenerators,wireclocks-coreir' -n 'aetherlinglib,commonlib,mantle,coreir,global' --load_libs 'aetherlinglib,commonlib'
