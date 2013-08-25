package ;
import aze.display.TileLayer;
import flash.geom.Point;

/**
 * ...
 * @author AS3Boyan
 */
class AlliesShip extends ShipEntity
{
	var bullet_manager1:BulletManager;
	var bullet_manager2:BulletManager;

	public function new(_tile_layer:TileLayer) 
	{
		super(_tile_layer, "player_ship", 0);
		
		bullet_manager1 = new BulletManager(_tile_layer, 50, PlayerBullet, type, new Point(4-width/2, 4-height/2), 0, 250, 50, 5);
		bullet_manager2 = new BulletManager(_tile_layer, 50, PlayerBullet, type, new Point(32 - width / 2, 4 - height / 2), 0, 250, 50, 5);
		
		hp = 200;
	}
	
	override public function shoot():Void 
	{
		super.shoot();
		
		bullet_manager1.shoot(x, y);
		bullet_manager2.shoot(x, y);
	}
	
	override public function step(elapsed:Int):Void 
	{
		super.step(elapsed);
		shoot();
		
		//if (fly_mode && y > 350)
		//{
			//target_y += -50;
			//fly_mode = false;
		//}
	}
	
}