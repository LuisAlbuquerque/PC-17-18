class enemy extends Obj{
  
  //public float angle = 0;
  
  enemy(){
    super(int(random(0,800)),int(random(0,600)),"enemy2.png",random(0,20));
  }
  enemy(int x, int y){
        super(x,y,"enemy2.png",random(0,20));
  }
  
  
  void display(){
      if(coords.dist(objects[0].coords)>coords.dist(objects[1].coords)){
        float angle = PVector.angleBetween(coords, objects[1].coords);
        if (coords.y > objects[1].coords.y) { angle = angle + 2*(PI-angle); }
        coords.add(((PVector.fromAngle(angle).setMag(speed))));
      }else{
        float angle = PVector.angleBetween(coords, objects[0].coords);
        if (coords.y > objects[0].coords.y) { angle = angle + 2*(PI-angle); }
        coords.add(((PVector.fromAngle(angle).setMag(speed))));
      }
      pushMatrix();
      translate(coords.x,coords.y);
      image(image,0,0,40,40);
      popMatrix();
  }
}