public class Shooter{

  private ArrayList<Bullet> _bullets;
  private ArrayList<Block> _blocks;
  private int _maxFrame, _frameNow, _shootCount, _maxShots;
  private float _startX, _targetX, _targetY;
  private boolean _used;
  
  public Shooter( int maxShots, float startX, float targetX, float targetY, ArrayList<Block> blocks){
    _bullets = new ArrayList();
    _maxFrame = 10;
    _frameNow = 0;
    _shootCount = 0;
    _maxShots = maxShots;
    _startX = startX;
    _blocks = blocks;
    _targetX = targetX;
    _targetY = targetY;
    _used = false;
  }
  
  public float setStartX( float newStartX ){
    float temp = _startX;
    _startX = newStartX;
    return temp;
  }
  
  public void tick(){
    if (_frameNow == 0){
      if (_shootCount < _maxShots){
        shoot();
        _shootCount ++;
      }
      _frameNow = _maxFrame;
    } else {
      _frameNow --;
    }
    
  }
  
  public float nextX(){
    float x = -1;
    for (int i = 0; i < _bullets.size(); i ++){
      _bullets.get(i).spawn();
      _bullets.get(i).move(_blocks);
      if (_bullets.get(i).fallen()){
        x = _bullets.remove(i).getX();
        i --;
      }
    }
    return x;
  }

  public boolean isDone(){
    if (!_used && _bullets.isEmpty()){
      _used = true;
      return true;
    }
    return false;
  }
  
  private void shoot(){
    _bullets.add( new Bullet(_targetX, _targetY, _startX, height) );
  }

}
