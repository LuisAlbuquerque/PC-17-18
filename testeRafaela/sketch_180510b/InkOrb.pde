class inkOrb extends Obj{
  
  inkOrb(){
    super(int(random(0,displayWidth)),int(random(0,displayHeight)),"ink.png",0);
  }
  inkOrb(int x, int y){
    super(x,y,"ink.png",0);
  }
  void display(){     
    pushMatrix();
    translate(coords.x,coords.y);
    image(image,0,0,50,50);
    popMatrix();  
  }
}
