require 'serialport' # NOTE: you probably need to install this gem with: 'gem install serialport'

module Arduino
  SERIAL_PORT = "/dev/ttyUSB0"
  SERIAL_RATE = 115200
  PIXELS = 24

  def self.serial_port
    @port ||= SerialPort.new(SERIAL_PORT, baud: SERIAL_RATE)
  end
end

def set_pixel(pixel, red, green, blue)
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


set_pixel(0,0,0,0)

while(true)
  (0..Arduino::PIXELS).each do |pixel|
    set_pixel(pixel, 0,0,50)
    sleep(0.1)
    set_pixel(pixel, 0,0,0)
    sleep(0.01)
  end
end
