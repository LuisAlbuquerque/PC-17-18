Obj[] objects= new Obj[6];
PImage background;
PImage backgroundJogo;
boolean[] keyboard= {false,false,false};



ArrayList<TEXTBOX> textboxes = new ArrayList<TEXTBOX>();
ArrayList<TEXTBOXP> textboxesP = new ArrayList<TEXTBOXP>();
ArrayList<Caixa> caixas = new ArrayList<Caixa>();
int logged = 2; // 0 para login, 1 para failed, e 2 para enquanto nao clica enter
int create = 2; // 0 creado para sucesso, 1 para já existe o username, e 2 para enquanto nao clica enter
int switchBackground = 1;
//estados
final int stateMenu = 0;
final int stateLogin = 1;
final int stateCreateC = 2;
final int stateRecuperarC = 3;
final int statePlay = 4;
final int stateOpcoes= 5;
final int stateJogar= 6;
final int stateRanking= 7;
final int stateHelp= 8;

//int state= stateMenu; 
int state= stateJogar; 
// variaveis caixas

int mw=200;
int mh=50;
int mx= (width-200) / 2;
int my1= 100;
int my2= 200;
int my3= 300;
int my4= 300;

void setup() {
   size(displayWidth, displayHeight);
   background=loadImage("menu.png");
   backgroundJogo=loadImage("background5.jpg");
   background.resize(displayWidth, displayHeight);
   backgroundJogo.resize(displayWidth, displayHeight);
    objects[0]=new player(700,450,"Canada.png",0);
    objects[1]=new player(1300,450,"portugal.png",1);
    objects[2]=new enemy();
    objects[3]=new enemy();
    objects[4]=new inkOrb();
    objects[5]=new inkOrb();
   caixas();
}


void draw() {
   switch(state){
     case stateMenu: background (background);
                     drawForStateMenu();
                     break;
     case stateLogin: background (background); 
                     drawForStateLogin();
                     break;
     case stateCreateC: background (background); 
                     drawForStateCreateC();
                     break;
     case stateRecuperarC: background (background); 
                     drawForStateRecuperarC();
                     break;
     case statePlay: background (background);
                     drawForStatePlay();
                     break;
     case stateJogar: background (backgroundJogo);
                      drawForStateJogar();
                      break;
     case stateHelp: background (background);
                     drawForStateHelp();
                     break;                  
     case stateOpcoes: background (background);
                     drawForStateOpcoes();
                     break;
     default : break;
   }
}
   
  
   


//________________________________________________________________________________//

// JUST FOR DEMO
void Submit() {
   if (textboxes.get(0).Text.equals("R")) {
      if (textboxesP.get(0).Text.equals("1")) {
         logged = 0;        
      } else {
         logged = 1;
      }
   } else {
         logged = 1;
      }
}



//_______________________________________________________________________________//

void mousePressed() {
   for (TEXTBOX t : textboxes) {
     
     t.PRESSED(mouseX, mouseY,t);
   }
   for (TEXTBOXP t : textboxesP) {
     t.PRESSED(mouseX, mouseY,t);
   }  
   
   for (Caixa t : caixas) {
     if (t.overBox(mouseX, mouseY)){
       switch(state){
         
         case stateMenu: 
           if (t == caixas.get(0)){
             state=stateLogin;
           }
           else if (t == caixas.get(1)){
             state=stateCreateC;
           }
           else if (t == caixas.get(2)){
             exit();
           }
           break;
         
         case stateLogin:
           if (t == caixas.get(3)){
             state=stateRecuperarC;
           }
           else if (t == caixas.get(9)){
             state=stateMenu;
           }
           
           else if (t == caixas.get(12)){
             if (textboxes.get(0).KEYPRESSED(key, (int)keyCode)) {
                 Submit();
            }
             if (textboxesP.get(0).KEYPRESSED(key, (int)keyCode)) {
               Submit();
            }
             if (logged==0) state=statePlay;
           }
           break;
        
        case stateCreateC:         
          if (t == caixas.get(9)){
               state=stateMenu;
           }
           break;
           
        case stateRecuperarC:         
          if (t == caixas.get(9)){
               state=stateMenu;
           }
           break;
           
        case statePlay:  
          if (t == caixas.get(5)){
             state=stateJogar;
          }
          else if (t == caixas.get(4)){
             state=stateOpcoes;
          }
          else if (t == caixas.get(6)){
           state=stateRanking;
          }
          else if (t == caixas.get(7)){
            state=stateHelp;
          }
          else if (t == caixas.get(8)){
            exit();
          }
          break;
          
        case stateOpcoes:
           if (t == caixas.get(10)){
             resizes(800,600);
           }
           else if (t == caixas.get(11)){
             resizes(1200,800);
           }
           else  if (t == caixas.get(9)){
               state=statePlay;
           }
           break;
           
        case stateHelp:
          if (t == caixas.get(9)){
               state=statePlay;
           }
           break;
       }
     }      
   }
}


void keyPressed(){
  
  if (state==stateLogin){
       if (textboxes.get(0).KEYPRESSED(key, (int)keyCode)) {
         Submit();
      }
       if (textboxesP.get(0).KEYPRESSED(key, (int)keyCode)) {
         Submit();
      }
   }
   if (state==stateCreateC){
       if (textboxes.get(1).KEYPRESSED(key, (int)keyCode)) {
         Submit();
      }
       if (textboxesP.get(1).KEYPRESSED(key, (int)keyCode)) {
         Submit();
      }
      if (textboxes.get(2).KEYPRESSED(key, (int)keyCode)) {
         Submit();
      }
   }
   
   if (state==stateJogar){
     if(key == 'w'){keyboard[0]=true;}
     if(key == 'a'){keyboard[1]=true;}
     if(key == 'd'){keyboard[2]=true;}
   }
   if (state==stateHelp){
     if(key == 'x'){state=statePlay;}
   }
   if (state==stateRecuperarC){
     if(key == 'x'){state=stateLogin;}
   }
   
   
}

void keyReleased(){
    if(key == 'w'){keyboard[0]=false;}
    if(key == 'a'){keyboard[1]=false;}
    if(key == 'd'){keyboard[2]=false;}
}
