from pixel import PixelBone_Pixel
neoPixelStick = PixelBone_Pixel(8) 
for led in range(0,neoPixelStick.numPixels()):
    neoPixelStick.setPixelColor(led, 128, 128, 128)
neoPixelStick.show()

