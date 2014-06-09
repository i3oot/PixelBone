 #!/bin/sh

rm -rf dist
mkdir dist

export version=`date +%Y%m%d%H%M%S`

rm -rf libneopixel-dev/usr
mkdir -p libneopixel-dev/usr/include/libneopixel
cp ../*.h libneopixel-dev/usr/include/libneopixel/
cp ../*.hpp libneopixel-dev/usr/include/libneopixel/
sed "s/%DATE%/$version/g" libneopixel-dev/CONTROL/control.template > libneopixel-dev/CONTROL/control

pushd dist
../ipkg-build ../libneopixel-dev .
popd 





rm -rf libneopixel/usr
mkdir -p libneopixel/usr/lib
cp ../*bin libneopixel/usr/lib/
cp ../libneopixel*so libneopixel/usr//lib/
cp  ../am335x/app_loader/lib/*.so libneopixel/usr/lib/
ln libneopixel/usr/lib/libneopixel.so libneopixel/usr/lib/libneopixel.so.1 
sed "s/%DATE%/$version/g" libneopixel/CONTROL/control.template > libneopixel/CONTROL/control


pushd dist
../ipkg-build ../libneopixel .
popd


rm -rf libneopixel-python/usr
mkdir -p libneopixel-python/usr/lib/python2.7
cp ../_pixel.so libneopixel-python/usr/lib/python2.7/
cp ../pixel.py libneopixel-python/usr/lib/python2.7/
sed "s/%DATE%/$version/g" libneopixel-python/CONTROL/control.template > libneopixel-python/CONTROL/control


pushd dist
../ipkg-build ../libneopixel-python .
popd

rm -rf libneopixel-devicetree/boot
mkdir -p libneopixel-devicetree/boot
cp ../dirtrees/am335x-boneblack.dtb libneopixel-devicetree/boot/
sed "s/%DATE%/$version/g" libneopixel-devicetree/CONTROL/control.template > libneopixel-devicetree/CONTROL/control


pushd dist
../ipkg-build ../libneopixel-devicetree .
popd
