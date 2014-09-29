class Asteroid
{
  Shape shape;
int WIDTH=600;
int HEIGHT=600;


  
   




  Asteroid() {
    int rotation=4;
    float t=random(-1,1);
    if (t<0){
      rotation= -rotation;
    }
    
    float direction= int( random(0, 360  )  );

    boolean flip=false;
    float r=random(-1, 1);
    if (r<0) {
      flip=!flip;
    }
    int x=0;
    int y=0;
    
    if (direction<=90) {
      if (!flip) {
        x=0;
        y=int(random(HEIGHT/2, HEIGHT));
      }else{
        x=int(random(0, WIDTH/2));
        y=HEIGHT;
      }
    } else if (direction<=180) {
      if (!flip) {
        x=WIDTH;
        y=int(random(HEIGHT/2, HEIGHT));
      }else{
        x=int(random(WIDTH/2, WIDTH));
        y=HEIGHT;
      }
    } else if (direction<=270) {
      if (!flip) {
        x=WIDTH;
        y=int(random(0, HEIGHT/2));
      } else {
        x=int(random(WIDTH/2, WIDTH));
        y=0;
      }
    } else {
      if (!flip) {
        x=0;
        y=int(random(0, HEIGHT/2));
      } else {
        x=int(random(0, WIDTH/2));
        y=0;
      }
    }
    Loc center=new Loc(x, y);
    

    
   
    int numVertices = int( random( 5, 9 ));
    Loc[] points = new Loc[ numVertices ];
    float delta = (2 * PI) / numVertices; 
    float angle  =- ( delta/ 2 );
   
    for (int  i = 0; i < numVertices; i++ ){
      angle += delta;
      float extra = int( random( -(delta/4), (delta/4)));
      float range  =  random(10, 20 );
      points[i] = new Loc(int(center.x + range * cos(angle+extra)), int( center.y -range*sin(angle+extra)));
    }
    shape = new Shape(center, points, direction  );
    
    
 
  }

  void display() {
    shape.display();
  }

  void move( int num ) {  
    shape.move( num );
  
  }
  
    

  void spin(int delta) {
    shape.spin(delta);
  }
  
  
  boolean isInside(Shape s){
   return shape.isInside(s); 
  }
  
  void reset(){
    shape.reset();
  }
}




