import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;
import java.util.Arrays;

import java.io.*;
import java.net.*;

Variaveis v = new Variaveis();


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



void setup() {
   size(1300, 700);
   v.background=loadImage("menu.png");
   v.backgroundJogo=loadImage("background5.jpg");
   v.background.resize(1300, 700);
   v.backgroundJogo.resize(1300, 700);
   caixas();

   try{
      Socket s = new Socket(v.port1, Integer.parseInt(v.port2));
      v.receiver = new Receiver(s);
      v.senderC = new Sender(s);
      Thread reader = new Thread(v.receiver);
      Thread sender = new Thread(v.senderC);
      reader.start();
      sender.start();
   }catch(Exception e){
      e.printStackTrace();
      System.exit(0);
   }
   
   //rec.add("ola");
   v.nivel.add(v.um);
   v.nivel.add(v.dois);
   v.nivel.add(v.tres);
   v.score.add(v.doiss);
   v.score.add(v.tress);
   v.score.add(v.ums);
}


void draw() {
   switch(v.state){
     case stateMenu: background (v.background);
                     drawForStateMenu();
                     break;
     case stateLogin: background (v.background); 
                     drawForStateLogin();
                     break;
     case stateCreateC: background (v.background); 
                     drawForStateCreateC();
                     break;
     case stateRecuperarC: background (v.background); 
                     drawForStateRecuperarC();
                     break;
     case statePlay: background (v.background);
                     drawForStatePlay();
                     //println(v.rec);
                     break;
     case stateJogar: background (v.backgroundJogo);
                      drawForStateJogar();
                      v.send = String.join("","tecla,", v.keyboard[0] ? "w" : "",  v.keyboard[1] ? "a" : "",  v.keyboard[2] ? "d" : "");
                      v.senderC.out.println(v.send);
                      break;
     case stateHelp: background (v.background);
                     drawForStateHelp();
                     break;
     case stateGmov: background (v.background);
                     drawForStateGameOver();
                     break;
     case stateRanking: background (v.background);
                     drawForStateRanking();
                     break;
     case stateEspera: background (v.backgroundJogo);
                     drawForStateEspera();
                     break;
     case stateRemC: background (v.background);
                     drawForStateRemC();
                     break;
     default : break;
     
   }
}
   
  
   


//________________________________________________________________________________//

// JUST FOR DEMO
public void Submit() {
  if(v.textboxes.get(0).Text.matches("[a-zA-Z0-9]*") && v.textboxesP.get(0).Text.matches("[a-zA-Z0-9]*")){
    v.username = v.textboxes.get(0).nome;
    v.password = v.textboxesP.get(0).pass;

    v.send = String.join(",", "login", v.username, v.password);
    v.senderC.out.println(v.send);
  }else{
    v.logged = 1;
  }
}
// Signup
public void Create() {
  if(v.textboxes.get(2).Text.matches("[a-zA-Z0-9]*") && v.textboxesP.get(1).Text.matches("[a-zA-Z0-9]*") && v.textboxes.get(1).Text.matches("^[A-Za-z0-9+_.-]+@(.+)$")){
    v.username = v.textboxes.get(2).Text;
    v.password = v.textboxesP.get(1).Text;
    v.mail = v.textboxes.get(1).Text;

    v.send = String.join(",", "create_accont", v.username, v.password, v.mail);
    v.senderC.out.println(v.send);
  }else{
    v.create = 1;
  }
}

public void Remove() {
  if(v.textboxes.get(3).Text.matches("[a-zA-Z0-9]*") && v.textboxesP.get(3).Text.matches("[a-zA-Z0-9]*") && v.textboxes.get(4).Text.matches("^[A-Za-z0-9+_.-]+@(.+)$")){
    v.username = v.textboxes.get(3).Text;
    v.password = v.textboxesP.get(3).Text;
    v.mail = v.textboxes.get(4).Text;

    v.send = String.join(",", "remove_accont", v.username, v.password,v.mail);
    v.senderC.out.println(v.send);
  }else{
    v.remove = 1;
  }
}
public void Recuperate() {
  if(v.textboxes.get(1).Text.matches("^[A-Za-z0-9+_.-]+@(.+)$")){
    v.mail = v.textboxes.get(1).Text;

    v.send = String.join(",", "rec_accont", v.username, v.password, v.mail);
    v.senderC.out.println(v.send);
  }else{
    v.recuperate = 1;
  }
}



//_______________________________________________________________________________//

void mousePressed() {
   for (TEXTBOX t : v.textboxes) {
     
     t.PRESSED(mouseX, mouseY,t);
   }
   for (TEXTBOXP t : v.textboxesP) {
     t.PRESSED(mouseX, mouseY,t);
   }  
   
   for (Caixa t : v.caixas) {
     if (t.overBox(mouseX, mouseY)){
       switch(v.state){
         
         case stateMenu: 
           if (t == v.caixas.get(0)){
             v.state=stateLogin;
           }
           else if (t == v.caixas.get(1)){
             v.state=stateCreateC;
           }
           else if (t == v.caixas.get(15)){
             v.state=stateRemC;
           }
           else if (t == v.caixas.get(2)){
             exit();
           }
           break;
         
         case stateLogin:
           if (t == v.caixas.get(3)){
             v.send = String.join(",", "rec_accont", v.username, v.password);
             v.senderC.out.println(v.send);
           }
           else if (t == v.caixas.get(9)){
            v.state=stateMenu;
            v.textboxes.get(0).nome = "";
            v.textboxes.get(0).Text = "";
            v.textboxesP.get(0).pass= "";
            v.textboxesP.get(0).esconde= "";
            v.textboxesP.get(0).Text= "";
           }
           
           else if (t == v.caixas.get(12)){
             Submit();
             if (v.logged==0) v.state=statePlay;
           }
           break;
        
        case stateCreateC:         
          if (t == v.caixas.get(9)){
               v.state=stateMenu;
               v.textboxes.get(2).nome = "";
               v.textboxes.get(2).Text = "";
               v.textboxesP.get(1).pass= "";
               v.textboxesP.get(1).esconde= "";
               v.textboxesP.get(1).Text= "";
               v.textboxes.get(1).nome = "";
               v.textboxes.get(1).Text = "";
               v.create=2;
           }
           else if (t == v.caixas.get(16)){
             Create();
             if (v.create==0) v.state=statePlay;
           }
           break;
           
        case stateRecuperarC:         

          if (t == v.caixas.get(9)){
               v.state=stateMenu;
               v.textboxes.get(1).nome = "";
               v.textboxes.get(1).Text = "";
               v.recuperate=2;
           }
           else if (t == v.caixas.get(16)){
             Recuperate();
             if (v.recuperate==0) v.state=stateLogin;
           }
                
           break;
      
        case stateRemC:         
          if (t == v.caixas.get(9)){
               v.state=stateMenu;
               v.textboxes.get(3).nome = "";
               v.textboxes.get(3).Text = "";
               v.textboxesP.get(2).pass= "";
               v.textboxesP.get(2).esconde= "";
               v.textboxesP.get(2).Text= "";
               v.textboxes.get(4).nome = "";
               v.textboxes.get(4).Text = "";
               v.remove=2;
           }
          else if (t == v.caixas.get(15)){
             Remove();
             if (v.remove==0) v.state=stateMenu;
           }
           break;
           
        case statePlay:
          if (t == v.caixas.get(5)){
             v.send = String.join(",", "play", v.username, v.password);
             v.senderC.out.println(v.send);
             println(v.send);
          }
          else if (t == v.caixas.get(4)){
             v.state=stateOpcoes;
          }
          else if (t == v.caixas.get(6)){
           v.send = String.join(",", "ranking", "", "");
           v.senderC.out.println(v.send);

           
           v.state=stateRanking;
          }
          else if (t == v.caixas.get(7)){
            v.state=stateHelp;
          }
          else if (t == v.caixas.get(8)){
            v.send = String.join(",", "logout", v.username, v.password);
            v.senderC.out.println(v.send);
            println(v.send);
          }
          break;
          
        case stateRanking:
          
          if (t == v.caixas.get(9)){
             v.state=statePlay;
          }
          break;
       
       case stateEspera:
          if (t == v.caixas.get(9)){
             v.state=statePlay;
          }
          break;
           
        case stateHelp:
          if (t == v.caixas.get(9)){
               v.state=statePlay;
           }
           break;
         case stateGmov:
          if (t == v.caixas.get(13)){
               v.send = String.join(",", "play", v.username, v.password);
               v.senderC.out.println(v.send);
           }
           else if (t == v.caixas.get(14)){
               v.state=statePlay;
           }
           break;
       }
     }      
   }
}


void keyPressed(){
  
  if (v.state==stateLogin){
       if (v.textboxes.get(0).KEYPRESSED(key, (int)keyCode)) {
         Submit();
      }
       if (v.textboxesP.get(0).KEYPRESSED(key, (int)keyCode)) {
         Submit();
      }
   }
   if (v.state==stateCreateC){
       if (v.textboxes.get(2).KEYPRESSED(key, (int)keyCode)) {
         Create();
      }
       if (v.textboxesP.get(1).KEYPRESSED(key, (int)keyCode)) {
         Create();
      }
      if (v.textboxes.get(1).KEYPRESSED(key, (int)keyCode)) {
         Create();
      }
   }
   if (v.state==stateRecuperarC){
      if (v.textboxes.get(1).KEYPRESSED(key, (int)keyCode)) {
         Submit();
      }
      
   }
   if (v.state==stateRemC){
      if (v.textboxes.get(3).KEYPRESSED(key, (int)keyCode)) {
         Submit();
      }
       if (v.textboxesP.get(2).KEYPRESSED(key, (int)keyCode)) {
         Submit();
      }
      if (v.textboxes.get(4).KEYPRESSED(key, (int)keyCode)) {
         Submit();
      }
      
   }
   
   if (v.state==stateJogar){
     if(key == 'w'){v.keyboard[0]=true;}
     if(key == 'a'){v.keyboard[1]=true;}
     if(key == 'd'){v.keyboard[2]=true;}
   }
   if (v.state==stateHelp){
     if(key == 'x'){v.state=statePlay;}
   }
   if (v.state==stateRecuperarC){
     if(key == 'x'){v.state=stateLogin;}
   }
   
   
}

void keyReleased(){
    if(key == 'w'){v.keyboard[0]=false;}
    if(key == 'a'){v.keyboard[1]=false;}
    if(key == 'd'){v.keyboard[2]=false;}
}
