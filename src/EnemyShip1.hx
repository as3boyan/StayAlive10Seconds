package ;
import aze.display.TileLayer;
import aze.display.TileSprite;
import flash.geom.Point;

/**
 * ...
 * @author AS3Boyan
 */
class EnemyShip1 extends EnemyShip
{
	var bullet_manager1:BulletManager;
	var bullet_manager2:BulletManager;
	//var direction:Int;

	public function new(_tile_layer:TileLayer) 
	{
		super(_tile_layer, "enemy_ship");
		
		bullet_manager1 = new BulletManager(_tile_layer, 50, EnemyBullet1, type, new Point(3 - width / 2, 30 - height / 2), Math.PI, 150, 75, 10);
		bullet_manager2 = new BulletManager(_tile_layer, 50, EnemyBullet1, type, new Point(34 - width / 2, 30 - height / 2), Math.PI, 150, 75, 10);
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
		
		if (fly_mode)
		{
			var target_x = x + 150 * direction * elapsed / 1000;
			
			if (target_x > width / 2 && target_x < 800 - width / 2)
			{
				x = target_x;
			}
			else
			{
				direction *= -1;
			}
			
		}
		
	}
	
}