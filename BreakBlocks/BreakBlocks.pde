ArrayList<Block> _blocks;
Shooter _s;
//variables related to game events
boolean _start, _readyToClick, _readyToAdd;
int _score;
float _blockSpawnChance, _blockSpawnCount, _doubleHealthChance;
float _mouseX, _mouseY, _currX;


void setup() {

  size( 1000, 600 );

  _blocks = new ArrayList();
  _currX = width / 2;
  _score = 0;
  
  _blockSpawnCount = 1.4;
  updateChance();
  _doubleHealthChance = 0.7;
  
  _start = false;
  _readyToClick = true;
  _readyToAdd = true;
}

//helper methods
void updateChance(){
  _blockSpawnChance = 1 - 1 / _blockSpawnCount;
  _blockSpawnCount += 0.01;
}

void gameOver() {//oh no
  clear();
  fill(255);
  textSize( 64 );//font size
  text( "GAME OVER", 300, 300 );
  textSize( 16 );//font size
  text( "Score: " + _score, 300, 400 );
  noLoop();//stops calling draw
  //_start = false;
  //textSize( 16 );//font size
  //text( "Left Click to Start" , 300, 500 );
}

void startingMenu() {
  fill(255);
  textSize( 64 );//font size
  text( "Break Blocks", 300, 300 );
  textSize( 16 );//font size
  text( "Left click to start", 300, 400 );
}

void addBlocks(){
  for (Block b : _blocks)
    b.moveDown();
  for (int x = 50; x < width; x += 100)
    if (Math.random() < _blockSpawnChance)
      if (Math.random() < _doubleHealthChance)
        _blocks.add( new Block(x, 75, _score) );
      else
        _blocks.add( new Block(x, 75, _score * 2) );
}

void currentScore(){
  fill(255);
  textSize(25);
  text( "Score: " + _score, 30, height - 30);
}

void runGame(){
  
  currentScore();
  for (int i = 0; i < _blocks.size(); i ++){
    _blocks.get(i).spawn();
    if ( !_blocks.get(i).isAlive() ){
      _blocks.remove(i);
      i --;
    }
  }
  
  _s.tick();
  float x = _s.nextX();
  if (x >= 0)
    _currX = x;
  
  if (_readyToAdd){
    addBlocks();
    _readyToClick = true;
    _readyToAdd = false;
  }
  
  if (_s.isDone()){
    _readyToAdd = true;
    //_currX = (float)Math.random() * width;
  }
  
  fill(255);
  ellipse(_currX, height - 4, 16, 16);
  
  for (Block b : _blocks)
    if (b.getY() == 575)
      gameOver();
  
}

void draw() {
  clear();
  if ( !_start ) {
    startingMenu();
  } else {
    runGame();
  }
}

void mouseClicked(){
  if ( !_start )
    _start = true;
  if (_readyToClick){
    _readyToClick = false;
    updateChance();
    _s = new Shooter(_score, _currX, mouseX, mouseY, _blocks);
    _score ++;
  }
}
