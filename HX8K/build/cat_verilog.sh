#cat stencil.v linebuffer.v > temp.v
#cat temp.v > stencil.v

#cat downscale_mod_test.v downscale_sub.v > temp.v
#cat temp.v > downscale_mod_test.v

cat main.v downscale_sub.v > temp.v
cat temp.v > main.v

#cat reduce_test.v reducehybrid.v > temp.v
#cat temp.v > reduce_test.v
