class Teemo extends Unit{

  PShape s;
  
  Teemo(){
    super();
    s = loadShape("index.jpeg");
  }
  
  void move(){
    super.move();
    shape(s, x, y, 2*r, 2*r);
  }

}