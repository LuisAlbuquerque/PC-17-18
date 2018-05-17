class enemy extends Obj{
  
  //public float angle = 0;
  
  enemy(){
    super(int(random(0,displayWidth)),int(random(0,displayHeight)),"enemy2.png",4);
  }
  enemy(int x, int y){
        super(x,y,"enemy2.png",random(0,20));
  }
  
  
  void display(){
      if(PVector.dist(coords,objects[0].coords)>PVector.dist(coords,objects[1].coords)){
        //float angle = PVector.angleBetween(coords, objects[1].coords);
        //println(angle);
        //if (coords.y > objects[1].coords.y) { angle = angle + 2*(PI-angle); }
        //coords.add(((PVector.fromAngle(angle).setMag(speed))));
        vector= new PVector(objects[1].coords.x-coords.x,objects[1].coords.y-coords.y);
        vector.setMag(speed);
        coords.add(vector);
      }else{
        //float angle = PVector.angleBetween(coords, objects[0].coords);
        //if (coords.y > objects[0].coords.y) { angle = angle + 2*(PI-angle); }
        //coords.add(((PVector.fromAngle(angle).setMag(speed))));
        vector= new PVector(objects[0].coords.x-coords.x,objects[0].coords.y-coords.y);
        vector.setMag(speed);
        coords.add(vector);
      }
      pushMatrix();
      translate(coords.x,coords.y);
      image(image,0,0,40,40);
      popMatrix();
  }
}
