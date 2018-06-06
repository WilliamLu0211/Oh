public class Item extends Unit {
  
  private int _despawnTime;
 
  public Item( float x, float y, PShape s, color c ) {
    super( x, y, 20 );
    _shape = s;
    _shape.setFill(c);
    _despawnTime = 10 * (int)frameRate;
    super.setTime( _despawnTime );
  }
  
  public boolean despawnReady() {
    return super.getTime() == 0;
  }
  
  private float normalizeX( float x, float sqNorm ){
    return x / sqrt(sqNorm);
  }
  
  private float normalizeY( float y, float sqNorm ){
    return y / sqrt(sqNorm);
  }
  
  public void move( Teemo t ) {
    float sqDistance = sq(_x - t._x) + sq(_y - t._y);
    float speed = 50 / sqDistance;
    float dx = speed * normalizeX( t._x - _x, sqDistance);
    float dy = speed * normalizeY( t._y - _y, sqDistance);
    _x += dx;
    _y += dy;
  }
  
}
