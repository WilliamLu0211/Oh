public class Arrow{
  
  private final int U = 0,
                    D = 1,
                    L = 2,
                    R = 3;
  
  private int _type;
  private float _x = width + 45;
  private float _dx = 5;
  private float _w = 30, _l = 60;
  private boolean _passed = false;
  
  public Arrow( int t ) {
    _type = t;
  }
  
  public float getX() {
    return _x;
  }
  
  public void move(){
    _x -= _dx;
  }
  
  public boolean outOfBound(){
    return _x <= -45;
  }
  
  public void pass(){
    _passed = true;
  }
  
  public boolean passed(){
    return _passed;
  }
  
  public int getType(){
    return _type;
  }
  
  public void spawn(float x){
    float y = height / 2;
    rectMode(CENTER);
    if (_passed)
      fill(0, 255, 0);
    else if (_x > x)
      fill(255);
    else
      fill(255, 0, 0);
    if (_type == U){
      rect(_x, y - 15, _w, _l);
      triangle(_x, y + 45, _x - 45, y + 15, _x + 45, y + 15);
    }
    if (_type == D){
      rect(_x, y + 15, _w, _l);
      triangle(_x, y - 45, _x - 45, y - 15, _x + 45, y - 15);
    }
    if (_type == L){
      rect(_x + 15, y, _l, _w);
      triangle(_x - 45, y, _x - 15, y + 45, _x - 15, y - 45);
    }
    if (_type == R){
      rect(_x - 15, y, _l, _w);
      triangle(_x + 45, y, _x + 15, y + 45, _x + 15, y - 45);
    }
  }
  
}
