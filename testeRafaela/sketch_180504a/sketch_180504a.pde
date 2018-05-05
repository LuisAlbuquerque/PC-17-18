//variaveis do menu
 
final int stateGame=0;
final int stateMenu = 1;
final int tamanho = 2;
final int stateHelp = 3;  // when he hits F1 

float mx1 = 200;
float my1 = 150;
float mx2 = 200;
float my2 = 250;
float mx3 = 200;
float my3 = 350;
float mw = 150;
float mh = 80;

int state = stateMenu;

int playerNumber = 0;

// restantes variáveis

float posx = 500;
float posy = 340;

float pos2x =640;
float pos2y = 340;

float angle1 = 0;
float angle2 = 0;

PVector v1, v2;

boolean[] keyboard={false,false,false, false, false, false};

float x = 0;
float y = 0;
float z = 350;
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
  text("Teclas:", 20, 100);
  text("Criaturas:",20,210);
  textSize(18);
  text("As setas esquerda e direita provocam aceleração angular, na direcção respectiva, a seta", 20,120);
  text("para a frente provoca aceleração linear na direcção para onde está voltado o jogador.", 20,140);
  text("Cada propulsor gasta energia enquanto está a ser actuado;", 20, 160);
  text("As baterias são carregadas lentamente.", 20, 180);
  text("As criaturas verdes quando capturadas dão energia, até ao máximo da bateria.",20,230);
  text("As criaturas vermelhas, aparecem a cada 10 segundos numa posição aleatória.",20,250); 
  textSize(10);
  text("Clique x para voltar ao menu",20,300);
}
void drawStateTamanho(){
  text("Escolha o tamanho da janela", 200, 100);
  text("  1- 640x480 ", 200, 150);
  text("  2- 800x600 ", 200, 200);
}

void drawForStateMenu() {
  text("MENU", 200, 100);
  fill(255);
  stroke(204, 102, 0);
  rect(mx1,my1,mw,mh);
  fill(0);
  text(" Jogar ", 230, 200);
  fill(255);
  rect(mx2,my2,mw,mh);
  fill(0);
  text(" Sair ", 230, 300);
  fill(255);
  rect(mx3,my3,mw,mh);
  fill(0);
  text(" Ajuda ", 230, 400);
  
}
void tamanhoB(int a, int b){
        surface.setSize(a,b);
        image(background, 0,0);
        background.resize(a, b);
        image(background, 0,0);
        
        image(gameOver, 0,0);
        gameOver.resize(a, b);
        image(gameOver, 0,0);

}

//-----------------------------------------------------------------------------------------//
//jogadores

void imagem1(float x, float y){
  image(player1,x,y,50,50);
}

void imagem2(float z, float w){
  image(player2,z,w,50,50);
}

void barra(){
  fill(200,0,0);
  rect(50,20,energia,20);
}
void barra2(){
  fill(200,0,0);
  rect(400,20,energia2,20);
}

void jogador1(){
  pushMatrix();
  translate(v1.x,v1.y);
  rotate(angle1);
  translate(-50,-50);
  tint(255, 255-(200-energia));
  image(player1,x+5,y+100,100,100);
  tint(255, 255);
  popMatrix();
}

void jogador2(){
  pushMatrix();
  translate(v2.x,v2.y);
  rotate(angle2);
  translate(-50,-50);
  tint(255, 255- (200-energia2));
  image(player2,z,w+100,90,90);
  tint(255, 255);
  popMatrix();
}

void display(){
  if(keyboard[0] == true){v1.add((PVector.fromAngle(angle1)).setMag(10)); energia -= 0.5;}
  if(keyboard[1] == true){angle1-=0.05;}
  if(keyboard[2] == true){angle1+=0.05;}
  
  if(keyboard[3] == true){v2.add((PVector.fromAngle(angle2)).setMag(10)); energia2 -= 0.5;}
  if(keyboard[4] == true){angle2-=0.05;}
  if(keyboard[5] == true){angle2+=0.05;}

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
        tamanhoB(640,480);
        state = stateGame;
        break;
      case '2':
        tamanhoB(800,600);
        state = stateGame;
        break;
     default :
        println ("unknown input");
        break;
     }
  case stateHelp:
    if (key=='x') {
      state = stateMenu;
    }
    if (keyCode==java.awt.event.KeyEvent.VK_F1) {
      state = stateGame;
    }
    break;  
  
  default:
    // error 
    break;
  }// switch
  //
  if(key == 'w'){keyboard[0]=true;}
  if(key == 'a'){keyboard[1]=true;}
  if(key == 'd'){keyboard[2]=true;}
  
  if (key == CODED) {
    if (keyCode == UP){
      keyboard[3]=true;
    }if (keyCode == LEFT){
      keyboard[4]=true;
    }if (keyCode == RIGHT){
      keyboard[5]=true;
    }
  }
}
void mousePressed() {
  switch(state){
    case stateMenu:
       if(mouseX>mx1 && mouseX <mx1+mw && mouseY>my1 && mouseY <my1+mh){
        state = tamanho;
        println("The mouse is pressed the button jogar"); 
      }
      if(mouseX>mx2 && mouseX <mx2+mw && mouseY>my2 && mouseY <my2+mh){
       exit();
       println("The mouse is pressed the button sair"); 
      }
      if(mouseX>mx3 && mouseX <mx3+mw && mouseY>my3 && mouseY <my3+mh){
       state = stateHelp;
       println("The mouse is pressed the button ajuda"); 
      }
  }
}

void keyReleased(){
    if(key == 'w'){keyboard[0]=false;}
    if(key == 'a'){keyboard[1]=false;}
    if(key == 'd'){keyboard[2]=false;}
    if (key == CODED) {
      if (keyCode == UP){
        keyboard[3]=false;
      }if (keyCode == LEFT){
        keyboard[4]=false;
      }if (keyCode == RIGHT){
        keyboard[5]=false;
      }
    }
}