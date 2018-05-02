float posx = 150;
float posy = 100;

float pos2x = 300;
float pos2y = 200;


float speed = 10;
float energia = 200;
float energia2 = 200;



void setup(){
size(800, 600);
background (75);
}

void draw(){
background (0);
display();
}
void barra(){
  fill(200,0,0);
  rect(150,20,energia,20);
}
void barra2(){
  fill(200,0,0);
  rect(600,20,energia,20);
}

void jogador1(){
  fill(0,0,200);
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
  fill(0,0,200);
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
  jogador1();
  jogador2();
  
  barra2();
if( energia > 0){
  barra();
}
}
void keyPressed(){
  if(key == 'w'){posy = posy - speed; energia = energia -1;}
  if(key == 's'){posy = posy + speed; energia = energia -1;}
  if(key == 'a'){posx = posx - speed;energia = energia -1;}
  if(key == 'd'){posx = posx + speed; energia = energia -1;}
}