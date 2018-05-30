class Teemo {

  int _ad;
  Queue<Ability> _abilities;
  boolean _isAlive;
  float x, y, v;
  
  Teemo(){
    _ad = 200;
    _abilities = new Queue();
    _isAlive = true;
    x = 500;
    y = 500;
    v = 3;
  }

}
