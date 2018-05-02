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
import java.awt.event.KeyEvent;

void setup(){
size(800, 600);
background (75);
}

void draw(){
background (0);
display();
}
void imagem1(float x, float y){
  rectMode(CENTER);
  rect(30,30,55,55);
  fill(100,0,100);
  ellipse(x,y-30,50,50);
  fill(255,255,255);
  ellipse(x-19,y-30,13.333,18.333);
  ellipse(x+19,y-30,13.333,18.333);
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
  rect(160,20,energia,20);
}
void barra2(){
  fill(200,0,0);
  rect(500,20,energia2,20);
}

void jogador1(){
  fill(100,0,100);
  //background (75);
  rectMode(CENTER);
  rect(posx,posy,20,100);
  //ellipse(100,70,60,60);
  //ellipse(81,70,16,32); 
  //ellipse(119,70,16,32); 
  ellipse(posx,posy-30,60,60);
  fill(255,255,255);
  ellipse(posx-19,posy-30,16,32);
  ellipse(posx+19,posy-30,16,32);
  
 // line(90,150,80,160);
  //line(110,150,120,160);
  line(posx-10,posy+50,posx-20,posy+60);
  line(posx+10,posy+50,posx+20,posy+60);
  
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
  //fill(0,255,0);
  background (75);
  
if( energia > 0){
  imagem1(x,y);
  jogador1();
  barra();
}

if( energia2 > 0){
  imagem2(z,w);
  jogador2();
  barra2();
}
}
void keyPressed(){
  if(key == 'w'){posy = posy - speed; energia = energia -1;}
  if(key == 's'){posy = posy + speed; energia = energia -1;}
  if(key == 'a'){posx = posx - speed;energia = energia -1;}
  if(key == 'd'){posx = posx + speed; energia = energia -1;}
  
  if(key == '8'){pos2y = pos2y - speed; energia2 = energia2 -1;}
  if(key == '5'){pos2y = pos2y + speed; energia2 = energia2 -1;}
  if(key == '4'){pos2x = pos2x - speed;energia2 = energia2 -1;}
  if(key == '6'){pos2x = pos2x + speed; energia2 = energia2 -1;}
  
}