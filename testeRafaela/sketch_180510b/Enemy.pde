class enemy extends Obj{
  
  //public float angle = 0;
  
  enemy(){
    super(int(random(0,800)),int(random(0,600)),"enemy.png",1);
  }
  enemy(int x, int y){
        super(x,y,"enemy.png",1);
  }
  
  
  void display(){

      if(PVector.dist(coords,objects[0].coords)>PVector.dist(coords,objects[1].coords)){
        vector= new PVector(objects[1].coords.x-coords.x,objects[1].coords.y-coords.y); //<>//
        vector.setMag(speed); //<>//
        coords.add(vector); //<>//
      }else{
        vector= new PVector(objects[0].coords.x-coords.x,objects[0].coords.y-coords.y); //<>//
        vector.setMag(speed); //<>//
        coords.add(vector); //<>//
      }

      pushMatrix();
      translate(coords.x,coords.y);
      image(image,0,0,60,50);
      popMatrix();
  }
}
