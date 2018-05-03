float posx = 500;
float posy = 340;

float pos2x =640;
float pos2y = 340;

float x = 0;
float y = 0;
float z = 450;
float w = 0;

float speed = 10;
float energia = 200;
float energia2 = 200;

PImage background;
PImage playerCanada;
PImage player2;

import java.awt.event.KeyEvent;

void setup(){
  size(1280, 720);
  background=loadImage("background.jpg");
  playerCanada=loadImage("Canada.png");
  player2=loadImage("pais.png");
}

void draw(){
  background (background);
  display();
}
void imagem1(float x, float y){
  image(playerCanada,x,y,50,50);
}

void imagem2(float z, float w){
  image(player2,450,0,50,50);
}

void barra(){
  fill(200,0,0);
  rect(50,20,energia,20);
}
void barra2(){
  fill(200,0,0);
  rect(500,20,energia2,20);
}

void jogador1(){
  image(playerCanada,posx,posy-30,100,100);
  
}

void jogador2(){
  image(player2,pos2x,pos2y-30,100,100);
}

void display(){
  barra2();
if( energia > 0){
  imagem1(x,y);
  jogador1();
  barra();
}
else{
  PFont font;
  font = createFont("Georgia Bold", 60);
  textFont(font);
  fill(255,215,0);
  text("Game Over", 10, 50);
}

if( energia2 > 0){
  jogador2();
  
  imagem2(z,w);
}
else{
  PFont font;
  font = createFont("Georgia Bold", 60);
  textFont(font);
  fill(255,215,0);
  text("Game Over", 370, 50);
}
}
void keyPressed(){
  if(key == 'w'){posy = posy - speed; energia = energia -1;}
  if(key == 's'){posy = posy + speed; energia = energia -1;}
  if(key == 'a'){posx = posx - speed;energia = energia -1;}
  if(key == 'd'){posx = posx + speed; energia = energia -1;}
  
  if (key == CODED) {
    if (keyCode == DOWN){
      pos2y = pos2y + speed; energia2 = energia2 -1;
    }if (keyCode == UP){
      pos2y = pos2y - speed; energia2 = energia2 -1;
    }if (keyCode == LEFT){
      pos2x = pos2x - speed;energia2 = energia2 -1;
    }if (keyCode == RIGHT){
      pos2x = pos2x + speed; energia2 = energia2 -1;
    }
  }
      
}