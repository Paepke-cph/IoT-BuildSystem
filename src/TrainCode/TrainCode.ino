#define BLYNK_PRINT Serial 
#include <ESP8266WiFi.h> 
#include <BlynkSimpleEsp8266.h> 
char auth[] = "8VIZnCkmS12CjfJAPG54TVQ7Qx5jKj3a"; 
char ssid[] = "TP-Link_2764"; 
char pass[] = "72926536"; 
int PWMA=5;//Right side
int DA=0;//Right reverse 
void setup(){ 
  // Debug console 
  Serial.begin(9600); 
  Blynk.begin(auth, ssid, pass); 
  pinMode(PWMA, OUTPUT); 
  pinMode(DA, OUTPUT); 
} 
void loop(){ 
  Blynk.run(); 
  
} 
// Handling Joystick data 
BLYNK_WRITE(V1){ 
  int x = param[0].asInt(); 
  int y = param[1].asInt();  
  
  if(x==0 && y==-1){        //Backward     
       digitalWrite(PWMA, HIGH); 
       digitalWrite(DA, HIGH); 
  }else if(x==0 && y==0){        //Stay 
       digitalWrite(PWMA, LOW); 
       digitalWrite(DA, LOW); 
  }else if(x==0 && y==1){        //Forward 
       digitalWrite(PWMA, HIGH); 
       digitalWrite(DA, LOW); 
  } 
}
