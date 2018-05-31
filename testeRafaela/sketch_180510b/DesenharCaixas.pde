void caixas(){
  TEXTBOX userTB = new TEXTBOX();
   userTB.X = 160;
   userTB.Y = 103;
   userTB.W = 200;
   userTB.H = 35;
   userTB.BorderEnable = false;
   
   TEXTBOX mailTB = new TEXTBOX();
   mailTB.X = 160;
   mailTB.Y = 203;
   mailTB.W = 500;
   mailTB.H = 35;
   mailTB.BorderEnable = false;
   
   // PASSWORD TEXTBOX
   // CONFIGURED USING THE CLASS CONSTRACTOR
   TEXTBOXP passTB = new TEXTBOXP(160, 153, 200, 35);
   passTB.BorderWeight = 3;
   passTB.BorderEnable = false;
   
  TEXTBOX userC = new TEXTBOX();
   userC.X = 160;
   userC.Y = 103;
   userC.W = 200;
   userC.H = 35;
   userC.BorderEnable = false;
   
   TEXTBOXP passC = new TEXTBOXP(160, 153, 200, 35);
   passC.BorderWeight = 3;
   passC.BorderEnable = false;

//____________________REMOVE CONTA________________________________//
  TEXTBOX userR = new TEXTBOX();
     userTB.X = 160;
     userTB.Y = 103;
     userTB.W = 200;
     userTB.H = 35;
     userTB.BorderEnable = false;
   
   TEXTBOX mailR = new TEXTBOX();
     mailTB.X = 160;
     mailTB.Y = 203;
     mailTB.W = 500;
     mailTB.H = 35;
     mailTB.BorderEnable = false;
  
  TEXTBOXP passR = new TEXTBOXP(160, 153, 200, 35);
   passC.BorderWeight = 3;
   passC.BorderEnable = false;
     
   
   //Caixas de texto do menu
   
   Caixa caixaL = new Caixa("Login",(width+500) / 2, 250, 200, 50);
   Caixa caixaC = new Caixa("Criar Conta",(width+500) / 2, 350, 200, 50);
   Caixa caixaRem = new Caixa("Remover Conta",(width+500) / 2, 450, 200, 50);
   Caixa caixaS = new Caixa("Sair",(width+500) / 2, 550, 200, 50);
   
   //caixa de texto recuperar conta
   
   Caixa caixaR = new Caixa("Recuperar Conta",(50) / 2, 200, 180, 50);
   Caixa caixalogin = new Caixa("Login",(400) / 2, 200, 150, 50);
   
   // caixas de texto menu jogar
   
   Caixa caixaP = new Caixa("Play",(width+500) / 2, 250, 200, 50);
   Caixa caixaRanking = new Caixa("Ranking",(width+500) / 2, 350,200, 50);
   Caixa caixaO = new Caixa("Opções",(width+500) / 2, 30050,200, 50);
   Caixa caixaSair = new Caixa("Sair",(width+500) / 2, 550,200, 50);
   Caixa caixaHelp = new Caixa("Como Jogar",(width+500) / 2, 450,200, 50);
   
   //caixa de texto voltar, dá para vários menus
   Caixa caixaVoltar= new Caixa("Voltar",0, 600,200, 50);
   
   //caixas para o menu de opcoes
   Caixa caixa800x600 = new Caixa("800x600",(width-200) / 2, 100,200, 50);
   Caixa caixa1200x800 = new Caixa("1200x800",(width-200) / 2, 200,200, 50);
   
   
   // caixas para novo jogo
   Caixa caixaNovo = new Caixa("Novo Jogo",(width+500) / 2, 250, 200, 50);
   Caixa caixaSairN = new Caixa("Sair",(width+500) / 2, 350,200, 50);
   
   //
   v.textboxes.add(userTB); // 0
   v.textboxes.add(mailTB); // 1
   v.textboxes.add(userC);//2
   v.textboxes.add(userR); // 3
   v.textboxes.add(mailR);//4
   //
   v.textboxesP.add(passTB); // 0
   v.textboxesP.add(passC); //1
   v.textboxesP.add(passR); //2
   
   //   
   v.caixas.add(caixaL); // 0
   v.caixas.add(caixaC); // 1
   v.caixas.add(caixaS); // 2
   
   //
   v.caixas.add(caixaR); // 3
   //
   v.caixas.add(caixaO); // 4
   v.caixas.add(caixaP); // 5
   v.caixas.add(caixaRanking); //6
   v.caixas.add(caixaHelp);//7
   v.caixas.add(caixaSair);//8
   //
   v.caixas.add(caixaVoltar );//9
   //
   v.caixas.add(caixa800x600);//10
   v.caixas.add(caixa1200x800);//11
   
   v.caixas.add(caixalogin);//12
   
   //
   v.caixas.add(caixaNovo);//13
   v.caixas.add(caixaSairN);//14
   //
   v.caixas.add(caixaRem);//15
   
   
 }
