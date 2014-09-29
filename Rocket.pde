class Rocket
{
   Shape shape;
   PImage img;
   
  // ------------------------------------------------------------------------------
  // instantiate a rocket at a given location, oriented upwards
  // ------------------------------------------------------------------------------
   Rocket( int x, int y ) {
     
      Loc center = new Loc( x, y );
      float direction = ( 90 );   
      Loc[] points = new Loc[4];
      points[0] = new Loc( center.x, center.y - 15);  
      points[1] = new Loc( center.x + 10, center.y + 20 ); 
      points[2] = new Loc( center.x, center.y +15 );
      points[3] = new Loc( center.x - 10 , center.y + 20);


      shape = new Shape ( center, points, direction ); 
      img = loadImage("rocket.png");
   } 
  
  // ------------------------------------------------------------------------------
  // instantiate a rocket at a given location, oriented upwards
  // ------------------------------------------------------------------------------
   void display() {
      shape.display();
      pushMatrix();
      translate(shape.center.x,shape.center.y);
      rotate(-shape.direction+(PI/2));
      
      image(img,0,0,40,55);
      popMatrix();
      
     
   }
   
  // ------------------------------------------------------------------------------
  // move the rocket a given distance
  // ------------------------------------------------------------------------------
   void move( int num ) {  
     
      shape.move( num );
   }
   
  // ------------------------------------------------------------------------------
  // turn either clockwise or counterclockwise
  // ------------------------------------------------------------------------------
   void turn( int num ) {
      shape.turn( num );
      }
      
      
      Shot shoot(){
        return (new Shot(shape.vertices[0], shape.getDirection()));
      }
      

}

