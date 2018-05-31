void drawForStateMenu() {
  fill(250, 250, 250);
  textSize(32);
  v.caixas.get(0).DRAW();
  v.caixas.get(1).DRAW();
  v.caixas.get(2).DRAW();
  v.caixas.get(15).DRAW();
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
   v.textboxes.get(0).DRAW();
   v.textboxesP.get(0).DRAW();
   textSize(18);
   v.caixas.get(3).DRAW(); 
   v.caixas.get(12).DRAW();
   textSize(32);
   v.caixas.get(9).DRAW();
   
   // JUST FOR DEMO (DO NOT EVER DO THAT!)
   if (v.logged==0) {
      v.state=statePlay;
   }
   else if (v.logged==1){
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
   
   
   // DRAW THE v.v.textboxES
   v.caixas.get(9).DRAW();
   v.caixas.get(16).DRAW();
   v.textboxes.get(2).DRAW();
   v.textboxesP.get(1).DRAW();
   v.textboxes.get(1).DRAW();
   
   // JUST FOR DEMO (DO NOT EVER DO THAT!)
   if (v.create==0) {
      v.state=statePlay;
   }
   else if (v.create==1){
     fill(250, 250, 250);
     text("O UTILIZADOR JÁ EXISTE!", 10, 350);
   }
}

//-------------------------------------------------------------------------------------------------------------------------------------------//

void drawForStateRecuperarC() {
  fill(250, 250, 250);
  text("Recuperar Conta", (width - textWidth("Recuperar Conta")) / 2, 60);
  textSize(24);
  text("Email: ", 20, 230);
  v.textboxes.get(1).DRAW();
  v.caixas.get(9).DRAW();
  
  if (v.recuperate==0) {
      v.state=stateLogin;
   }
   else if (v.recuperate==1){
     fill(250, 250, 250);
     text("Email invalido!", 10, 350);
   }
}

//------------------------------------------------------------------------------------------------------------------------------------------------//

void drawForStatePlay() {
   // LABELS
   fill(250, 250, 250);
   textSize(32);
   text("NIVEL: "+ v.N, 20, 60);
   text("VITORIAS: " + v.Vitorias, 20, 100);
   text("SCORE: " + v.Score, 20 , 140);

   
   
   v.caixas.get(5).DRAW();
   //v.caixas.get(4).DRAW();
   v.caixas.get(6).DRAW();
   v.caixas.get(7).DRAW();
   v.caixas.get(8).DRAW();
   
}

//----------------------------------------------------------------------------------------------------------------------------------------------//

void resizes(int x, int y){
  v.background.resize(x,y);
  surface.setSize(x,y);
}

void drawForStateJogar(){
  for(Obj o : v.objects){
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
  v.caixas.get(9).DRAW();
}

//--------------------------------------------------------------------------------------------------------------------------------------------------//





void drawForStateGameOver(){
  fill(250, 250, 250);
  textSize(32);
  v.caixas.get(13).DRAW();
  v.caixas.get(14).DRAW();
  textSize(26);
  text("NIVEL: " +  v.N, 20, 60);
  text("VITORIAS: " + v.Vitorias, 20, 100);
  text("SCORE: " + v.Score, 20 , 140);
  text("Pos:    Nome:        Nivel:", 20, 250);
  text("Pos:    Nome:        Score:", 20, 250+160);
  int y=250;
  int x=20;
  text("1         " + v.nivel.get(0).nome + "               "+ v.nivel.get(0).n ,x, y+40);
  text("2         " + v.nivel.get(1).nome + "               "+ v.nivel.get(1).n ,x, y+80);
  text("3         " + v.nivel.get(2).nome + "               "+ v.nivel.get(2).n ,x, y+120);
   y+=160;
  text("1         " + v.score.get(0).nome + "               "+ v.score.get(0).n ,x, y+40);
  text("2         " + v.score.get(1).nome + "               "+ v.score.get(1).n ,x, y+80);
  text("3         " + v.score.get(2).nome + "               "+ v.score.get(2).n ,x, y+120);
 
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
  text("1         " + v.nivel.get(0).nome + "               "+ v.nivel.get(0).n ,20, y+40);
  text("2         " + v.nivel.get(1).nome + "               "+ v.nivel.get(1).n ,20, y+80);
  text("3         " + v.nivel.get(2).nome + "               "+ v.nivel.get(2).n ,20, y+120);
  y=300;
  int x=750;
  text("1         " + v.score.get(0).nome + "               "+ v.score.get(0).n ,x, y+40);
  text("2         " + v.score.get(1).nome + "               "+ v.score.get(1).n ,x, y+80);
  text("3         " + v.score.get(2).nome + "               "+ v.score.get(2).n ,x, y+120);
  v.caixas.get(9).DRAW();
}

void drawForStateEspera(){
  fill(250, 250, 250);
  textSize(32);
  int segundos = ((millis())-v.start)/1000; //convert milliseconds to seconds, store values.
  int minutos = ((millis())-v.start) /1000 / 60;
  text(minutos+":"+segundos, width/2,height/2);
  v.caixas.get(9).DRAW();
}


void drawForStateRemC(){
  fill(250, 250, 250);
   text("REMOVER CONTA", (160 + textWidth("REMOVER CONTA")) / 2, 60);
   textSize(24);
   text("Email: ", 20, 230);
   text("Utilizador: ", 20, 130);
   text("Password: ", 20, 180);
   
   
   // DRAW THE TEXTBOXES
   v.caixas.get(9).DRAW();
   v.textboxes.get(3).DRAW();
   v.textboxesP.get(2).DRAW();
   v.textboxes.get(4).DRAW();
   v.caixas.get(17).DRAW();
   
   // JUST FOR DEMO (DO NOT EVER DO THAT!)
   if (v.remove==0) {
      fill(250, 250, 250);
      text("CONTA REMOVIDA COM SUCESSO !", 10, 350);
   }
   else if (v.remove==1){
     fill(250, 250, 250);
     text("TENTA DE NOVO!", 10, 350);
   }
   
}
