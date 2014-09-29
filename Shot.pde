class Shot {

  Shape shape;

  Shot (Loc center, float direction) {

    Loc shotCenter = new Loc(center.x, center.y);
    Loc[] points = new Loc[4];
    points[0] = new Loc( center.x+1, center.y-1);
    points[1] = new Loc( center.x+1, center.y+1);
    points[2] = new Loc( center.x-1, center.y+1);
    points[3] = new Loc( center.x-1, center.y-1);



    shape = new Shape( shotCenter, points, direction);

    shape.restart = false;
  }

  void display() {
    shape.display();
  }

  void move(int num) {
    shape.move(num);
  }

  boolean isInside(Shape s) {
    return shape.isInside(s);
  }
}

