float posx = 150;
float posy = 100;

float pos2x = 300;
float pos2y = 200;

float x = 30;
float y = 59;
float z = 370;
float w = 59;

float speed = 10;
float energia = 200;
float energia2 = 200;

PImage background;
PImage playerCanada;

import java.awt.event.KeyEvent;

void setup(){
  size(1280, 720);
  background=loadImage("background.jpg");
  playerCanada=loadImage("Canada.png");
}

void draw(){
  background (background);
  display();
}
void imagem1(float x, float y){
  image(playerCanada,x-19,y-30);
}

void imagem2(float z, float w){
  rectMode(CENTER);
  rect(z,30,55,55);
  fill(0,100,100);
  ellipse(z,w-30,50,50);
  fill(255,255,255);
  ellipse(z-19,w-30,13.333,18.333);
  ellipse(z+19,w-30,13.333,18.333);
}

void barra(){
  fill(200,0,0);
  rect(160-(100-energia/2),20,energia,20);
}
void barra2(){
  fill(200,0,0);
  rect(500-(100-energia2/2),20,energia2,20);
}

void jogador1(){
  image(playerCanada,posx,posy-30,100,100);
  
}

void jogador2(){
  fill(0,100,100);
  //background (75);
  rectMode(CENTER);
  rect(pos2x,pos2y,20,100);
  //ellipse(100,70,60,60);
  //ellipse(81,70,16,32); 
  //ellipse(119,70,16,32); 
  ellipse(pos2x,pos2y-30,60,60);
  fill(255,255,255);
  ellipse(pos2x-19,pos2y-30,16,32); 
  ellipse(pos2x+19,pos2y-30,16,32);
  
 // line(90,150,80,160);
  //line(110,150,120,160);
  line(pos2x-10,pos2y+50,pos2x-20,pos2y+60);
  line(pos2x+10,pos2y+50,pos2x+20,pos2y+60);
}

void display(){
  
if( energia > 0){
  imagem1(x,y);
  jogador1();
  barra();
}
else{
  PFont font;
  font = createFont("Georgia", 32);
  textFont(font);
  text("Game Over", 10, 50);
}

if( energia2 > 0){
  imagem2(z,w);
  jogador2();
  barra2();
}
else{
  PFont font;
  font = createFont("Georgia", 32);
  textFont(font);
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
