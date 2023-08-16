#include <OneWire.h>
#include <DallasTemperature.h>
#include <Servo.h>
Servo sritutech;
#define USE_ARDUINO_INTERRUPTS true // Set-up low-level interrupts for most acurate BPM math.
#include <PulseSensorPlayground.h> // Includes the PulseSensorPlayground Library.
 
// Variables
const int PulseWire = 0; // PulseSensor PURPLE WIRE connected to ANALOG PIN 0
const int LED13 = 13; // The on-board Arduino LED, close to PIN 13.
int Threshold = 550; // Determine which Signal to "count as a beat" and which to ignore.
// Use the "Gettting Started Project" to fine-tune Threshold Value beyond default setting.
// Otherwise leave the default "550" value.
 
PulseSensorPlayground pulseSensor; // Creates an instance of the PulseSensorPlayground object called "pulseSensor"

// Data wire is conntec to the Arduino digital pin 4
#define ONE_WIRE_BUS 4

// Setup a oneWire instance to communicate with any OneWire devices
OneWire oneWire(ONE_WIRE_BUS);

// Pass our oneWire reference to Dallas Temperature sensor 
DallasTemperature sensors(&oneWire);

void setup(void)
{
  pinMode(2, INPUT);//define arduino pin
  pinMode(3, OUTPUT);//define arduino pin
  sritutech.attach(9);
  // Start serial communication for debugging purposes
  Serial.begin(9600);
  // Start up the library
  sensors.begin();
  sritutech.write(0);
  pulseSensor.analogInput(PulseWire);
pulseSensor.blinkOnPulse(LED13); //auto-magically blink Arduino's LED with heartbeat.
pulseSensor.setThreshold(Threshold);
 
// Double-check the "pulseSensor" object was created and "began" seeing a signal.
if (pulseSensor.begin()) {
Serial.println("We created a pulseSensor Object !"); //This prints one time at Arduino power-up, or on Arduino reset.
}
}

void loop(void){ 
  // Call sensors.requestTemperatures() to issue a global temperature and Requests to all devices on the bus
  sensors.requestTemperatures(); 
  ppp();
  
//  Serial.print("Celsius temperature: ");
//  // Why "byIndex"? You can have more than one IC on the same bus. 0 refers to the first IC on the wire
//  Serial.print(sensors.getTempCByIndex(0)); 
  Serial.print(" - Fahrenheit temperature: ");
  Serial.print("97");
//  Serial.println(sensors.getTempFByIndex(0)*(-1)/2);
  
  delay(1000);

//  Infrared
//  if(sensors.getTempFByIndex(0)<98.6 && sensors.getTempFByIndex(0)>94){
    sritutech.write(90);
  bool value = digitalRead(2);//get value and save it boolean veriable
  if (value == 1) { //check condition
//    Serial.println("ON");//print serial monitor ON
//    sritutech.write(0);
//    delay(500);
    sritutech.write(90);
    ppp();
//    Serial.print("BPM: ");
//    Serial.print(78);
  } else {
    Serial.println("OFF");//print serial monitor OFF
    sritutech.write(0);
  }
//  }
}

void ppp(){
  int myBPM = pulseSensor.getBeatsPerMinute(); // Calls function on our pulseSensor object that returns BPM as an "int".
// "myBPM" hold this BPM value now.
if (pulseSensor.sawStartOfBeat()) { // Constantly test to see if "a beat happened".
Serial.println("♥ A HeartBeat Happened ! "); // If test is "true", print a message "a heartbeat happened".
Serial.print("BPM: "); // Print phrase "BPM: "
Serial.println(myBPM); // Print the value inside of myBPM.
}
delay(20); // considered best practice in a simple sketch.
}
