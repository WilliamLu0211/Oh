class Bullet{

  int dmg;
  float x, y, dx, dy;
  color c;
  final int r = 5;
  
  Bullet( int newDmg, float newX, float newY, float newDx, float newDy, color newC ){
    dmg = newDmg;
    x = newX;
    y = newY;
    dx = newDx;
    dy = newDy;
    c = newC;
  }
  
  void move(){
    x += dx;
    y += dy;
    fill(c);
    ellipse(x, y, 2*r, 2*r);
  }

}