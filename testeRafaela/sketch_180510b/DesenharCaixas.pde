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
   
   //Caixas de texto do menu
   Caixa caixaL = new Caixa("Login",(width-200) / 2, 100, 200, 50);
   Caixa caixaC = new Caixa("Criar Conta",(width-200) / 2, 200, 200, 50);
   Caixa caixaS = new Caixa("Sair",(width-200) / 2, 300, 200, 50);
   Caixa caixaR = new Caixa("Recuperar Conta",(width-250) / 2, 400, 250, 50);
   Caixa caixaP = new Caixa("Play",(width-200) / 2, 100, 200, 50);
   Caixa caixaRanking = new Caixa("Ranking",(width-200) / 2, 300,200, 50);
   Caixa caixaO = new Caixa("Opções",(width-200) / 2, 200,200, 50);
   Caixa caixaSair = new Caixa("Sair",(width-200) / 2, 500,200, 50);
   Caixa caixaHelp = new Caixa("Como Jogar",(width-200) / 2, 400,200, 50);
   Caixa caixaVoltar= new Caixa("Voltar",200, 400,200, 50);  
       
   textboxes.add(userTB); // 0
   textboxes.add(mailTB); // 1
   textboxesP.add(passTB); // 0
      
   caixas.add(caixaL); // 0
   caixas.add(caixaC); // 1
   caixas.add(caixaO); // 2
   caixas.add(caixaS); // 3
   caixas.add(caixaR); // 4
   caixas.add(caixaP); // 5
   caixas.add(caixaRanking); //6
   caixas.add(caixaHelp);//7
   caixas.add(caixaSair);//8
   caixas.add(caixaVoltar );//9
 }