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
      } else if (touchesTB(b)){
        _dy = -_dy;
        b.decrementHealth();
      } else if (touchesV1(b)){
        float temp = _dx;
        _dx = -_dy;
        _dy = -temp;
        b.decrementHealth();
      } else if (touchesV2(b)){
        float temp = _dx;
        _dx = _dy;
        _dy = temp;
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
  
  private boolean touchesV1(Block b){
    float brX = b.getX() + b.getHalfL();
    float brY = b.getY() + b.getHalfW();
    float tlX = b.getX() - b.getHalfL();
    float tlY = b.getY() - b.getHalfW();
    return sq(_x - brX) + sq(_y - brY) < sq(_r) ||
           sq(_x - tlX) + sq(_y - tlY) < sq(_r);
  }
  
  private boolean touchesV2(Block b){
    float blX = b.getX() - b.getHalfL();
    float blY = b.getY() + b.getHalfW();
    float trX = b.getX() + b.getHalfL();
    float trY = b.getY() - b.getHalfW();
    return sq(_x - blX) + sq(_y - blY) < sq(_r) ||
           sq(_x - trX) + sq(_y - trY) < sq(_r);
  }
  
  public void spawn(){
    fill(255);
    ellipse(_x, _y, _r*2, _r*2);
  }
  
  public boolean fallen(){
    return _y > height;
  }
  
}
