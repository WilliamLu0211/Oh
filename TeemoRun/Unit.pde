public class Unit {
  
  protected float _x, _y, _r;//position, radius
  protected PShape _shape;
  private int _time;
  
  public Unit( float x, float y, float r) {
    _x = x;
    _y = y;
    _r = r;
  }
  
  public float getX() {
    return _x;
  }
  
  public float getY() {
    return _y;
  }
  
  public int getTime() {
    return _time;
  }
  
  public float getR() {
    return _r;
  }
  
  public boolean outOfBounds() {//out of play area?
    return _x < _r || _x > width - _r || _y < _r  || _y > height - _r;
  }
  
  public void setTime( int t ) {
    _time = t;
  }
  
  public void tick() {
    if ( _time > 0 ) {
      _time--;
    }
  }
  
  public boolean touches( Unit u ){
    return sq( _x - u._x ) + sq( _y - u._y ) <= sq( _r + u._r );
  }
  
  public void spawn() {
    rectMode( CENTER );    
    shape( _shape, _x, _y );
  }
  
}
