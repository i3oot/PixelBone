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
ln libpixel/usr/lib/libpixel.so libpixel/usr/lib/libpixel.so.1 
sed "s/%DATE%/$version/g" libpixel/CONTROL/control.template > libpixel/CONTROL/control


pushd dist
../ipkg-build ../libpixel .
popd


rm -rf libpixel-python/usr
mkdir -p libpixel-python/usr/lib/python2.7
cp ../_pixel.so libpixel-python/usr/lib/python2.7/
cp ../pixel.py libpixel-python/usr/lib/python2.7/
sed "s/%DATE%/$version/g" libpixel-python/CONTROL/control.template > libpixel-python/CONTROL/control


pushd dist
../ipkg-build ../libpixel-python .
popd

rm -rf libpixel-devicetree/boot
mkdir -p libpixel-devicetree/boot
cp ../dirtree/am335x-boneblack.dtb libpixel-devicetree/boot/
sed "s/%DATE%/$version/g" libpixel-devicetree/CONTROL/control.template > libpixel-devicetree/CONTROL/control


pushd dist
../ipkg-build ../libpixel-devicetree .
popd
