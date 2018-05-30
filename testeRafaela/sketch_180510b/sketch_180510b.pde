import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

import java.io.*;
import java.net.*;

String[] rec;
String send;
String username;
String password;
ArrayList<Obj> objects = new ArrayList<Obj>();



//Obj[] objects= new Obj[6];
PImage background;
PImage backgroundJogo;
boolean[] keyboard= {false,false,false};
public int N = 1;
public int Score = 50;
public int gameover= 1;
ArrayList<Top3> nivel= new ArrayList<Top3>();
ArrayList<Top3> score= new ArrayList<Top3>();
ArrayList<TEXTBOX> textboxes = new ArrayList<TEXTBOX>();
ArrayList<TEXTBOXP> textboxesP = new ArrayList<TEXTBOXP>();
ArrayList<Caixa> caixas = new ArrayList<Caixa>();
int logged = 2; // 0 para login, 1 para failed, e 2 para enquanto nao clica enter
int create = 2; // 0 criado para sucesso, 1 para já existe o username, e 2 para enquanto nao clica enter
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
final int stateGmov=9;
final int stateEspera=10;
final int stateRemC=11;

int state= stateMenu;
public int start = 0;
// variaveis caixas

int mw=200;
int mh=50;
int mx= (width-200) / 2;
int my1= 100;
int my2= 200;
int my3= 300;
int my4= 300;
Top3 um = new Top3();
Top3 dois = new Top3();
Top3 tres = new Top3();
Top3 ums = new Top3();
Top3 doiss = new Top3();
Top3 tress = new Top3();

 




void setup() {
   size(1300, 700);
   background=loadImage("menu.png");
   backgroundJogo=loadImage("background5.jpg");
   background.resize(1300, 700);
   backgroundJogo.resize(1300, 700);
   /*
    objects[0]=new player(700,450,"Canada.png",0);
    objects[1]=new player(1300,450,"portugal.png",1);
    objects[2]=new enemy();
    objects[3]=new enemy();
    objects[4]=new inkOrb();
    objects[5]=new inkOrb();
    */
   caixas();
   nivel.add(um);
   nivel.add(dois);
   nivel.add(tres);
   score.add(doiss);
   score.add(tress);
   score.add(ums);
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
                      if(rec[0].equals("gameover") || rec[0].equals("win")){
                        state=stateGmov;
                      }else{
                        objects.clear();
                        objects.add(0,new player(0,rec[0],rec[1],rec[8],rec[6],rec[14],rec[10],rec[11],rec[4]));
                        objects.add(1,new player(1,rec[2],rec[3],rec[9],rec[7],rec[15],rec[12],rec[13],rec[5]));
                        objects.add(2,new inkOrb(rec[16],rec[17]));
                        objects.add(3,new inkOrb(rec[18],rec[19]));
                        for(int x = 20, y = 21; y < objects.size(); x+=2, y+=2){
                          objects.add(new enemy(rec[x],rec[y]));
                        }
                        send = String.join(",", String.valueOf(keyboard[0]), String.valueOf(keyboard[1]), String.valueOf(keyboard[2]));
                      }
                      break;
     case stateHelp: background (background);
                     drawForStateHelp();
                     break;
     case stateGmov: background (background);
                     drawForStateGameOver();
                     break;
     case stateRanking: background (background);
                     um= new Top3(rec[0],int(rec[1]));
                     dois= new Top3(rec[2],int(rec[3]));
                     tres= new Top3(rec[4],int(rec[5]));
                     ums= new Top3(rec[6],int(rec[7]));
                     doiss= new Top3(rec[8],int(rec[9]));
                     tress= new Top3(rec[10],int(rec[11]));
                     drawForStateRanking();
                     break;
     case stateEspera: background (backgroundJogo);
                     drawForStateEspera();
                     if(int(rec[0])==1){
                       state=stateJogar;
                     }
                     break;
     case stateRemC: background (background);
                     drawForStateRemC();
                     break;
     default : break;
     
   }
}
   
  
   


//________________________________________________________________________________//

// JUST FOR DEMO
// JUST FOR DEMO
public void Submit() {
  if(textboxes.get(0).Text.matches("[a-zA-Z0-9]*") && textboxesP.get(0).Text.matches("[a-zA-Z0-9]*")){
    username = textboxes.get(0).Text;
    password = textboxes.get(0).Text;
    send = String.join(",", "login", username, password);
    if(rec[0].equals("ok")){
      logged = 0;
    }
    if(rec[0].equals("invalid")){
      logged = 1;
    }
  }else{
    logged = 1;
  }
}
// Signup
public void Create() {
  if(textboxes.get(2).Text.matches("[a-zA-Z0-9]*") && textboxesP.get(1).Text.matches("[a-zA-Z0-9]*") && textboxes.get(2).Text.matches("^[A-Za-z0-9+_.-]+@(.+)$")){
    username = textboxes.get(2).Text;
    password = textboxesP.get(1).Text;
    send = String.join(",", "login", username, password);
    if(rec[0].equals("ok")){
      create = 0;
    }
    if(rec[0].equals("invalid")){
      create = 1;
    }
  }else{
    create = 1;
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
           else if (t == caixas.get(15)){
             state=stateRemC;
           }
           else if (t == caixas.get(2)){
             exit();
           }
           break;
         
         case stateLogin:
           if (t == caixas.get(3)){
             state=stateRecuperarC;
             textboxes.get(0).nome = "";
             textboxes.get(0).Text = "";
             textboxesP.get(0).pass= "";
             textboxesP.get(0).esconde= "";
             textboxesP.get(0).Text= "";
             logged=2;
           }
           else if (t == caixas.get(9)){
             state=stateMenu;
             textboxes.get(0).nome = "";
             textboxes.get(0).Text = "";
             textboxesP.get(0).pass= "";
             textboxesP.get(0).esconde= "";
             textboxesP.get(0).Text= "";
             logged=2;
           }
           
           else if (t == caixas.get(12)){
             Submit();
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
        case stateRemC:         
          if (t == caixas.get(9)){
               state=stateMenu;
           }
           break;
           
        case statePlay:
          if (t == caixas.get(5)){
             send = String.join(",", "play", username, password);
             start = millis();
             state=stateEspera;
          }
          else if (t == caixas.get(4)){
             state=stateOpcoes;
          }
          else if (t == caixas.get(6)){
           send = String.join(",", "ranking", "", "");
           state=stateRanking;
          }
          else if (t == caixas.get(7)){
            state=stateHelp;
          }
          else if (t == caixas.get(8)){
            send = String.join(",", "logout", textboxes.get(0).Text, textboxesP.get(0).Text);
            state=stateMenu;
            textboxes.get(0).nome = "";
            textboxes.get(0).Text = "";
            textboxesP.get(0).pass= "";
            textboxesP.get(0).esconde= "";
            textboxesP.get(0).Text= "";
            logged=2;
          }
          break;
          
        case stateRanking:
          
          if (t == caixas.get(9)){
             state=statePlay;
          }
          break;
       
       case stateEspera:
          if (t == caixas.get(9)){
             state=statePlay;
          }
          break;
           
        case stateHelp:
          if (t == caixas.get(9)){
               state=statePlay;
           }
           break;
         case stateGmov:
          if (t == caixas.get(13)){
               send = String.join(",", "play", username, password);
               start = millis();
               state=stateEspera;
               gameover=1;
           }
           else if (t == caixas.get(14)){
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
       if (textboxes.get(2).KEYPRESSED(key, (int)keyCode)) {
         Submit();
      }
       if (textboxesP.get(1).KEYPRESSED(key, (int)keyCode)) {
         Submit();
      }
      if (textboxes.get(1).KEYPRESSED(key, (int)keyCode)) {
         Submit();
      }
   }
   if (state==stateRecuperarC){
      if (textboxes.get(1).KEYPRESSED(key, (int)keyCode)) {
         Submit();
      }
      
   }
   if (state==stateRemC){
      if (textboxes.get(3).KEYPRESSED(key, (int)keyCode)) {
         Submit();
      }
       if (textboxesP.get(2).KEYPRESSED(key, (int)keyCode)) {
         Submit();
      }
      if (textboxes.get(4).KEYPRESSED(key, (int)keyCode)) {
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
