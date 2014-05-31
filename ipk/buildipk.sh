 #!/bin/sh

rm -rf dist
mkdir dist

rm -rf libpixel-dev/usr
mkdir -p libpixel-dev/usr/include/libpixel
cp ../*.h libpixel-dev/usr/include/libpixel/
cp ../*.hpp libpixel-dev/usr/include/libpixel/

pushd dist
../ipkg-build ../libpixel-dev .
popd 





rm -rf libpixel/usr
mkdir -p libpixel/usr/lib
cp ../*bin libpixel/usr/lib/
cp ../*so libpixel/usr//lib/
cp  ../am335x/app_loader/lib/*.so libpixel/usr/lib/

pushd dist
../ipkg-build ../libpixel .
popd


