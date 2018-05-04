//variaveis do menu
// consts for states  
final int stateGame=0;
final int stateMenu = 1;
final int tamanho = 2;
final int stateHelp = 3;  // when he hits F1 
// current state 
int state = stateMenu;
//
int playerNumber = 0;

// restantes variáveis

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

float speed = 10;
float energia = 200;
float energia2 = 200;

PImage background;
PImage player1;
PImage player2;
PImage gameOver;


import java.awt.event.KeyEvent;

void setup(){
  size(800, 600);
  surface.setResizable(true);
  background=loadImage("background4.jpg");
  player1=loadImage("Canada.png");
  player2=loadImage("portugal.png");
  gameOver= loadImage("GameOver.jpg");
  v1 = new PVector(40, 20);
  v2 = new PVector(25, 50);
}
void draw () { 
  // runs on and on in a loop
  background(255);
  fill(0);
  
  textSize(22);
  switch(state) {
  case stateGame:
    drawForStateGame();
    break;
  case tamanho:
    drawStateTamanho();
    break; 
  case stateHelp:
    drawForStateHelp();
    break;  
  case stateMenu:
    drawForStateMenu();
    break; 
  default:
    // error 
    break;
   }
}
//-------------------------------------------------------------------//
//Estados//

void drawForStateGame() {
  background (background);
  display();
}

void drawForStateHelp() {
  text("the help...", 200, 100);
}
void drawStateTamanho(){
  text("Escolha o tamanho da janela", 200, 100);
  text("  1- 640x480 ", 200, 150);
  text("  2- 800x600 ", 200, 200);
  text("  3- 1024x768 ", 200, 250);
}

void drawForStateMenu() {
  text("the menu", 200, 100);
  text("  Clica 1 para jogar ", 200, 150);
  text("  Clica x para sair ", 200, 200);
  
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
  if(keyboard[0] == true){v1.add((PVector.fromAngle(angle)).setMag(10)); energia -= 0.5;}
  if(keyboard[1] == true){angle-=0.05;}
  if(keyboard[2] == true){angle+=0.05;}
  

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

//------------------------------------------------------------//
//KeyPressed

void keyPressed() {
  // states: 
  switch(state) {
  case stateGame:
    //     
    if (keyCode==java.awt.event.KeyEvent.VK_F1) {
      // F1
      state =  stateHelp;
    } // if 
    break;
  case tamanho:
  
  
    switch(key){
      case '1':
       
        surface.setSize(640,480);
        image(background, 0,0);
        background.resize(640, 480);
        image(background, 0,0);
        image(player1, 0,0);
        player1.resize(640, 480);
        image(player1, 0,0);
        image(player2, 0,0);
        player2.resize(640, 480);
        image(player2, 0,0);
        image(gameOver, 0,0);
        gameOver.resize(640, 480);
        image(gameOver, 0,0);
        break;
      case '2':
        
        surface.setSize(800,600);
        image(background, 0,0);
        background.resize(800, 600);
        image(background, 0,0);
        image(player1, 0,0);
        player1.resize(800, 600);
        image(player1, 0,0);
        image(player2, 0,0);
        player2.resize(800, 600);
        image(player2, 0,0);
        image(gameOver, 0,0);
        gameOver.resize(800, 600);
        image(gameOver, 0,0);
        break;
      case '3':
        
        surface.setSize(1024,768);
        image(background, 0,0);
        background.resize(1024, 768);
        image(background, 0,0);
        image(player1, 0,0);
        player1.resize(1024, 768);
        image(player1, 0,0);
        image(player2, 0,0);
        player2.resize(1024, 768);
        image(player2, 0,0);
        image(gameOver, 0,0);
        gameOver.resize(1024, 768);
        image(gameOver, 0,0);
        break;
     default :
        println ("unknown input");
        break;
    }
    
    
  case stateHelp:
    // back to game 
    state = stateGame;
    break;  
  case stateMenu:
    // read key in menu
    switch (key) {
    case '1' :
      playerNumber = 2;
      state = tamanho;
      break;
    case 'x':
      exit();
      break;
    default :
      println ("unknown input");
      break;
    } // inner switch  
    break; 
  default:
    // error 
    break;
  } // switch
  //
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