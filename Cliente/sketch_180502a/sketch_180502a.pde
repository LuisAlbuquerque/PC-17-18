import java.awt.event.KeyEvent;

abstract class Obj {
  
  public PVector coords;
  public PVector vector;
  public PImage image;
  public float speed;
  
  Obj(int x, int y,String s,float sp){
    coords = new PVector(x, y);
    image = loadImage(s);
    vector= new PVector(0,0);
    speed = sp;
  }
  
  //abstract void move(int x);
  abstract void display();
}

class player extends Obj{
  
  public int number;
  public int ink;
  public float angle;
  public boolean switch1;
  
  player(int x, int y, String s, int n){
    super(x,y,s,1);
    angle = 0;
    ink = 300;
    number = n;
    switch1=false;
  }
  void display(){ //<>//
    if(keyboard[1] == true && number == 0){angle-=0.07;switch1=true;}
    if(keyboard[2] == true && number == 0){angle+=0.07;switch1=true;}
    if(keyboard[0] == true && number == 0){vector=(vector.add((PVector.fromAngle(angle))).setMag(speed));ink -= 1;if(switch1){speed=2;switch1=false;}else{speed+=0.3;};}

    
    coords.add(vector);
    
    if(ink > 0){
      //vida
      image(image,450*number,0,50,50);
      fill(200,0,0);
      rect(50+450*number,20,ink,20);
      //player
      pushMatrix();
      translate(coords.x,coords.y);
      rotate(angle);
      translate(-30,-30);
      tint(255, 255-(200-ink));
      image(image,0,0,60,60);
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
  
  //public float angle = 0;
  
  enemy(){
    super(int(random(0,800)),int(random(0,600)),"enemy2.png",random(0,20));
  }
  enemy(int x, int y){
        super(x,y,"enemy2.png",random(0,20));
  }
  
  
  void display(){
      if(coords.dist(objects[0].coords)>coords.dist(objects[1].coords)){ //<>//
        float angle = PVector.angleBetween(coords, objects[1].coords); //<>//
        if (coords.y > objects[1].coords.y) { angle = angle + 2*(PI-angle); } //<>//
        coords.add(((PVector.fromAngle(angle).setMag(speed)))); //<>//
      }else{
        float angle = PVector.angleBetween(coords, objects[0].coords);
        if (coords.y > objects[0].coords.y) { angle = angle + 2*(PI-angle); }
        coords.add(((PVector.fromAngle(angle).setMag(speed))));
      }
      pushMatrix(); //<>//
      translate(coords.x,coords.y);
      image(image,0,0,40,40);
      popMatrix();
  }
}

class inkOrb extends Obj{
  
  inkOrb(){
    super(int(random(0,800)),int(random(0,600)),"ink2.png",0);
  }
  inkOrb(int x, int y){
    super(x,y,"ink2.png",0);
  }
  void display(){
      pushMatrix();
      translate(coords.x,coords.y);
      image(image,0,0,40,40);
      popMatrix();  
  }
}

Obj[] objects= new Obj[6];
PImage background;
boolean[] keyboard= {false,false,false};


void setup(){
  size(1280, 720);
  background=loadImage("background.jpg");
  objects[0]=new player(500,300,"Canada.png",0);
  objects[1]=new player(700,300,"portugal.png",1);
  objects[2]=new enemy();
  objects[3]=new enemy();
  objects[4]=new inkOrb();
  objects[5]=new inkOrb();
}
void draw(){
  background (background);
  for(Obj o : objects){
    o.display();
  }
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
