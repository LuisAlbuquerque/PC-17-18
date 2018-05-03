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
PImage player1;
PImage player2;

import java.awt.event.KeyEvent;

void setup(){
  size(1920, 1080);
  background=loadImage("background4.jpg");
  player1=loadImage("Canada.png");
  player2=loadImage("portugal.png");
}

void draw(){
  background (background);
  display();
}
void imagem1(float x, float y){
  image(player1,x,y,50,50);
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
  tint(255, 255-(200-energia));
  image(player1,posx,posy-30,100,100);
  tint(255, 255);
  
}

void jogador2(){
  tint(255, 255- (200-energia2));
  image(player2,pos2x,pos2y-30,90,90);
  tint(255, 255);
}


 
void display(){
  
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
  imagem2(z,w);
  jogador2();
  barra2();
  
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
