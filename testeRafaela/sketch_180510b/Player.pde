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
    if(keyboard[0] == true && number == 0){ink-=1;if(switch1){speed=0.05;switch1=false;}else{speed=0.08;};}

    update();
    
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