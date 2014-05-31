make 
swig -c++ -python pixel.i
g++ -fPIC -shared -lsupc++ -std=c++11 -o pixel_wrap.o -c pixel_wrap.cxx -I /usr/include/python2.7/
gcc -shared -Wl,-soname,libpixel.so.1 -o libpixel.so  *.o -lpython2.7 -lstdc++ -L. -lprussdrv -lprussdrvd 
gcc -shared -Wl,-soname,libpixel.so.1 -o libpixel.so  *.o -lpython2.7 -lstdc++ -Lam335x/app_loader/lib/ -lprussdrv -lprussdrvd 
ln libpixel.so _pixel.so
