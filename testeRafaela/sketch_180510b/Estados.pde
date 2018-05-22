void drawForStateMenu() {
  fill(250, 250, 250);
  text("MENU LOGIN", (width - textWidth("MENU LOGIN")) / 2, 60);
  textSize(24);
  caixas.get(0).DRAW();
  caixas.get(1).DRAW();
  caixas.get(2).DRAW();
}

//---------------------------------------------------------------------------------------------------------------------------------------//

void drawForStateLogin() {
   // LABELS
   fill(250, 250, 250);
   text("LOGIN", (width - textWidth("LOGIN")) / 2, 60);
   textSize(15);
   text("Clica ENTER para fazer o login", (width - textWidth("Clica ENTER para fazer o login")) / 2, 80);
   textSize(24);
   text("Utilizador: ", 20, 130);
   text("Password: ", 20, 180);
   
   // DRAW THE TEXTBOXES
   textboxes.get(0).DRAW();
   caixas.get(3).DRAW(); 
   caixas.get(9).DRAW();
   caixas.get(12).DRAW();
   textboxesP.get(0).DRAW();
   
   
   // JUST FOR DEMO (DO NOT EVER DO THAT!)
   if (logged==0) {
      fill(250, 250, 250);
      text("LOGIN FEITO COM SUCESSO!", (width - textWidth("LOGIN FEITO COM SUCESSO!")) / 2, 230);
      state=statePlay;
   }
   else if (logged==1){
     fill(250, 250, 250);
     text("LOGIN SEM SUCESSO!", (width - textWidth("LOGIN SEM SUCESSO!")) / 2, 230);
   }
}

//----------------------------------------------------------------------------------------------------------------------------------------------//

void drawForStateCreateC() {
   // LABELS
   fill(250, 250, 250);
   text("CRIAR UMA CONTA", (width - textWidth("CRIAR UMA CONTA")) / 2, 60);
   textSize(15);
   text("Clica ENTER para criar a conta", (width - textWidth("Clica ENTER para criar a conta")) / 2, 80);
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
      text("CONTA CRIADA COM SUCESSO !", (width - textWidth("YOU ARE LOGGED IN")) / 2, 230);
   }
   else if (create==1){
     fill(250, 250, 250);
     text("O UTILIZADOR JÁ EXISTE!", (width - textWidth("LOGIN FAILED!")) / 2, 230);
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
   text("MENU", (width - textWidth("MENU")) / 2, 60);
   textSize(24);
   caixas.get(5).DRAW();
   caixas.get(4).DRAW();
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
  textSize(24);
  caixas.get(9).DRAW();
}

//--------------------------------------------------------------------------------------------------------------------------------------------------//

void drawForStateOpcoes(){
  fill(250, 250, 250);
  text("Opções", (width - textWidth("Opçoes")) / 2, 60);
  caixas.get(10).DRAW();
  caixas.get(11).DRAW();
  caixas.get(9).DRAW();
}
