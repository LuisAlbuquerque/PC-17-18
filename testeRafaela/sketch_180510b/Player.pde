import java.awt.event.KeyEvent;


class player extends Obj{
  
  public int number;
  public int ink;
  public float angle;
  public boolean switch1;
  public PVector aceleration;
  public PVector shield;
  public int start = 0;
  
  player(int x, int y, String s, int n){
    super(x,y,s,0.01);    
    aceleration= new PVector(0,0);
    shield= new PVector(0,0);
    angle = 0;
    ink = 300;
    number = n;
    switch1=false;
  }
  
  player(int number_, String x,String y,String velocity, String angle_, String switch1_, String acelerationx, String acelerationy, String ink_){
    super(int(x),int(y),"Canada.png",float(velocity));
    if(number_ == 1){
      change_image("portugal.png");
    }
    aceleration= new PVector(float(acelerationx),float(acelerationy));
    angle = float(angle_);
    ink = int(ink_);
    number = number_;
    switch1 = boolean(switch1_);
  }

  void update (){
    if(v.keyboard[0] == true && number == 0)
      aceleration = PVector.fromAngle(angle);
    aceleration.setMag(speed);    
    vector.add(aceleration);
    if(start==1){
      float a = atan2 (v.objects.get(1).coords. y - coords. y, v.objects.get(1).coords. x - coords. x) ;
      shield = PVector.fromAngle(a);
      shield.setMag((1/sq(PVector.dist(coords,v.objects.get(1).coords)))*1000);
      vector.sub(shield);
    }
    coords.add(vector);
 //<>// //<>// //<>//
 }
  
  void display(){
    if(v.keyboard[1] == true && number == 0){angle-=0.07;switch1=true;}
    if(v.keyboard[2] == true && number == 0){angle+=0.07;switch1=true;}
    if(v.keyboard[0] == true && number == 0){ink-=1;start=1;if(switch1){speed=0.05;switch1=false;}else{if(speed<0.08){speed+=0.01;}};}
    if(number == 1){if(speed<0.08){speed+=0.01;}}


    update();

    
    if(ink > 0 && 0<coords.x && coords.x<1300 && 0<coords.y && coords.y<700 && aux()){
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
    v.state=stateGmov;
    }
  }
  public Boolean aux(){
    Boolean b = true;
    for(int x = 4; x < v.objects.size(); x++){
      b = b && (PVector.dist(coords,v.objects.get(x).coords)>20);
    }
  return b;
  }
}
