public class Block extends Unit {
  
  private float _halfL, _halfW;
  private int _health;
  
  public Block(float x, float y, int h) {
    super(x, y);
    _halfL = 50;
    _halfW = 25;
    _health = h;
  }
  
  public float getHalfL(){
    return _halfL;
  }
  
  public float getHalfW(){
    return _halfW;
  }
  
  public int getHealth(){
    return _health;
  }
  
  public void moveDown(){
    _y += 50;
  }
  
  public void decrementHealth(){
    _health --;
  }
  
  public boolean isAlive(){
    return _health > 0;
  }
  
  public void spawn(){
    fill(255, 255, 0);
    rectMode(CENTER);
    rect(_x, _y, 2*_halfL, 2*_halfW);
    fill(0);
    textSize(16);
    text( _health, _x, _y );
  }
  
}
