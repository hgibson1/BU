//  Jeremy Stark  and Noah Hudelson
//  March 26th, 2014
//  jwstark@gmail.com jnhudelson@gmail.com

//  This is the stepper motor control for the optical dust loading image analayzer
//  This control code takes an in imput signal via serial of char '1'
//  then completes one step, as defined by the step size in this code
//  The code then returns 'done'
//  At present there is no error checking...

//  The motors controlled are 4-phase unipolar, 125 ozin, 200 steps/rev, 1.8 degree
//  Sparkfun product number ROB-10847, Wantai NEMA 23 Stepper 57BYGH420
//  Serial com speed is set at 115200.
//
//  The driver board is the Arduino Motor sheild

// Include the Stepper Library
#include <AccelStepper.h>  // This also includes the stepper class
#include <Stepper.h>
// Map our pins to constants to make things easier to keep track of
const int limit = 2;  // We will use this as a table limit and for homing
const int pwmA = 3;
const int pwmB = 11;
const int brakeA = 8;
const int brakeB = 9;
int incomingByte = 0;
int moveByte = 0;
int safemove = 0;
int count = 0;
int sign = 0;

// Initialize the AccelStepper class. 

AccelStepper stepper(2,12,13);  //this lets AccelStepper know we are using a dual channel H bridge configuration and the two pins are 12 and 13 in accordance with the arduino sheild.


void setup() {

  //  Defining the PWM channels and such
  pinMode(pwmA, OUTPUT);
  pinMode(pwmB, OUTPUT);
  pinMode(brakeA, OUTPUT);
  pinMode(brakeB, OUTPUT);

  // RELEASE THE DIGITAL HOLD
  digitalWrite(pwmA, HIGH);
  digitalWrite(pwmB, HIGH);
  digitalWrite(brakeA, HIGH);
  digitalWrite(brakeB, HIGH);
  
  // SETTING MOTOR PARAMETERS FOR ACCELLSTEPPER
  stepper.setMaxSpeed(600);
  stepper.setSpeed(600);
  stepper.setAcceleration(2000);
  
  // Without this, no one will hear you scream, or listen to you.  So yeah.
  Serial.begin(115200);
}

void loop() {

  while(Serial.available() == 0)  //Waits serial to be available.
  {
  }
  incomingByte = Serial.read();
  if(incomingByte == 53)  // If MatLab passes the arduino an 'ascii' 5 then the arduino homes
  {
    digitalWrite(brakeA, LOW);  // take off the brakes to run free little bird
    digitalWrite(brakeB, LOW);  // take off the brakes to run free little bird
    stepper.move(-400000); // a very long distance
    while(digitalRead(limit) == HIGH) // limit switch is at high for fail safe 
    {
      stepper.run();  // runs stepper motor until limit switch is hit
      Serial.println(0);  // "0" is sent to MatLab to let it know we are still moving.  Mat lab reads this and gives the arduino more time so that it does not stop
    }
      stepper.move(3200); // sets next move forward a small amount to get rid of backlash in screw and to release limit switch
      while(stepper.distanceToGo() != 0) // moves table until move is complete or limit switch is hit.
   {
      stepper.run();
      Serial.println(0);
   }  
      Serial.println(1985);  // "1" is sent to MatLab to let it know we hit the limit
     digitalWrite(brakeA, HIGH);  // PUT THE BRAKES ON TO STOP CURRENT TO STEPPERS
     digitalWrite(brakeB, HIGH);  // PUT THE BRAKES ON TO STOP CURRENT TO STEPPERS
      
  }

  if(incomingByte == 50)
  {
    int pos = stepper.currentPosition();
    while(Serial.available() == 0)  //Waits serial to be available.
  {
  }
    digitalWrite(brakeA, LOW);  // take off the brakes to run free little bird
    digitalWrite(brakeB, LOW);  // take off the brakes to run free little bird
    moveByte = Serial.parseInt();  //reads in movement of table
    int sign = moveByte / abs(moveByte);
    stepper.moveTo(pos + moveByte );
   while(digitalRead(limit) == HIGH && sign *(stepper.distanceToGo()) > 0) // moves table until move is complete or limit switch is hit.
   {
      stepper.run();
      Serial.println(0);
   }
    digitalWrite(brakeA, HIGH);  // PUT THE BRAKES ON TO STOP CURRENT TO STEPPERS
    digitalWrite(brakeB, HIGH);  // PUT THE BRAKES ON TO STOP CURRENT TO STEPPERS
   Serial.println(1985);
  }
}


