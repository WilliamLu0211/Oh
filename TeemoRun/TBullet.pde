public class TBullet extends Bullet {
  
  private int _dmg;
  
  public TBullet( float tilt, int dmg, float x, float y ){
    super( tilt, mouseX, mouseY, 10, x, y, color( 0, 175, 0 ) );
    _dmg = dmg;
  }

  public int getDamage() {
    return _dmg;
  }
  
}
