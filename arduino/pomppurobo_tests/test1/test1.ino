// Simple serial pass through program
// It initializes the RFM12B radio with optional encryption and passes through any valid messages to the serial port
// felix@lowpowerlab.com

#include <RFM12B.h>

// You will need to initialize the radio by telling it what ID it has and what network it's on
// The NodeID takes values from 1-127, 0 is reserved for sending broadcast messages (send to all nodes)
// The Network ID takes values from 0-255
// By default the SPI-SS line used is D10 on Atmega328. You can change it by calling .SetCS(pin) where pin can be {8,9,10}
#define NODEID           1  //network ID used for this unit
#define NETWORKID       99  //the network ID we are on
#define SERIAL_BAUD 115200

//encryption is OPTIONAL
//to enable encryption you will need to:
// - provide a 16-byte encryption KEY (same on all nodes that talk encrypted)
// - to call .Encrypt(KEY) to start encrypting
// - to stop encrypting call .Encrypt(NULL)
uint8_t KEY[] = "ABCDABCDABCDABCD";


// Pin 13 has an LED connected on most Arduino boards.
// Pin 11 has the LED on Teensy 2.0
// Pin 6  has the LED on Teensy++ 2.0
// Pin 13 has the LED on Teensy 3.0
// give it a name:
int LEDPin = 11;

int PWMAPin = 4;
int AIN2Pin = 0;
int AIN1Pin = 6;
int BIN1Pin = 7;
int BIN2Pin = 8;
int PWMBPin = 9;

int MOSFETPin = 5;

int POTPin = 13;

int buttonPin = 12; 

int buzzerPin = 15;

long switchTime = 0;         // the last time the output pin was toggled
long switchDebounce = 200; 
int buttonPrevious = false;
int switchState = false;

RFM12B radio;

// the setup routine runs once when you press reset:
void setup() {  
  initOutputs();
  
  digitalWrite(LEDPin, HIGH); // turn the LED on (HIGH is the voltage level)
  delay(500);
    digitalWrite(LEDPin, LOW); // turn the LED on (HIGH is the voltage level)
  delay(500);
    digitalWrite(LEDPin, HIGH); // turn the LED on (HIGH is the voltage level)
  delay(500);
    digitalWrite(LEDPin, LOW); // turn the LED on (HIGH is the voltage level)
  initRadio();
  

}


void initRadio() {
  Serial.println("Initializing radio");
  //radio.Initialize(NODEID, RF12_433MHZ, NETWORKID);
  Serial.println("Radio radio");
  //radio.Encrypt(KEY);      //comment this out to disable encryption  
}



void initOutputs() {   
  pinMode(LEDPin, OUTPUT);     
  pinMode(PWMAPin, OUTPUT);     
  pinMode(PWMBPin, OUTPUT);     
  pinMode(AIN1Pin, OUTPUT);     
  pinMode(AIN2Pin, OUTPUT);     
  pinMode(BIN1Pin, OUTPUT);     
  pinMode(BIN2Pin, OUTPUT);   

  pinMode(MOSFETPin, OUTPUT);     

  pinMode(POTPin, INPUT);    

  pinMode(buttonPin, INPUT);     
}

void loop() {
  int motorSpeed = readMotorSpeed();
  readSwitchState();

  if (switchState == true) {
    digitalWrite(LEDPin, LOW);
    //controlByRadio();
          move(1, 0, 0);//vasen moottori eteen
      move(2, 0, 0); //oikea moottori eteen
  }
  else { 
      digitalWrite(LEDPin, HIGH);
      move(1, motorSpeed, 0);//vasen moottori eteen
      move(2, motorSpeed, 1); //oikea moottori eteen
  }
}

int16_t vertical = 0;
int16_t horizontal = 0;
int16_t joystickButton = 0;

/*
void controlByRadio() {
  if (radio.ReceiveComplete()) {
    if (radio.CRCPass())
    {
      Serial.print('[');
      Serial.print(radio.GetSender());
      Serial.print("] ");
      int payloadSize = 5;
      uint8_t data[payloadSize];
      for (byte i = 0; i < *radio.DataLen; i++) { //can also use radio.GetDataLen() if you don't like pointers
        data[i] = (char)radio.Data[i];

      }

      vertical = data[0];
      vertical = vertical << 8;
      vertical = vertical + data[1];
      //vertical = (data[0] << 8) || data[1];
      horizontal = data [2];
      horizontal = horizontal << 8;
      horizontal = horizontal + data[3];
      //horizontal = (data[2] << 8) || data[3];
      joystickButton = (data[4]);

      Serial.print("vertical: ");
      Serial.print(vertical);
      Serial.print(" horizontal: ");
      Serial.print(horizontal);
      Serial.print(" joystickButton: ");
      Serial.print(joystickButton); 

      //ohjaus
      if (vertical-512 >15){
        move(1, (vertical - 512)/2, 1);//vasen moottori eteen
        move(2, (vertical-512)/2, 0); //oikea moottori taakse
        // käännös oikealle
        // suunta = ;  //käännös oikealle
        Serial.println("oikea");
      }

      if (vertical-512 <-15){
        move(1, 0-(vertical - 512)/2, 0);//vasen moottori taakse
        move(2, 0-(vertical-512)/2, 1); //oikea moottori eteen
        // käännös vasemmalle
        // suunta = ;  //käännös vasemmalle
        Serial.println("vasen");



      }   
      if (horizontal-512 >15){
        move(1, (horizontal - 512)/2, 1);//vasen moottori eteen
        move(2, (horizontal-512)/2, 0); //oikea moottori taakse
        // eteenpäin
        // suunta = ;  //eteenpäim
        Serial.println("eteenpain");
      } 

      if (horizontal-512 <-15){
        move(1, 0-(horizontal - 512)/2, 0);//vasen moottori taakse
        move(2, 0-(horizontal-512)/2, 1); //oikea moottori eteen
        // taaksepäin
        // suunta = ;  //taaksepäin
        Serial.println("taaksepain");
      } 
    }
    else
      Serial.print("BAD-CRC");

    Serial.println();
  } 
}
*/
int readMotorSpeed() {
  return analogRead(POTPin) / 4;
}

int readSwitchState() {
  int buttonReading = analogRead(buttonPin);

  if (buttonPrevious - buttonReading > 300 && millis() - switchTime > switchDebounce) {
    Serial.print("Switching state");
    if (switchState == true)
      switchState = false;
    else
      switchState = true;

    switchTime = millis();    
  }

  buttonPrevious = buttonReading;

  return switchState;
}

void move(int motor, int speed, int direction){
  boolean inPin1 = LOW;
  boolean inPin2 = HIGH;

  if(direction == 1){
    inPin1 = HIGH;
    inPin2 = LOW;
  }

  if(motor == 1){
    digitalWrite(AIN1Pin, inPin1);
    digitalWrite(AIN2Pin, inPin2);
    analogWrite(PWMAPin, speed);
  }
  else{
    digitalWrite(BIN1Pin, inPin1);
    digitalWrite(BIN2Pin, inPin2);
    analogWrite(PWMBPin, speed);
  }
}


