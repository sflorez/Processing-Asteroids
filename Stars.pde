class Star {

  Shape shape;
  int x;
  int y;
  
Star (){
  
  int x= int(random(600));
  int y= int(random(600));
 
  Loc shotCenter = new Loc(x,y);
  float direction=(90);
  Loc[] points = new Loc[3];
  points[0] = new Loc( x, y-1);
  points[1] = new Loc( x+1, y+1);
  points[2] = new Loc( x-1, y+1);
  
  
  
  shape = new Shape( shotCenter, points, direction);
  
  
  
  
}
  
  void display(){
    shape.display();
  }
  
  void move(int num){
    shape.move(num);
  }
  
}


  
