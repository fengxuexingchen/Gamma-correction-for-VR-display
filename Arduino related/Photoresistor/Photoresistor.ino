/*
A simple script to use photoresistor
*/

void setup()
{
  // Initialize the serial port 
  Serial.begin(9600);
}
void loop() 
{
// Read the current light intensity and output it to the serial port for display
  int sensorValue = analogRead(A0);
  Serial.println(sensorValue);
  delay(500);
}

