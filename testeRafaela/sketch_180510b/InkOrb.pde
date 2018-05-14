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