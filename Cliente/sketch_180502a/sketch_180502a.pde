abstract class Obj {
  
  public PVector coords;
  public PImage image;
  
  Obj(int x, int y,String s){
    coords = new PVector(x, y);
    image = loadImage(s);

  }
  
  //abstract void move(int x);
  abstract void display();
}

class player extends Obj{
  
  public int number;
  public int ink;
  public int angle;
  
  player(int x, int y, String s, int n){
    super(x,y,s);
    angle = 0;
    ink = 200;
    number = n;
  }
  void setKeyboard(int x, boolean b){
    keyboard[x]=b;
  }
  
  void display(){
    if(ink > 0){
      if(keyboard[0] == true && number==0){coords.add((PVector.fromAngle(angle)).setMag(10)); ink -= 0.5;}
      if(keyboard[1] == true && number==0){angle-=0.05;}
      if(keyboard[2] == true && number==0){angle+=0.05;}
      //vida //<>//
      image(image,450*number,0,50,50);
      fill(200,0,0);
      rect(50+450*number,20,ink,20);
      //player
      pushMatrix();
      translate(coords.x,coords.y);
      rotate(angle);
      translate(-50,-50);
      tint(255, 255-(200-ink));
      image(image,0,0,100,100);
      tint(255, 255);
      popMatrix();
  }else{
    PFont font;
    font = createFont("Georgia Bold", 60);
    textFont(font);
    fill(255,215,0);
    text("Game Over", 10+360*number, 50);
    }
  }
}

class enemy extends Obj{
  
  enemy(){
    super(int(random(0,800)),int(random(0,600)),"enemy.png");
  }
  void display(){
      pushMatrix();
      translate(coords.x,coords.y);
      image(image,0,0,100,100);
      popMatrix();
  }
}

class inkOrb extends Obj{
  
  inkOrb(){
    super(int(random(0,800)),int(random(0,600)),"ink.png");
  }
  void display(){
      pushMatrix();
      translate(coords.x,coords.y);
      image(image,0,0,100,100);
      popMatrix();  
  }
}

class game {
  public Obj[] objects;
  public int maxObj;
  public int count;
  
  game(){
    maxObj = 6;
    objects = new Obj[maxObj];
    count=0;
  }
  void addObj(Obj o){
    if(count <= maxObj){
      objects[count] = o;
      count++;
    }
  }
  player getFirstObj(){
    return (player)objects[0];
  }
     
  void display(){
    for (int i = 0; i < objects.length; i++) {
      objects[i].display();
    }
  }
}

game g = new game();
PImage background;
boolean[] keyboard= {false,false,false};


void setup(){
  size(1920, 1080);
  background=loadImage("background4.jpg");
  g.addObj(new player(500,300,"Canada.png",0));
  g.addObj(new player(700,300,"portugal.png",1));
  g.addObj(new enemy());
  g.addObj(new enemy());
  g.addObj(new inkOrb());
  g.addObj(new inkOrb());
}
void draw(){
  background (background);
  g.display();
}

void keyPressed(){
  if(key == 'w'){keyboard[0]=true;}
  if(key == 'a'){keyboard[1]=true;}
  if(key == 'd'){keyboard[2]=true;}     
}


void keyReleased(){
    if(key == 'w'){keyboard[0]=false;}
    if(key == 'a'){keyboard[1]=false;}
    if(key == 'd'){keyboard[2]=false;}
}
