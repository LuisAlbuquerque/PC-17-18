abstract class Obj {
  
  public int coordx;
  public int coordy;
  
  Obj(int x, int y){
    coordx = x;
    coordy = y;
  }
  
  abstract void move(int x);
  abstract void display();
}

class player extends Obj{
  
  public int gasoline;
  public int angle;
  
  player(int x, int y){
    super(x,y);
    angle = 0;
    gasoline = 100;
  }
  
  void rotatePlayer(int a){
    angle=360%(angle+a);
  }
  
  void move(int velocity){
    if(gasoline>0){
      coordx = int(coordx+cos(angle)*velocity);
      coordy = int(coordy+sin(angle)*velocity);
      gasoline-=2;
    }
  }
  void display(){
    fill(255,0,0);
    ellipse(100,70,60,60);
    fill(0,0,0);
    ellipse(81,70,16,32); 
    ellipse(119,70,16,32); 
  }  
}

class enemy extends Obj{
  
  enemy(){
    super(int(random(0,800)),int(random(0,600)));
  }
  void display(){
    fill(0,255,0);
    ellipse(100,70,60,60);
  }
}

class gasoline extends Obj{
  
  gasoline(){
    super(int(random(0,800)),int(random(0,600)));
  }
  void display(){
    fill(0,0,255);
    ellipse(100,70,60,60);  
  }
}

class game {
  public Obj[] objects;
  int maxObj;
  
  game(){
    maxObj = 6;
    objects = new Obj[maxObj];
  }
  void addObj(Obj o){
    int count = objects.length;
    if(count <= maxObj){
      objects[count] = o;
      maxObj++;
    }
  }
     
  void display(){
    background (75);
    rectMode(CENTER);
    rect(150,100,20,100);
    for (int i = 0; i < objects.length; i++) {
      objects[i].display();
    }
  }
}