#include "FastLED.h"

#define NUM_LEDS 150
#define DATA_PIN 11 //blue
#define CLOCK_PIN 13 //green

CRGB leds[NUM_LEDS];
byte inData[4];
int debug_led = 12;

void setup() {
  pinMode(debug_led, OUTPUT);
  pinMode(11, OUTPUT);
  FastLED.addLeds<WS2801, DATA_PIN, CLOCK_PIN, RGB>(leds, NUM_LEDS);
  Serial.begin(115200, SERIAL_8N1);
  Serial.print("Arduino is here!\n");
  FastLED.show();
  //digitalWrite(debug_led, HIGH);
  //LEDS.setBrightness(64);
} 




void process_command(byte command[]) {
    //leds[3] = CRGB::Blue;
    //FastLED.show();
  
    //digitalWrite(11, HIGH);
    int led = command[0];
    //leds[led] = CRGB::Red;
    //FastLED.show();
    
    
    digitalWrite(12, HIGH);    
    leds[led].r = command[1]; 
    leds[led].g = command[2]; 
    leds[led].b = command[3];
    //FastLED.show();
    
}


int currentByte = 0;

void loop() {
  
 while (Serial.available() > 0) {
   //digitalWrite(debug_led, HIGH);
        byte recieved = Serial.read();
        //digitalWrite(debug_led, HIGH);
        // Process message when new line character is recieved
        //if (recieved == "\n")
        
        if (recieved == 255)
        {
            //digitalWrite(debug_led, HIGH);
            //delay(1);  //why did I even have this?
            //digitalWrite(debug_led, LOW);
            process_command(inData);
            currentByte = 0;
         
        } else if (recieved == 254) {
          FastLED.show();
        } else {
            inData[currentByte] = recieved;
            currentByte++;
        }
    }
 
}

