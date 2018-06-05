public class Minion extends Unit {

  private int _health, _attackSpeed, _speed;
  private float dx, dy, _angle;

  public Minion( int health, float x, float y ) {
    super( x, y, 15 );
    _shape = createShape(ELLIPSE, 0, 0, 2*_r, 2*_r);
    _shape.setFill( color( 110, 0, 0 ) );
    _health = health;
    _attackSpeed = 360;
    _speed = 1;
    super.setTime( _attackSpeed / 2 );
    _angle = (float)Math.random() * PI * 2;
    dx = cos( _angle ) * _speed;
    dy = sin( _angle ) * _speed;
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
    if (_x < _r || _x > 1400 - _r || _y < _r || _y > 800 - _r) {
      _x -= dx;
      _y -= dy;
      _angle += PI / 2;
      dx = cos( _angle ) * _speed;
      dy = sin( _angle ) * _speed;
      _x += dx;
      _y += dy;    
      if (_x < _r || _x > 1400 - _r || _y < _r || _y > 800 - _r) {
        _x -= dx;
        _y -= dy;
        _angle -= PI;
        dx = cos( _angle ) * _speed;
        dy = sin( _angle ) * _speed;
        _x += dx;
        _y += dy;
      }
    }
  }

  public MBullet shoot( float x, float y ) {
    x += 1800 * (x - getX());
    y += 1800 * (y - getY());
    attackReset();
    return new MBullet( x, y, getX(), getY() );
  }
}
