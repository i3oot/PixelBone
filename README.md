#Overview

Libneopixel gives you *dead easy* api access to [WS2811](http://www.adafruit.com/datasheets/WS2811.pdf)-based LED strips on your [Beagle Bone Black](http://beagleboard.org/Products/BeagleBone+Black) running the bundeled [Armstrong Distribution](http://www.angstrom-distribution.org/). It allows you to drive your LED strip with C++ or Python.  

Supported LED Strips are:

1. [NeoPixel Digital RGB LED Strip 144 LED](http://www.adafruit.com/products/1506)
2. [NeoPixel Digital RGB LED Weatherproof Strip 60 LED](http://www.adafruit.com/products/1461)
3. [NeoPixel Stick](http://www.adafruit.com/products/1426)
4. [NeoPixel Ring](http://www.adafruit.com/products/1463)

other WS2811-based LED strips will propably work too.

#Getting Started
###Setting up the hardware
The simplest way to setup your Beagle Bone Black to work with your LED strip is:

1. use a 5V power supply suitable for your LED strip
2. connect (-) to GND and (+) to VDC of your LED strip
3. connect (-) to DGND and (+) to VDD_5V of your Beagle Bone Black
4. connect GPIO_02 on your Beagle Bone Black to DIN on your LED strip

Refer to [Beagle Bone Black PinOut](http://insigntech.files.wordpress.com/2013/09/bbb_pinouts.jpg&imgrefurl=http://insigntech.wordpress.com/2013/09/23/beaglebone-black-pin-outs/&h=1287&w=1308&tbnid=9QJxDKgAoi-PIM:&zoom=1&docid=Ds0cxnCrsavSCM&ei=jgGLU_oXy8HSBazHgZgK&tbm=isch&client=ubuntu&iact=rc&uact=3&dur=1927&page=1&start=0&ndsp=16&ved=0CHwQrQMwDA).

> ###### WARNING ######
> This setup can under some conditions damage your LEDs or Beagle Bone Black. Please refer to [Adafruit NeoPixel Überguide - Powering NeoPixels](https://learn.adafruit.com/adafruit-neopixel-uberguide/power) for details and advanced setups.

###Installing the libraries
To get started, visit our [Release Section](https://github.com/i3oot/libneopixel/releases) and download the latest ipk packages to your Beagle Bone Black. Then run:

    cd {path to the packages}
    opkg install libneopixel*.ipk

Reboot your Beagle Bone Black and you are ready to rock your LED strip.     

###Hello world
The Hello World Examples turn all eight leds of an Adafruit NeoPixel Stick to bright white.
#### Python
```python
from pixel import PixelBone_Pixel
neoPixelStick = PixelBone_Pixel(8) 
for led in range(0,8):
    neoPixelStick.setPixelColor(led, 128, 128, 128)
neoPixelStick.show()
```
#### C++
```cpp
#include <libneopixel/pixel.hpp>
int main(void) {
  PixelBone_Pixel *const neoPixelStick = new PixelBone_Pixel(8);
  for (unsigned led = 0; led < 8; p++) {
      neoPixelStick->setPixelColor(led, 128, 128, 128);
  }
  neoPixelStick->show();
  delete neoPixelStick;
  return 0;
}

```
    
#Packages

######libpixel-devicetree (required)
Installs the device tree file (am335x-boneblack.dtb) wich enables the PRU and maps GPIO_02 of your Beagle Bone Black.
######libpixel (required)
Installs the core shared objects and the PRU code into `/usr/lib` 
######libpixel-dev
Installs C++ development headers into `/usr/include/libneopixel`
*This package is required for C++ development.*
######libpixel-python
Installs Python bindings into `/usr/lib/python2.7`
*This package is required for Python development.*

###Compile them yourself

    git clone git@github.com:i3oot/libneopixel
    cd libneopixel
    sh build.sh

Done! You will find the ipk packages under `ipk/dist`

#References

This library is heavily based on the PixelBone library wich in turn is based on the LEDscape library. It is designed to control a single chain of WS2811-based LED modules from a BeagleBone Black. The timing has been updated and verified to work with both WS2812 and WS2812b chips. This version of the library uses a single PRU on the BeagleBone. This allows sending at about 60fps to strings of 512 pixels or at ~120fps for 256 pixels.

The bit-unpacking is handled by the PRU, which allows PixelBone to take almost no cpu time to run, freeing up time for the actual generation of animations or dealing with network protocols.


###API


`pixel.hpp` and `matrix.hpp` defines the API. The key components are:

```cpp
class PixelBone_Pixel {
public:
  PixelBone_Pixel(uint16_t pixel_count);
  void show(void);
  void clear(void);
  void setPixelColor(uint32_t n, uint8_t r, uint8_t g, uint8_t b);
  void setPixelColor(uint32_t n, uint32_t c);
  void moveToNextBuffer();
  uint32_t wait();
  uint32_t numPixels() const;
  uint32_t getPixelColor(uint32_t n) const;
  static uint32_t Color(uint8_t red, uint8_t green, uint8_t blue);
  static uint32_t HSB(uint16_t hue, uint8_t saturation, uint8_t brightness);
};

class PixelBone_Matrix{
public:
  // Constructor for single matrix:
  PixelBone_Matrix(int w, int h,
                   uint8_t matrixType = MATRIX_TOP + MATRIX_LEFT + MATRIX_ROWS);

  // Constructor for tiled matrices:
  PixelBone_Matrix(uint8_t matrixW, uint8_t matrixH, uint8_t tX, uint8_t tY,
                   uint8_t matrixType = MATRIX_TOP + MATRIX_LEFT + MATRIX_ROWS +
                                        TILE_TOP + TILE_LEFT + TILE_ROWS);

  void drawPixel(int16_t x, int16_t y, uint16_t color);
  void fillScreen(uint16_t color);
  static uint16_t Color(uint8_t r, uint8_t g, uint8_t b);
};
```

You can double buffer like this:

```cpp
const int num_pixels = 256;
PixelBone_Pixel strip(num_pixels);

while (true) {
	render(strip); //modify the pixels here

	// wait for the previous frame to finish;
	strip.wait();
	strip.show()

	// Alternate frame buffers on each draw command
	strip.moveToNextBuffer();
}
```

The 24-bit RGB data to be displayed is laid out with BRGA format,
since that is how it will be translated during the clock out from the PRU.

```cpp
struct PixelBone_pixel_t{
	uint8_t b;
	uint8_t r;
	uint8_t g;
	uint8_t a;
} __attribute__((__packed__));
```

