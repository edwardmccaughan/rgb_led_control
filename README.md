Control an RGB led strip from a computer over the serial port (using an ardunio as the middle man).

* program the Arduino with ws2801_control or ws2812_control
* Connect to the serial port using whatever library or tool you prefer (baud rate defaults to 115200)
* send 8 bit bytes, terminated by a byte with value 255 to signal the end of the command 
* There's an example app written in ruby in ruby_test.rb for reference

| byte 0        | byte 1 | byte 2 | byte 3 | byte 5                 |
| ------------- | ------ | ------ | ------ | ---------------------- |
| pixel number  | red    | blue   |  green | stop byte (always 255) |


for example, if you're using a terminal client that supports hex input:

| command     | result                                  | 
| ----------- | ------                                  |
| 00AA0000FF  | pixel 0 is set to red brightness 170    |
| 16AAAAAAFF  | pixel 22 is set to white brightness 170 |
| 2D000000FF  | pixel 45 is set to black/off            |

## Wiring

### ws2813

| led strip pin | arduino pin | 
| -----------   | ------------|
| DATA_PIN      | 6           |


### ws2801
| led strip pin | arduino pin |                    notes | 
| ------------- | ------------|--------------------------|
| DATA_PIN      | 11          | generally the blue wire  |
| CLOCK_PIN     | 13          | generally the green wire |


## Limitations and gotchas

* Because 255 is a control character, you can't actually set a pixel to this brightness (but 253 looks almost identical)
* For ws2801, 254 is also a control character to update all the pixels, for ws2812, you can use 254 for pixel values
* when you first open the serial port on the Arduino, it reboots (it's a 'feature'). This means after you open the port, you need to wait a couple of seconds for it to boot, before you send any data, otherwise the data gets ignored.
