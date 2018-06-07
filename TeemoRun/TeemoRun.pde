//variables to aid with controls
boolean W, A, S, D, SPACE;  //true = key currently pressed down  0:W 1:A 2:S 3:D 4:SPACE 5:ESCAPE
boolean _mouse; //true = mouse currently pressed down
boolean _spaceLock; //makes sure holding down space isn't read as space pressed repeatedly

//stores on-screen entities
Teemo _t;
ArrayList<Bullet> _bullets;
ArrayList<Minion> _minions;
ArrayList<Item> _items;

//stores all non player controlled on-screen entities
ArrayList<ArrayList> _units;

//variables related to game events
boolean _start;
int _minionSpawnTime, _minionSpawnTimer, _minionHealth;
float _dropSpawnRate, _abilitySpawnRate;


void setup() {

  frameRate( 120 );//120fps :O
  size( 1024, 768 );

  //initialize Teemo
  _t = new Teemo();

  _bullets = new ArrayList();
  _minions = new ArrayList();
  _items = new ArrayList();

  _units = new ArrayList();
  _units.add( _bullets );
  _units.add( _minions );  
  _units.add( _items );

  //initialize values
  _minionSpawnTime = _minionSpawnTimer = 200;//frames between checking to spawn minions or not; frames before next check
  _minionHealth = 20;//minion health
  _dropSpawnRate = 0.5;//odds of spawning a drop during a check
  _abilitySpawnRate = 0.5;//odds of spawning ability instead of coin

  //start game with 1 minion on screen, OPTIONAL
  addNewMinion();
}

//helper methods
void addNewMinion() {//spawns in new minion at random location
  float mX, mY;
  mX = random( 1300 ) + 50;
  mY = random( 700 ) + 50;
  while ( sq( mX - _t.getX() ) + sq( mY - _t.getY() ) < 40000 ) {//forces location to be certain distance away from Teemo
    mX = random( 1300 ) + 50;
    mY = random( 700 ) + 50;
  }
  _minions.add( new Minion( _minionHealth, mX, mY ) );
  _minionHealth += 10;
}

void addNewAbility( float x, float y ) {//spawns in new ability drop at (x,y)
  float n = random( 100 );
  color tmp;
  if ( n < 9 ) {//9-0% (9) chance
    tmp = color( 255, 0, 0 );//red: boost
  } else if ( n < 24 ) {//24-9% (15) chance
    tmp = color( 255, 125, 0 );//orange: twin
  } else if ( n < 34 ) {//34-24% (10) chance
    tmp = color( 255, 255, 0 );//yellow: magnet
  } else if ( n < 48 ) {//48-34% (14) chance
    tmp = color( 0, 255, 0 );//green: damage upgrade
  } else if ( n < 62 ) {//62-48% (14) chance
    tmp = color( 0, 255, 255 );//light blue: ghost
  } else if ( n < 77 ) {//77-62% (15) chance
    tmp = color( 0, 0, 255 );//dark blue: trident
  } else if ( n < 92 ) {//92-77% (15) chance
    tmp = color( 175, 0, 255 );//purple: rage
  } else {//100-92% (8) chance
    tmp = color( 255, 0, 200 );//pink: attack speed upgrade
  }
  _items.add( new Ability( x, y, tmp ) );
}

void addNewCoin( float x, float y ) {//spawns in new coin drop
  _items.add( new Coin( ceil( random( 3 ) ) * 4 + 12, x, y ) );
}

void gameOver() {//oh no
  clear();
  fill(255);
  textSize( 64 );//font size
  text( "GAME OVER", 300, 300 );
  textSize( 16 );//font size
  text( "Score: " + _t.score( frameCount / 5 ), 300, 500 );
  noLoop();//stops calling draw
}

//void menu() {
//  textSize(15);
//  fill(255);
//  text("Ability Menu:\n    boost\n    twin\n    magnet\n    damage updrade\n    ghost\n    trident\n    rage\n    attack speed upgrade", 30, 30);
//  fill( color( 255, 0, 0 ) );
//  drawTriangle(25, 38);
//  fill( color( 255, 125, 0 ) );
//  drawTriangle(25, 63);
//  fill( color( 255, 255, 0 ) );
//  drawTriangle(25, 88);
//  fill( color( 0, 255, 0 ) );
//  drawTriangle(25, 115);
//  fill( color( 0, 255, 255 )  );
//  drawTriangle(25, 138);
//  fill( color( 0, 0, 255 ) );
//  drawTriangle(25, 162);
//  fill( color( 175, 0, 255 ) );
//  drawTriangle(25, 185);
//  fill( color( 255, 0, 200 ) );
//  drawTriangle(25, 210);
//}

void drawTriangle(float x, float y) {
  triangle(x, y, x + 24, y, x + 12, y + 12*sqrt(3));
}

void nextAbility() {
  textSize(15);
  fill(255);
  String tmp;
  if ( _t.getNext() == null ) {
    tmp = "None";
  } else {
    tmp = _t.getNext().name();
  }
  text("Next Ability: " + tmp, 30, height - 30);
}

void startingMenu() {
  fill(255);
  textSize( 64 );//font size
  text( "TEEMO RUN", 300, 300 );
  textSize( 16 );//font size
  text( "By Brandon Chong, William Lu, and Andrew Shao\n\nPress SPACE to start", 300, 500 );
}

void runGame() {
  nextAbility();
  if ( keyPressed ) {
    if ( SPACE ) {//space pressed
      SPACE = false;
      _t.use();
    } 
    if ( W ) {
      if ( A ) {//W & A
        _t.move( -1, -1 );//up & left
      } else if ( D ) {//W & D
        _t.move( 1, -1 );//up & right
      } else {//only W
        _t.move( 0, -1 );//up
      }
    } else if ( S ) {
      if ( A ) {//S & A
        _t.move( -1, 1 );//down & left
      } else if ( D ) {//S & D
        _t.move( 1, 1 );//down & right
      } else {//only S
        _t.move( 0, 1 );//down
      }
    } else if ( A ) {//only A
      _t.move( -1, 0 );//left
    } else if ( D ) {//only D
      _t.move( 1, 0 );//right
    }
  }

  //"You may fire when ready"
  if ( _t.attackReady() ) {//mouse has been clicked/held down AND Teemo ready to fire _mouse && 
    for ( Bullet b : _t.shoot() ) {//shoot at mouse location
      _bullets.add( b );//spawns bullet
    }
  }

  //check all minions
  for ( int i = 0; i < _minions.size(); i++ ) {
    _minions.get( i ).move();//move minion forward
    if ( _minions.get( i ).attackReady() ) {//check if minion is ready to shoot
      _bullets.add( _minions.get( i ).shoot( _t.getX(), _t.getY() ) );//minion shoots, bullet spawned
    }
    if ( _minions.get( i ).touches( _t ) ) {//check if minion is touching Teemo
      if ( _t.isBoosted() ) {//check if Teemo invulnerable
        _minions.remove( i );//rekt
        i --;
      } else {
        gameOver();//not rekt
      }
    }
  }

  TBullet tmpTB;//temporary storage for Teemo bullets
  MBullet tmpMB;//temporary storage for minion bullets
  for ( int i = 0; i < _bullets.size(); i++ ) {//check all bullets
    if ( _bullets.get( i ) instanceof TBullet ) {//bullet is a Teemo bullet
      tmpTB = (TBullet)_bullets.get( i );
      for ( int j = 0; j < _minions.size(); j++ ) {//check all minions
        if ( tmpTB.touches( _minions.get( j ) ) ) {//check if bullet hit minion
          _minions.get( j ).hit( tmpTB );//deduct health
          if ( !_minions.get( j ).isAlive() ) {//if hit was fatal
            if ( Math.random() < _dropSpawnRate ) {//check to spawn a drop
              if ( Math.random() < _abilitySpawnRate ) {//ability drop
                addNewAbility( _minions.get( j ).getX(), _minions.get( j ).getY() - 6 );
              } else {//coin drop
                addNewCoin( _minions.get( j ).getX() - 6, _minions.get( j ).getY() - 6 );
              }
            }
            _minions.remove( j );//despawn minion if killed
            j --;
          }
          _bullets.remove( i );//despawn bullet if hit
          i --;
          break;//IMPORTANT! move to next bullet
        }
      }
    } else {
      tmpMB = (MBullet)_bullets.get( i );
      if ( tmpMB.touches( _t ) && !_t.isBoosted() ) {//man down
        gameOver();//mama mia
        break;
      }
    }
  }
  for ( int i = 0; i < _bullets.size(); i++ ) {//check all bullets
    if ( _bullets.get( i ).outOfBounds() ) {//check if bullet out of play area
      _bullets.remove( i );//despawn bullet
      i --;
    } else {//otherwise keep moving bullet
      _bullets.get( i ).move();
    }
  }

  //check all items
  for ( int i = 0; i < _items.size(); i++ ) {
    if ( _items.get( i ).despawnReady() ) {//check if time to despawn item
      _items.remove( i );//despawn item
      i --;
    }
  }

  if ( _minionSpawnTimer == 0) {//check if time to check to spawn minion or not
    addNewMinion();//spawn new minion
    _minionSpawnTimer = _minionSpawnTime;//reset minion spawn timer
  }

  //check all items
  for ( int i = 0; i < _items.size(); i++ ) {
    if ( _t.touches( _items.get(i) ) ) {//if Teemo is next to or on top of item
      _t.pickUp( _items.get( i ) );//Teemo picks up item
      _items.remove( i );//despawns item
      i --;
    } else if ( _t.isMagnetized() ) {//Teemo has magnet ability active
      _items.get( i ).move( _t );//items move toward Teemo
    }
  }

  for ( ArrayList<Unit> A : _units ) {
    for ( Unit u : A ) {
      u.spawn();//draw all entities
      u.tick();//indicate frame has passed
    }
  }
  _t.spawn();//draw Teemo
  _t.tick();  

  if ( _minionSpawnTimer > 0 ) {//decrement minion spawning timer for passage of time
    if ( _minions.isEmpty() && _minionSpawnTimer > 1 ) {//spawn timer is faster when no minions left
      _minionSpawnTimer --;
    }
    _minionSpawnTimer--;
  }
}

void draw() {
  clear();
  if ( !_start ) {
    if ( SPACE ) {
      _start = true;
      delay( 500 );
    } else {
      startingMenu();
    }
  } else {
    runGame();
  }
}

void keyPressed() {
  if ( key == 'w' ) {
    W = true;
  } else if ( key == 'a' ) {
    A = true;
  } else if ( key == 's' ) {
    S = true;
  } else if ( key == 'd' ) {
    D = true;
  } else {
    if ( !_spaceLock ) {//space has been released/not pressed
      SPACE = true;
      _spaceLock = true;
    }
  }
}

void keyReleased() {
  if ( key == 'w' ) {
    W = false;
  } else if ( key == 'a' ) {
    A = false;
  } else if ( key == 's' ) {
    S = false;
  } else if ( key == 'd' ) {
    D = false;
  } else {
    SPACE = false;
    _spaceLock = false;//space ready to be pressed again
  }
}
