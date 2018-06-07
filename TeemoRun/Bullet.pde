public class Bullet extends Unit {
  
  protected float _dx, _dy;
  
  public Bullet( float tilt, float targetX, float targetY, float speed, float x, float y, color c ) {
    super(x, y, 5); // raduis 5
    _shape = createShape(ELLIPSE, 0, 0, 2*_r, 2*_r);
    _shape.setFill(c);
    float diffY = targetY - y, diffX = targetX - x, angle; // direction of bullet based on target
    if (diffX >= 0) // 1 tan value can have 2 different angles
      angle = atan( diffY / diffX );
    else
      angle = atan( diffY / diffX ) + PI;
    angle += tilt; // used for trident
    _dx = speed * cos(angle);
    _dy = speed * sin(angle);
  }
  
  public void move() {
    _x += _dx;
    _y += _dy;
  }
  
}
