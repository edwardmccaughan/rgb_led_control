import serial
import time
ser = serial.Serial(
    port='/dev/ttyUSB0',
    baudrate=115200
)

# So! Apparently when you connect to the arduino serial port, the bootloader
# kicks in, resets the arduino and waits a second for a new program to be loaded
# before running the actual already stored code 
time.sleep(2)

def set_pixel(pixel, red, green, blue):
  red   = min(red, 254)
  green = min(green, 254)
  blue  = min(blue, 254)

  control_string = bytearray([pixel,red,green,blue, 255])
  ser.write(control_string)    

for i in range(50):
  set_pixel(i, 255, 125, 0)
  time.sleep(0.3)
  set_pixel(i, 0, 0, 0)


ser.close()             # close port