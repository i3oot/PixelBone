 #!/bin/sh

rm -rf dist
mkdir dist

export version=`date +%Y%m%d%H%M%S`

rm -rf libpixel-dev/usr
mkdir -p libpixel-dev/usr/include/libpixel
cp ../*.h libpixel-dev/usr/include/libpixel/
cp ../*.hpp libpixel-dev/usr/include/libpixel/
sed "s/%DATE%/$version/g" libpixel-dev/CONTROL/control.template > libpixel-dev/CONTROL/control

pushd dist
../ipkg-build ../libpixel-dev .
popd 





rm -rf libpixel/usr
mkdir -p libpixel/usr/lib
cp ../*bin libpixel/usr/lib/
cp ../*so libpixel/usr//lib/
cp  ../am335x/app_loader/lib/*.so libpixel/usr/lib/
sed "s/%DATE%/$version/g" libpixel/CONTROL/control.template > libpixel/CONTROL/control


pushd dist
../ipkg-build ../libpixel .
popd


<<<<<<< Updated upstream
=======
rm -rf libpixel-python/usr
mkdir -p libpixel-python/usr/lib
cp ../_pixel.so libpixel-python/usr/lib/python2.7/
cp ../pixel.py libpixel-python/usr/lib/python2.7/
sed "s/%DATE%/$version/g" libpixel-python/CONTROL/control.template > libpixel-python/CONTROL/control


pushd dist
../ipkg-build ../libpixel-python .
popd

>>>>>>> Stashed changes
