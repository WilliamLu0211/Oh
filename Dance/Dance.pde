ArrayList<Arrow> _arrows;

//variables related to game events
boolean _start, _over, _up, _down, _left, _right;
int _score, _pScore;
int _maxFrame, _frameNow;
float _leftX, _rightX;

void setup() {

  size( 1000, 600 );

  _arrows = new ArrayList();
  _score = 0;
  
  _start = false;
  _over = false;
  
  _maxFrame = 30;
  _frameNow = 0;
  
  _leftX = 120;
  _rightX = 210;
}

void gameOver() {//oh no
  clear();
  fill(255);
  textSize( 64 );//font size
  text( "GAME OVER", 300, 300 );
  textSize( 16 );//font size
  text( "Score: " + _pScore, 300, 400 );
  textSize( 16 );//font size
  text( "Left Click to Start" , 300, 500 );
}

void startingMenu() {
  fill(255);
  textSize( 64 );//font size
  text( "Dance", 300, 300 );
  textSize( 16 );//font size
  text( "Left click to start", 300, 400 );
}

void currentScore(){
  fill(255);
  textSize(25);
  text( "Score: " + _score, 30, height - 30);
}

void runGame(){
  
  currentScore();
  drawZone();
  Arrow a;
  for (int i = 0; i < _arrows.size(); i ++){
    a = _arrows.get(i);
    a.spawn(_leftX);
    a.move();
    if ( a.outOfBound() ){
      _arrows.remove(i);
      i --;
    }
    if ( a.getX() <= _rightX ){
      if ( !a.passed() ){
        //if ( a.getX() < _leftX ){
        //  _over = true;
        //}
        if (a.getX() >= _leftX &&(
            _up && a.getType() == 0 ||
            _down && a.getType() == 1 ||
            _left && a.getType() == 2 ||
            _right && a.getType() == 3)){
          a.pass();
          _score ++;
        }
      }
    }
  }
  
  if (_frameNow == 0){
    _arrows.add( new Arrow( (int)(Math.random() * 4) ));
    _frameNow = _maxFrame;
  } else {
    _frameNow --;
  }
  
}

void drawZone(){
  rectMode(CENTER);
  rect((_leftX + _rightX) / 2, height / 2, 90, 90);
}

void draw() {
  clear();
  if (!_start) {
    startingMenu();
  } else if (_over){
    if (_score != 0){
      _pScore = _score;
      _score = 0;
    }
    gameOver();
  } else {
    runGame();
  }
}

void mouseClicked(){
  if (!_start)
    _start = true;
  if (_over){
    _over = false;
    while (!_arrows.isEmpty())
      _arrows.remove(0);
  }
}

void keyPressed(){
  if (keyCode == UP){
    _up = true;
  }
  if (keyCode == DOWN){
    _down = true;
  }
  if (keyCode == LEFT){
    _left = true;
  }
  if (keyCode == RIGHT){
    _right = true;
  }
}

void keyReleased(){
  if (keyCode == UP){
    _up = false;
  }
  if (keyCode == DOWN){
    _down = false;
  }
  if (keyCode == LEFT){
    _left = false;
  }
  if (keyCode == RIGHT){
    _right = false;
  }
}
