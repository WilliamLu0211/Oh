public class Minion extends Unit {

  private int _health, _attackSpeed;
  private float dx, dy;

  public Minion( int health, float x, float y ) {
    super( x, y, 15 );
    _shape = createShape(ELLIPSE, 0, 0, 2*_r, 2*_r);
    _shape.setFill( color( 110, 0, 0 ) );
    _health = health;
    _attackSpeed = 360;
    super.setTime( _attackSpeed / 2 );
    dx = (float)Math.random();
    dy = sqrt( 1 - sq(dx) );
  }
  
  public boolean attackReady() {
    return super.getTime() == 0;
  }
  
  public void attackReset() {
    super.setTime( _attackSpeed );
  }

  public void hit( TBullet b ) {
    _health -= b.getDamage();
  }

  public boolean isAlive() {
    return _health > 0;
  }

  public void move() {
    _x += dx;
    _y += dy;
    if (_x < _r || _x > 1400 - _r)
      dx = -dx;
    if (_y < _r || _y > 800 - _r)
      dy = -dy;
  }

  public MBullet shoot( float x, float y ) {
    x += 1800 * (x - getX());
    y += 1800 * (y - getY());
    attackReset();
    return new MBullet( x, y, getX(), getY() );
  }
  
}
