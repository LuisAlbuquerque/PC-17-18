public class Variaveis{

  ArrayList<String> rec = new ArrayList<String>();
  String send = "";
  String username;
  String password;
  String mail;
  ArrayList<Obj> objects = new ArrayList<Obj>();
  
  
  
  //Obj[] objects= new Obj[6];
  PImage background;
  PImage backgroundJogo;
  boolean[] keyboard= {false,false,false};
  public int N = 1;
  public int Score = 50;
  public int Vitorias = 0;
  public int gameover= 1;
  ArrayList<Top3> nivel= new ArrayList<Top3>();
  ArrayList<Top3> score= new ArrayList<Top3>();
  ArrayList<TEXTBOX> textboxes = new ArrayList<TEXTBOX>();
  ArrayList<TEXTBOXP> textboxesP = new ArrayList<TEXTBOXP>();
  ArrayList<Caixa> caixas = new ArrayList<Caixa>();
  
  
  int logged = 2; // 0 para login, 1 para failed, e 2 para enquanto nao clica enter
  int create = 2; // 0 criado para sucesso, 1 para já existe o username, e 2 para enquanto nao clica enter
  int remove = 2;
  int recuperate = 2;
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
  Top3 um = new Top3("None",0);
  Top3 dois = new Top3("None",0);
  Top3 tres = new Top3("None",0);
  Top3 ums = new Top3("None",0);
  Top3 doiss = new Top3("None",0);
  Top3 tress = new Top3("None",0);
  
  //Cliente c = new Cliente("localhost","1234");
  public Socket s;
  public Receiver receiver;
  public Sender senderC;
  String port1 = "localhost";
  String port2;
  
  Variaveis(){
    port2 = "1234";
  }
  
  public void altera(){
    if(rec.get(0).equals("lose") || rec.get(0).equals("win")){
      state=stateGmov;
    }
    if(rec.get(0).equals("top3")){
       nivel.set(0, new Top3(rec.get(0),int(rec.get(1))));
       nivel.set(1, new Top3(rec.get(2),int(rec.get(3))));
       nivel.set(2, new Top3(rec.get(4),int(rec.get(5))));
       score.set(0, new Top3(rec.get(6),int(rec.get(7))));
       score.set(1, new Top3(rec.get(8),int(rec.get(9))));
       score.set(2, new Top3(rec.get(10),int(rec.get(11))));
    }
    if(rec.get(0).equals("play")){
       state=stateJogar;
    }
    if(rec.get(0).equals("jogar")){
        //objects.clear();
        objects.set(0,new player(0,rec.get(1),rec.get(2),rec.get(9),rec.get(7),rec.get(15),rec.get(11),rec.get(12),rec.get(5)));
        objects.set(1,new player(1,rec.get(3),rec.get(4),rec.get(10),rec.get(8),rec.get(16),rec.get(13),rec.get(14),rec.get(6)));
        if(rec.size() > 20){
          objects.set(2,new Energy(rec.get(17),rec.get(18)));
          objects.set(3,new Energy(rec.get(19),rec.get(20)));
        }
        if(rec.size() > 24){ 
          int x,y,z;
          for(x = 21, y = 22, z=4; y < objects.size()-4; x+=2, y+=2,z++){
            objects.set(z,new enemy(rec.get(x),rec.get(y)));
          }
          objects.add(new enemy(rec.get(x+2),rec.get(y+2)));
          objects.add(new enemy(rec.get(x+4),rec.get(y+4)));
        }
        println(objects);
        state=stateJogar;
    }
    if(rec.get(0).equals("ok")){
        if(state==stateLogin)
          logged = 0;
        if(state==stateCreateC)
          create = 0;
        if(state==statePlay){
           start = millis();
           state=stateEspera;
        }
        if(state==stateGmov){
           start = millis();
           state=stateEspera;
           gameover=1;
        }
        if(state==stateRemC)
          remove = 0;
        if(state==stateRecuperarC)
          recuperate = 0;
    }
    if(rec.get(0).equals("invalid")){
        if(state==stateLogin)
          logged = 1;
        if(state==stateCreateC)
          create = 1;
        if(state==stateRemC)
          remove = 1;
        if(state==stateRecuperarC)
          recuperate = 1;
    }
    if(rec.get(0).equals("approved")){
      if(state==statePlay){
          state=stateMenu;
          textboxes.get(0).nome = "";
          textboxes.get(0).Text = "";
          textboxesP.get(0).pass= "";
          textboxesP.get(0).esconde= "";
          textboxesP.get(0).Text= "";
          logged=2;
      }
      if(state==stateRecuperarC){
           state=stateMenu;
           v.textboxes.get(0).nome = "";
           v.textboxes.get(0).Text = "";
           v.textboxesP.get(0).pass= "";
           v.textboxesP.get(0).esconde= "";
           v.textboxesP.get(0).Text= "";
           v.logged=2;
      }
      if(state==stateRemC){
           state=stateMenu;
           v.textboxes.get(0).nome = "";
           v.textboxes.get(0).Text = "";
           v.textboxesP.get(0).pass= "";
           v.textboxesP.get(0).esconde= "";
           v.textboxesP.get(0).Text= "";
           v.logged=2;
      }
    }   
  }
}
