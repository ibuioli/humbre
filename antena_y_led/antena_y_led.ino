#define LECTURAS 15

int antenaPin = 0;
int F1 = 3;
int F2 = 5;
int F3 = 6;
int F4 = 9;
int F5 = 10;

int limite = 10;
int val = 0;
int leer[LECTURAS];
int index = 0;
int total = 0;
int antena = 0;

byte lucesVal = 0;
byte factor1 = 0;
byte factor2 = 0;
byte factor3 = 0;
int aum;

int mini, maxi; //control sensor
int actualizar = 30;

void setup() {
  Serial.begin(9600);
  
  mini = 50;
  maxi = 350;

  for (int i = 0; i < LECTURAS; i++){
    leer[i] = 0;
  }

  pinMode(F1, OUTPUT);
  pinMode(F2, OUTPUT);
  pinMode(F3, OUTPUT);
  pinMode(F4, OUTPUT);
  pinMode(F5, OUTPUT);
}

void loop() {
  val = analogRead(antenaPin);

  if(val >= 1){
    val = constrain(val, 1, limite);
    val = map(val, 1, limite, 1, 999);

    total -= leer[index];
    leer[index] = val;
    total += leer[index];    
    index = (index + 1); 

    if (index >= LECTURAS){
      index = 0;
    }

    antena = total / LECTURAS;
    
    //////////////////////////////////////

    lucesVal = constrain(antena, 50, 350);
    lucesVal = map(antena, mini, maxi, 0, 255);
    factor1 = lucesVal;
    factor2 = map(lucesVal, 0, 255, 255, 0);
    factor2 = constrain(factor2, 0, 255);
    factor3 = factor3 + aum;
    aum = map(lucesVal, 0, 255, 1, 20);
    
    if(factor3 == 0 || factor3 == 255){
      aum = -aum;
    }
    
    analogWrite(F1, factor1);
    analogWrite(F2, factor2);
    analogWrite(F3, factor3);
    analogWrite(F4, factor2);
    analogWrite(F5, factor1);
    
    Serial.print(antena);
    Serial.print(" ");
    Serial.print(factor1);
    Serial.print(" ");
    Serial.print(factor2);
    Serial.print(" ");
    Serial.println(factor3);
    delay(actualizar);
  }
  else{
    analogWrite(F1, 0);
    analogWrite(F2, 0);
    analogWrite(F3, 0);
    analogWrite(F4, 0);
    analogWrite(F5, 0);
  }
}
