float posx = 500;
float posy = 340;

float pos2x =640;
float pos2y = 340;

float angle = 0;

PVector v1, v2;

boolean[] keyboard={false,false,false};

float x = 0;
float y = 0;
float z = 450;
float w = 0;

int speed = 1;
float energia = 200;
float energia2 = 200;

PImage background;
PImage player1;
PImage player2;
PImage gameOver;


import java.awt.event.KeyEvent;

void setup(){
  size(1920, 1080);
  background=loadImage("background4.jpg");
  player1=loadImage("Canada.png");
  player2=loadImage("portugal.png");
  gameOver= loadImage("GameOver.jpg");
  v1 = new PVector(40, 20);
  v2 = new PVector(25, 50);
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
  pushMatrix();
  translate(v1.x,v1.y);
  rotate(angle);
  translate(-50,-50);
  tint(255, 255-(200-energia));
  image(player1,0,0,100,100);
  tint(255, 255);
  popMatrix();
}

void jogador2(){
  tint(255, 255- (200-energia2));
  image(player2,v2.x,v2.y-30,90,90);
  tint(255, 255);
}


 
void display(){
  if(keyboard[0] == true){v1.add(((PVector.fromAngle(angle)).setMag(speed)).limit(30)); energia -= 0.5;speed+=1;}else{speed=1;}
  if(keyboard[1] == true){angle-=0.08;}
  if(keyboard[2] == true){angle+=0.08;}
  

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
  if(energia <=0 || energia2 <= 0){
    background(gameOver);
  }
}
void keyPressed(){
  if(key == 'w'){keyboard[0]=true;}
  if(key == 'a'){keyboard[1]=true;}
  if(key == 'd'){keyboard[2]=true;}
  
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


void keyReleased(){
    if(key == 'w'){keyboard[0]=false;}
    if(key == 'a'){keyboard[1]=false;}
    if(key == 'd'){keyboard[2]=false;}
}
