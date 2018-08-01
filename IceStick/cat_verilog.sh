#cat build/stencil.v build/linebuffer.v > build/temp.v
#cat build/temp.v > build/stencil.v

#cat build/downscale_test.v build/downscale.v > build/temp.v
#cat build/temp.v > build/downscale_test.v

cat build/reduce_test.v build/reducehybrid.v > build/temp.v
cat build/temp.v > build/reduce_test.v
