#include <libneopixel/pixel.hpp>
int main(void) {
  PixelBone_Pixel *const neoPixelStick = new PixelBone_Pixel(8);
  for (unsigned led = 0; led < neoPixelStick->numPixels(); led++) {
      neoPixelStick->setPixelColor(led, 128, 128, 128);
  }
  neoPixelStick->show();
  delete neoPixelStick;
  return 0;
}

