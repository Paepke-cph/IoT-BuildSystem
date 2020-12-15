#define PWMA 5
#define DIRA 0

void setup() {
  Serial.begin(9600);                  
  pinMode(DIRA, OUTPUT);
  pinMode(PWMA, OUTPUT);
}
void loop() {
  digitalWrite(PWMA, HIGH);
  digitalWrite(DIRA, LOW);
  delay(5000);
  digitalWrite(PWMA, LOW);
  digitalWrite(DIRA,LOW);
  delay(5000);
}
