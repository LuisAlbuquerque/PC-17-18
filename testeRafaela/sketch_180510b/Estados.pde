void drawForStateMenu() {
  fill(250, 250, 250);
  textSize(32);
  caixas.get(0).DRAW();
  caixas.get(1).DRAW();
  caixas.get(2).DRAW();
}

//---------------------------------------------------------------------------------------------------------------------------------------//

void drawForStateLogin() {
   // LABELS
   fill(250, 250, 250);
   text("LOGIN", (160 + textWidth("LOGIN")) / 2, 60);
   textSize(24);
   text("Utilizador: ", 20, 130);
   text("Password: ", 20, 180);
   
   // DRAW THE TEXTBOXES
   textboxes.get(0).DRAW();
   textboxesP.get(0).DRAW();
   textSize(18);
   caixas.get(3).DRAW(); 
   caixas.get(12).DRAW();
   textSize(32);
   caixas.get(9).DRAW();
   
   // JUST FOR DEMO (DO NOT EVER DO THAT!)
   if (logged==0) {
      fill(250, 250, 250);
      text("LOGIN FEITO COM SUCESSO!", 10, 300);
      state=statePlay;
   }
   else if (logged==1){
     fill(250, 250, 250);
     text("LOGIN SEM SUCESSO!", 10, 300);
   }
}

//----------------------------------------------------------------------------------------------------------------------------------------------//

void drawForStateCreateC() {
   // LABELS
   fill(250, 250, 250);
   text("CRIAR UMA CONTA", (160 + textWidth("CRIAR UMA CONTA")) / 2, 60);
   textSize(24);
   text("Email: ", 20, 230);
   text("Utilizador: ", 20, 130);
   text("Password: ", 20, 180);
   
   
   // DRAW THE TEXTBOXES
   caixas.get(9).DRAW();
   textboxes.get(2).DRAW();
   textboxesP.get(1).DRAW();
   textboxes.get(1).DRAW();
   
   // JUST FOR DEMO (DO NOT EVER DO THAT!)
   if (create==0) {
      fill(250, 250, 250);
      text("CONTA CRIADA COM SUCESSO !", (textWidth("CONTA CRIADA COM SUCESSO !")) / 3, 230);
   }
   else if (create==1){
     fill(250, 250, 250);
     text("O UTILIZADOR JÁ EXISTE!", (textWidth("UTILIZADOR JÁ EXISTE!")) / 3, 230);
   }
}

//-------------------------------------------------------------------------------------------------------------------------------------------//

void drawForStateRecuperarC() {
  fill(250, 250, 250);
  text("Recuperar Conta", (width - textWidth("Recuperar Conta")) / 2, 60);
  textSize(24);
  text("Email: ", 20, 230);
  textboxes.get(1).DRAW();
  caixas.get(9).DRAW();
}

//------------------------------------------------------------------------------------------------------------------------------------------------//

void drawForStatePlay() {
   // LABELS
   fill(250, 250, 250);
   textSize(32);
   text("NIVEL: "+ N, 50, 60);
   text("SCORE: " + Score, 50 , 100);
   
   
   caixas.get(5).DRAW();
   //caixas.get(4).DRAW();
   caixas.get(6).DRAW();
   caixas.get(7).DRAW();
   caixas.get(8).DRAW();
   
}

//----------------------------------------------------------------------------------------------------------------------------------------------//

void resizes(int x, int y){
  background.resize(x,y);
  surface.setSize(x,y);
}

void drawForStateJogar(){
  for(Obj o : objects){
    o.display();
  }
}

//--------------------------------------------------------------------------------------------------------------------------------------------------//

void drawForStateHelp() {
  text("Teclas:", 20, 100);
  text("Criaturas:",20,230);
  textSize(18);
  text("As setas esquerda e direita provocam aceleração angular, na direcção", 20,120);
  text("respectiva, a seta para a frente provoca aceleração linear na", 20,140);
  text("direcção para onde está voltado o jogador.", 20, 160);
  text("Cada propulsor gasta energia enquanto está a ser actuado;", 20, 180);
  text("As baterias são carregadas lentamente.", 20, 200);
  text("As criaturas verdes quando capturadas dão energia, até ao máximo da bateria.",20,250);
  text("As criaturas vermelhas, aparecem a cada 10 segundos numa posição aleatória.",20,270); 
  textSize(10);
  text("Clique x para voltar ao menu",20,300);
  textSize(24);
  caixas.get(9).DRAW();
}

//--------------------------------------------------------------------------------------------------------------------------------------------------//





void drawForStateGameOver(){
  fill(250, 250, 250);
  textSize(32);
  caixas.get(13).DRAW();
  caixas.get(14).DRAW();
  textSize(26);
  text("NIVEL: " + N, 20, 60);
  text("SCORE: " + Score, 20 , 100);
  text("Pos:    Nome:        Nivel:", 20, 140);
  text("Pos:    Nome:        Score:", 20, 140+160);
  int y=140;
  int x=20;
  text("1         " + nivel.get(0).nome + "               "+ nivel.get(0).n ,x, y+40);
  text("2         " + nivel.get(1).nome + "               "+ nivel.get(1).n ,x, y+80);
  text("3         " + nivel.get(2).nome + "               "+ nivel.get(2).n ,x, y+120);
   y+=160;
  text("1         " + score.get(0).nome + "               "+ score.get(0).n ,x, y+40);
  text("2         " + score.get(1).nome + "               "+ score.get(1).n ,x, y+80);
  text("3         " + score.get(2).nome + "               "+ score.get(2).n ,x, y+120);
 
}


//------------------------------------------------------------------------------------------------------------------------------------------------------//

void drawForStateRanking(){
  fill(250, 250, 250);
  textSize(32);
  text("RANKING:", width/2 -200 , 40);
  textSize(26);
  text("Pos:    Nome:        Nivel:", 20, 90);
  text("Pos:    Nome:        Score:", 750, 300);
  textSize(26);
  int y=90;
  text("1         " + nivel.get(0).nome + "               "+ nivel.get(0).n ,20, y+40);
  text("2         " + nivel.get(1).nome + "               "+ nivel.get(1).n ,20, y+80);
  text("3         " + nivel.get(2).nome + "               "+ nivel.get(2).n ,20, y+120);
  y=300;
  int x=750;
  text("1         " + score.get(0).nome + "               "+ score.get(0).n ,x, y+40);
  text("2         " + score.get(1).nome + "               "+ score.get(1).n ,x, y+80);
  text("3         " + score.get(2).nome + "               "+ score.get(2).n ,x, y+120);
  caixas.get(9).DRAW();
}

void drawForStateEspera(){
  fill(250, 250, 250);
  textSize(32);
  int segundos = ((millis())-start)/1000; //convert milliseconds to seconds, store values.
  int minutos = ((millis())-start) /1000 / 60;
  text(minutos+":"+segundos, width/2,height/2);
  caixas.get(9).DRAW();
}
