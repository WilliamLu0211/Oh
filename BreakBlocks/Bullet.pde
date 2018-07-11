public class Bullet extends Unit {
  
  private float _dx, _dy, _r;
  
  public Bullet(float targetX, float targetY, float x, float y) {
    super(x, y);
    _r = 8;
    float diffY = targetY - y, diffX = targetX - x;
    float hyp = sqrt( sq(diffY) + sq(diffX) );
    _dy = diffY * 10 / hyp;
    _dx = diffX * 10 / hyp;
  }
  
  public void move(ArrayList<Block> blocks) {
    _x += _dx;
    _y += _dy;
    if (_x < _r || _x > width - _r)
      _dx = -_dx;
    if (_y < _r)
      _dy = -_dy;
    for (Block b : blocks){
      if (touchesS(b)){
        _dx = -_dx;
        b.decrementHealth();
      }
      if (touchesTB(b)){
        _dy = -_dy;
        b.decrementHealth();
      }
    }
  }
  
  private boolean touchesS(Block b){
    float bot = b.getY() + b.getHalfW();
    float top = b.getY() - b.getHalfW();
    float left = b.getX() - b.getHalfL() - _r;
    float right = b.getX() + b.getHalfL() + _r;
    return _x >= left && _x <= right && _y >= top && _y <= bot;
  }
  
  private boolean touchesTB(Block b){
    float bot = b.getY() + b.getHalfW() + _r;
    float top = b.getY() - b.getHalfW() - _r;
    float left = b.getX() - b.getHalfL();
    float right = b.getX() + b.getHalfL();
    return _x >= left && _x <= right && _y >= top && _y <= bot;
  }
  
  public void spawn(){
    fill(255);
    ellipse(_x, _y, _r*2, _r*2);
  }
  
  public boolean fallen(){
    return _y > height;
  }
  
}
