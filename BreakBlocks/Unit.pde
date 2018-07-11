public abstract class Unit {
  
  protected float _x, _y;//position, radius
  
  public Unit( float x, float y) {
    _x = x;
    _y = y;
  }
  
  public float getX() {
    return _x;
  }
  
  public float getY() {
    return _y;
  }
  
  public abstract void spawn();
  
}
