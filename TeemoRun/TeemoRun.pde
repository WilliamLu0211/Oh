ArrayList<Bullet> bullets = new ArrayList();
Teemo t = new Teemo();

void setup(){
  size(800, 800);
  background(0);
}

void draw(){
  clear();
  bullets.add( new Bullet(10, 450, 450, 3, 4, color(10, 100, 200)) );
  for (Bullet b : bullets)
    b.move();
  t.move();
  delay(100);
}