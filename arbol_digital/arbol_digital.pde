/***************************************/
//  Processing v 2.2.1                 //
//                                     //
//  Librerías:                         //
//    oscP5                            //
/***************************************/

import oscP5.*;
import netP5.*;

OscP5 puerto;

PImage[] arbol_1 = new PImage[11];
PImage[] arbol_2 = new PImage[11];
PImage[] arbol_3 = new PImage[11];
PImage[] arbol_4 = new PImage[11];
PImage[] arbol_5 = new PImage[11];

PImage fondo, luz;

int antena;
int vel_1, vel_2, vel_3;
int cuadro_1, cuadro_2, cuadro_3;
int min, max;

int lucesVal = 0;
int factor1, factor2, factor3;
int aum;

void setup() {
  size(1024, 768);

  smooth(1);

  max = 350;
  min = 50;

  puerto = new OscP5(this, 12001);

  for (int i = 0; i < 11; i++) {
    arbol_1[i] = loadImage("arbol_1/"+nf(i+1, 2)+".png");
    arbol_2[i] = loadImage("arbol_2/"+nf(i+1, 2)+".png");
    arbol_3[i] = loadImage("arbol_3/"+nf(i+1, 2)+".png");
    arbol_4[i] = loadImage("arbol_4/"+nf(i+1, 2)+".png");
    arbol_5[i] = loadImage("arbol_5/"+nf(i+1, 2)+".png");
  }

  noCursor();

  fondo = loadImage("fondo.png");
  luz = loadImage("luz.png");

  vel_1 = 1;
  vel_2 = 1;
  vel_3 = 1;
}

void draw() {

  for (int x = 0; x < width; x+=7) {
    for (int y = 0; y < height; y+=7) {
      pushStyle();
      noStroke();
      fill(random(15), 100);
      rect(x, y, 7, 7);
      popStyle();
    }
  }

  pushStyle();
  image(arbol_1[cuadro_2], 0, height-arbol_1[0].height/3, arbol_1[0].width/3, arbol_1[0].height/3);
  image(arbol_2[cuadro_1], 220, height-arbol_2[0].height/2.5-30, arbol_2[0].width/2.5, arbol_2[0].height/2.5);
  image(arbol_3[cuadro_3], 360, height-arbol_3[0].height/3.4, arbol_3[0].width/3.4, arbol_3[0].height/3.4);
  image(arbol_4[cuadro_1], 490, height-arbol_4[0].height/3.2-10, arbol_4[0].width/3.2, arbol_4[0].height/3.2);
  image(arbol_5[cuadro_2], 650, height-arbol_5[0].height/2.6-15, arbol_5[0].width/2.6, arbol_5[0].height/2.6);
  popStyle();

  pushStyle();
  imageMode(CENTER);
  tint(255, factor1);
  image(luz, 22, 541);
  image(luz, 124, 510);
  image(luz, 211, 537);
  popStyle();

  pushStyle();
  imageMode(CENTER);
  tint(255, factor2);
  image(luz, 284, 463, luz.height/1.5, luz.width/1.5);
  image(luz, 332, 451, luz.height/1.5, luz.width/1.5);
  image(luz, 370, 469, luz.height/1.5, luz.width/1.5);
  popStyle();

  pushStyle();
  imageMode(CENTER);
  tint(255, factor3);
  image(luz, 443, 574, luz.height/1.1, luz.width/1.1);
  image(luz, 462, 575, luz.height/1.1, luz.width/1.1);
  image(luz, 482, 580, luz.height/1.1, luz.width/1.1);
  popStyle();

  pushStyle();
  imageMode(CENTER);
  tint(255, factor2);
  image(luz, 543, 561);
  image(luz, 724, 579);
  popStyle();

  pushStyle();
  imageMode(CENTER);
  tint(255, factor1);
  image(luz, 683, 522);
  image(luz, 960, 526);
  image(luz, 896, 608);
  popStyle();

  if (frameCount % 3 == 0) {
    vel_1 = (int)map(antena, min, max, 3, 20);
    vel_2 = (int)map(antena, min, max, 20, 3);
    vel_3 = (int)map(antena, min, max, 3, 12);

    vel_1 = (int)constrain(vel_1, 3, 20);
    vel_2 = (int)constrain(vel_2, 3, 20);
    vel_3 = (int)constrain(vel_3, 2, 12);
  }

  println(antena, factor1, factor2, factor3);

  cuadro_1 = animarSprites(11, cuadro_1, vel_1, true);
  cuadro_2 = animarSprites(11, cuadro_2, vel_2, true);
  cuadro_3 = animarSprites(11, cuadro_3, vel_3, true);
}

void oscEvent(OscMessage mensaje) {
  if (mensaje.checkAddrPattern("/ant")==true) {
    antena = mensaje.get(0).intValue();
  } else if (mensaje.checkAddrPattern("/f1")==true) {
    factor1 = mensaje.get(0).intValue();
  } else if (mensaje.checkAddrPattern("/f2")==true) {
    factor2 = mensaje.get(0).intValue();
  } else if (mensaje.checkAddrPattern("/f3")==true) {
    factor3 = mensaje.get(0).intValue();
  }
}

