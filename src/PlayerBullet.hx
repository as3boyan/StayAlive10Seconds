package ;
import aze.display.TileLayer;

/**
 * ...
 * @author AS3Boyan
 */
class PlayerBullet extends Bullet
{
	
	public function new(_tile_layer:TileLayer) 
	{
		super(_tile_layer, "player_bullet");
	}
	
}