class Unit{

  ArrayList<Bullet> bullets;
  boolean isAlive;
  float x, y, dx, dy, r;
  color c;
  
  Unit(){
    bullets = new ArrayList();
    isAlive = true;
    x = 400;
    y = 400;
    dx = 4;
    dy = 4;
    r = 10;
    c = color(0, 0, 255);
  }
  
  void move(){
    x += dx;
    y += dy;
  }

}