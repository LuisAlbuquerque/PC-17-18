class inkOrb extends Obj{
  
  inkOrb(){
    super(int(random(0,800)),int(random(0,600)),"ink.png",0);
  }
  inkOrb(int x, int y){
    super(x,y,"ink.png",0);
  }
  inkOrb(String x, String y){
    super(int(x),int(y),"ink.png",0);
  }
  void display(){     
    pushMatrix();
    translate(coords.x,coords.y);
    image(image,0,0,50,50);
    popMatrix();  
  }
}
