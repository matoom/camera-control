#include <LiquidCrystal.h>
#include <Servo.h> 

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(8, 9, 10, 11, 12, 13);
Servo s;
int serial;
int servo;

// camera turn constants
int SPEED_LOW = 1;
int SPEED_HIGH = 10;
int SERVO_MAX = 170;
int SERVO_MIN = 10;
 
void setup(){
  // set up the LCD's number of rows and columns: 
  lcd.begin(16, 2);
  // initialize the serial communications:
  Serial.begin(9600);
  // initialize servo
  s.attach(3);  
}

void loop()
{
  // when characters arrive over the serial port...
  if (Serial.available()) {
    // wait a bit for the entire message to arrive    
    delay(100);
    while (Serial.available() > 0) {
        serial = Serial.read();   
        servo = s.read();
                
        if(serial == 114) {
          (servo + SPEED_LOW >= SERVO_MAX) ? s.write(SERVO_MAX) : s.write(servo + SPEED_LOW);                               
        } else if(serial == 108) {
          (servo - SPEED_LOW <= SERVO_MIN) ? s.write(SERVO_MIN) : s.write(servo - SPEED_LOW);                         
        } else if(serial == 82) {
          (servo + SPEED_HIGH >= SERVO_MAX) ? s.write(SERVO_MAX) : s.write(servo + SPEED_HIGH);         
        } else if(serial == 76) {
          (servo - SPEED_HIGH <= SERVO_MIN) ? s.write(SERVO_MIN) : s.write(servo - SPEED_HIGH);          
        } else if(serial == 35) {
              lcd.clear();
              int i = 0;
              while (Serial.available() > 0) {
                  i++;
                  if(i == 16){
                    lcd.setCursor(0, 1);
                  }                  
                  lcd.write(Serial.read());
              }
        }
    }
  }
}
