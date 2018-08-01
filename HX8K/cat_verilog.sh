#cat buiuld/stencil.v build/linebuffer.v > build/temp.v
#cat build/temp.v > build/stencil.v

#cat build/downscale_mod_test.v build/downscale_sub.v > build/temp.v
#cat build/temp.v > build/downscale_mod_test.v

cat build/main.v build/downscale_sub.v > build/temp.v
cat build/temp.v > build/main.v

#cat build/reduce_test.v build/reducehybrid.v > build/temp.v
#cat build/temp.v > build/reduce_test.v
