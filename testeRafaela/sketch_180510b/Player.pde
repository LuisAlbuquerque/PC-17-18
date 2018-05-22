import java.awt.event.KeyEvent;


class player extends Obj{
  
  public int number;
  public int ink;
  public float angle;
  public boolean switch1;
  public PVector aceleration;
  
  player(int x, int y, String s, int n){
    super(x,y,s,0.1);    
    aceleration= new PVector(0,0);
    angle = 0;
    ink = 300;
    number = n;
    switch1=false;
  }
  void update (){
    if(keyboard[0] == true && number == 0)
      aceleration = PVector.fromAngle(angle);
    aceleration.setMag(speed);
    vector.add(aceleration);
    coords.add(vector);
  }
  
  void display(){
    if(keyboard[1] == true && number == 0){angle-=0.07;switch1=true;}
    if(keyboard[2] == true && number == 0){angle+=0.07;switch1=true;}
    if(keyboard[0] == true && number == 0){ink-=1;if(switch1){speed=0.05;switch1=false;}else{if(speed<0.1){speed+=0.001;}};}

    update();
    
    if(PVector.dist(coords,objects[4].coords)<30){
      ink = 300;
      objects[4].remove();
    }
    if(PVector.dist(coords,objects[5].coords)<30){
      ink = 300;
      objects[5].remove();
    }
    
    if(ink > 0 && 0<coords.x && coords.x<displayWidth && 0<coords.y && coords.y<displayHeight && PVector.dist(coords,objects[2].coords)>20 && PVector.dist(coords,objects[3].coords)>20){
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
    remove();
    PFont font;
    font = createFont("Georgia Bold", 60);
    textFont(font);
    fill(255,215,0);
    text("Game Over", 10+360*number, 50);
    }
  }
}
