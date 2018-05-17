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
  
  void remove(){
    coords.x = -300;
    coords.y = -300;
    speed=0;
  }
  
  //abstract void move(int x);
  abstract void display();
}
