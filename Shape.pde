class Shape {
  
  Loc center;           // current x, y coordinates for center of shape
  Loc orig;             // start/restart location for center of shape
  float radius;         // average distance of all the vertices
  float direction;      // the direction (in radians) in which this shape will move
  float rotation;       // base angle for spin
  Loc[] vertices;       // the vertices of this shape
  float[] ranges;       // distance from center to each vertex
  float[] offsets;      // offset to direction angle for each vertex
  boolean restart;      // toggle to allow restarting automatically (default: true)
  
  // ------------------------------------------------------------------------------
  // instantiate a shape with a given center, vertices, and starting direction
  // ------------------------------------------------------------------------------
  Shape( Loc ctr, Loc[] locs, float angle ) {
    
    center = ctr;
    orig = new Loc(center.x,center.y);
    restart = true;
    direction = ( angle * PI ) / 180;  // base angle in radians
    rotation = direction;

    vertices = locs;
    ranges = new float[ vertices.length ];
    offsets = new float[ vertices.length ];
    radius = 0;
    for ( int i = 0; i < vertices.length; i++ ) {
      ranges[ i ] = dist( center.x, center.y, vertices[i].x, vertices[i].y); 
      radius += ranges[ i ];
      float totalAngle = currentAngle( ranges[ i ], center, vertices[ i ] );
      float offsetAngle = totalAngle - direction;
      offsetAngle = adjustAngle( offsetAngle);
      offsets[ i ] = offsetAngle;
    }
    radius = radius / vertices.length;
    if ( radius < 1 ) {
      radius = 1;
    }
  } 
  
  // ------------------------------------------------------------------------------
  // display the shape
  // ------------------------------------------------------------------------------
  void display() {
    
    // first, show lines between consecutive vertices
    for ( int i = 0; i < vertices.length-1; i++ ) {
      line(vertices[i].x,vertices[i].y,vertices[i+1].x,vertices[i+1].y);
    }
    // including from the last vertex back to the first
    line(vertices[vertices.length-1].x,vertices[vertices.length-1].y,vertices[0].x,vertices[0].y);
  }
  
  // ------------------------------------------------------------------------------
  // determine whether two shapes collide
  // ------------------------------------------------------------------------------
  boolean isInside( Shape s ) {
    
    if ( dist(center.x, center.y, s.center.x, s.center.y) <= (radius + s.radius) ) {
      return true;
     
    } else {
      return false;
      }
  }
  
  // ------------------------------------------------------------------------------
  // restart shape motion from its original settings
  // ------------------------------------------------------------------------------
  void reset() {
    
    center.x = orig.x;
    center.y = orig.y;
    updatePositions();
  }
  
  // ------------------------------------------------------------------------------
  // move a shape in the direction of motion the distance given by the input
  //
  // NOTE: if 'units' is small, pixel location round off errors will be prominent
  // ------------------------------------------------------------------------------
  void move( float units ) {
    
    // update position of center
    center.x = int( center.x + units * cos( direction ) );
    center.y = int( center.y - units * sin( direction ) );
    
    // wrap around game board if reach boundary and shape is restartable
    if ( restart && ( center.x < 0 || center.x > width 
                      || center.y < 0 || center.y > height ) ) 
    {
        center.x = orig.x;
        center.y = orig.y;
    }
   
    // then, update the positions of all vertices
    updatePositions();
  }

  // ------------------------------------------------------------------------------
  // change the direction of motion by 'delta' degrees
  // ------------------------------------------------------------------------------
  void turn( int delta ) {
    
    // update direction  in radians
    direction += ( delta * PI ) / 180;
    direction = adjustAngle( direction );
    
    // also update rotation in radians
    rotation += ( delta * PI ) / 180;
    rotation = adjustAngle( rotation );
    
    // then, update the positions of all vertices
    updatePositions();
  }
  
  // ------------------------------------------------------------------------------
  // spin in place without changing the direction of motion
  // ------------------------------------------------------------------------------
  void spin( int delta ) {
    
    // update rotation in radians
    rotation += ( delta * PI ) / 180;
    rotation = adjustAngle( rotation );
    
    // then, update the positions of all vertices
    updatePositions();
  }
  
  // ------------------------------------------------------------------------------
  // update current position of all vertices using center, direction and offsets;
  // ------------------------------------------------------------------------------
  void updatePositions() {
    
    for ( int i = 0; i < vertices.length; i++ ) {      
      float theta = rotation + offsets[ i ];
      theta = adjustAngle( theta );
      
      vertices[i].x = int( center.x + ranges[i] * cos( theta ) );
      vertices[i].y = int( center.y - ranges[i] * sin( theta ) );
    }
  } 

  // ------------------------------------------------------------------------------
  // compute the angle between the x-axis and the line between 2 points, in radians
  // ------------------------------------------------------------------------------
  float currentAngle( float d, Loc c, Loc p ) {
    
    float val = float( p.x - c.x ) / d; 
    val = constrain(val,-1,1);   
    float phi = acos(val);
    if ( p.y > c.y ) {
      phi = (2 * PI) - phi;
    }
    return phi;
  }
  
  // ------------------------------------------------------------------------------
  // adjust an angle to be in the range from 0 to 2*PI
  // ------------------------------------------------------------------------------
  float adjustAngle( float thisAngle ) {
    
    while ( thisAngle > (2 * PI) ) {
      thisAngle -= 2 * PI;
    }
    while ( thisAngle < 0 ) {
      thisAngle += 2*PI;
    }
    return thisAngle;
  }
  
  // ------------------------------------------------------------------------------
  // return the current direction of motion (in degrees)
  // ------------------------------------------------------------------------------
  float getDirection() {
    
    float angle = ( direction * 180 ) / PI;
    constrain( angle, 0, 360);
    return angle;
  }


}



