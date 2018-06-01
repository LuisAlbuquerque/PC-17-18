class Energy extends Obj{
  
  Energy(){
    super(int(random(0,800)),int(random(0,600)),"ink.png",0);
  }
  Energy(int x, int y){
    super(x,y,"ink.png",0);
  }
  Energy(String x, String y){
    super(int(x.trim()),int(y.trim()),"ink.png",0);
  }
  void display(){     
    pushMatrix();
    translate(coords.x,coords.y);
    image(image,0,0,50,50);
    popMatrix();  
  }
}
