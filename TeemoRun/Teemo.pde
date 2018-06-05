public class Teemo extends Unit { //<>//
  
  private int _dmg, _attackSpeed, _score;
  private Queue<Ability> _abilities;
  private int[] _abilityDurations;
  private float _speed;
  
  public Teemo() {
    super( 700, 400, 20);
    _shape = createShape(ELLIPSE, 0, 0, 2*_r, 2*_r);
    _shape.setFill(color( 0, 175, 0 ));
    _dmg = 10;
    _attackSpeed = 60;
    super.setTime( 1 );
    _score = 0;
    _speed = 1.5;
    _abilities = new Queue();
    _abilityDurations = new int[8];
  }
  
  public void move( int x, int y ) {
    float dx = 0, dy = 0;
    if (x == 0)
      dy = y * _speed;
    else if (y == 0)
      dx = x * _speed;
    else {
      dx = _speed * x / sqrt(2);
      dy = _speed * y / sqrt(2);
    }
    _x += dx;
    _y += dy;
  }
  
  public boolean attackReady() {
    return super.getTime() == 0;
  }
  
  public boolean isBoosted() {
    return _abilityDurations[0] > 0;
  }
  
  public boolean isMagnetized() {
    return _abilityDurations[2] > 0;
  }
  
  public void attackReset() {
    if ( _abilityDurations[6] > 0 ) {
      super.setTime( _attackSpeed / 2 );
    }
    else {
      super.setTime( _attackSpeed );
    }
  }
  
  public int score( int time ) {
    _score += time;
    return _score;
  }
  
  public TBullet[] shoot( float x, float y ) {
    float dmgMultiplier = 1;
    TBullet[] retArr;
    
    if ( _abilityDurations[5] > 0 ) {
      retArr = new TBullet[3];
    }
    else {
      retArr = new TBullet[1];
    }
    
    if ( _abilityDurations[1] > 0 ) {
      dmgMultiplier *= 2;
    }
    if ( _abilityDurations[0] > 0 ) {
      dmgMultiplier = 10000;
    }
    attackReset();
    
    retArr[0] = new TBullet( 0, (int)(_dmg * dmgMultiplier), _x, _y);
    if ( _abilityDurations[5] > 0 ) {
      retArr[1] = new TBullet( PI/6, (int)(_dmg * dmgMultiplier), _x, _y );
      retArr[2] = new TBullet( -PI/6, (int)(_dmg * dmgMultiplier), _x, _y );
    }
    return retArr;
  }
  
  public void pickUp( Item i ) {
    if ( i instanceof Coin )
      _score += ((Coin)i).getValue();
    else
      _abilities.enqueue( (Ability)i );
  }
  
  public void use() {
    if ( _abilities.isEmpty() ) {
      return;
    }
    Ability a = _abilities.dequeue();
    int type = a.getType();    
    if ( type == 0 ) {//boost
      _abilityDurations[0] += 5 * (int)frameRate;
    }
    if ( type == 1 ) {//twin
      _abilityDurations[1] += 20 * (int)frameRate;
    }
    if ( type == 2 ) {//magnet
      _abilityDurations[2] += 20 * (int)frameRate;
    }
    if ( type == 3 ) {//damage upgrade
      _dmg += 10;
    }
    if ( type == 4 ) {//ghost
      _abilityDurations[4] += 15 * (int)frameRate;
    }
    if ( type == 5 ) {//trident
      _abilityDurations[5] += 5 * (int)frameRate;
    }
    if ( type == 6 ) {//rage
      _abilityDurations[6] += 20 * (int)frameRate;
    }
    if ( type == 7 ) {//attack speed upgrade
      _attackSpeed *= 0.8; 
    }
  }
  
  public void tick() {
    super.tick();
    for( int i = 0; i < _abilityDurations.length; i++ ) {
      if ( _abilityDurations[i] > 0 ) {
        _abilityDurations[i]--;
      }
    }
  }
  
  public void spawn() {
    if ( _abilityDurations[0] > 0 ) {
      fill( 255, 255, 255 );
      //shape( createShape( ELLIPSE, 0, 0, 40, 40 ), getX(), getY() );
      ellipse(getX(), getY(), 40, 40);
    }
    else {
      super.spawn();
    }
  }
  
}
