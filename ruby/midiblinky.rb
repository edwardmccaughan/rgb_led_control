require "unimidi"
require 'serialport'
require 'byebug'

module Arduino
  SERIAL_PORT = "/dev/ttyUSB0"
  SERIAL_RATE = 115200
  PIXELS = 24

  def self.serial_port
    @port ||= SerialPort.new(SERIAL_PORT, baud: SERIAL_RATE)
  end

  def self.set_pixel(pixel, red, green, blue)
    # first byte is whice led number to switch on
    Arduino.serial_port.write(pixel.chr)     

    # next 3 bytes are red, green and blue values
    # Note: 255 signifies the end of the command, so don't try and set an led value to that
    Arduino.serial_port.write(red.chr)    
    Arduino.serial_port.write(green.chr)    
    Arduino.serial_port.write(blue.chr)

    # then end with a termination character
    Arduino.serial_port.write(255.chr)  
  end
end


keyboard = UniMIDI::Input.first.open # We probably only have one midi device connected

@white_keys = [36,38,40,41,43,45,47,48,50,52,53,55,57,59,60,62,64,65,67,69,71,72,74,76]

def process_triplet(data)

  key_pressed = data[1]    # data[1] is what key was pressed.
  is_down = data[2] != 0   # data[2] is 0 if the key is released, or 0-100 depending on the velocity of the keypress

  led = @white_keys.find_index(key_pressed)

  if led
    led_value = is_down ? 50 : 0

    Arduino.set_pixel(led, 0,0, led_value)
    sleep(0.01) # Ruby serial_port is non blocking, so give it time to finish sending, otherwise we try and send the next command before the last one is finished
  end
end


while(true)
  packets = keyboard.gets
  puts packets.inspect

  data_chunks = packets.first[:data].each_slice(3).to_a # midi packets are weird, if several events happen at once, they all get stuffed into the same array

  data_chunks.each{ |triplet| process_triplet(triplet) }
end
