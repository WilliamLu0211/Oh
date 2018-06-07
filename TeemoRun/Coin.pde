public class Coin extends Item {
  
  private int _value;
 
  public Coin( int size, float x, float y ) {
    super( x, y, createShape( RECT, 0, 0, size, size ), color( 255, 215, 0) );
    if ( size == 24 ) {
      _value = 200;
    }
    if ( size == 20 ) {
      _value = 100;
    }
    else {
      _value = 50;
    }
  }
  
  public int getValue() {
    return _value;
  }
  
}
