make 
swig -c++ -python pixel.i
g++ -fPIC -shared -lsupc++ -std=c++11 -o pixel_wrap.o -c pixel_wrap.cxx -I /usr/include/python2.7/
gcc -shared -Wl,-soname,libneopixel.so.1 -o libneopixel.so  *.o -lpython2.7 -lstdc++ -Lam335x/app_loader/lib/ -lprussdrv -lprussdrvd 
rm -f _pixel.so
ln libneopixel.so _pixel.so

pushd ipk
./buildipk.sh
popd
