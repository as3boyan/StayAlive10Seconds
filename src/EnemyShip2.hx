package ;
import aze.display.TileLayer;
import aze.display.TileSprite;
import flash.geom.Point;

/**
 * ...
 * @author AS3Boyan
 */
class EnemyShip2 extends EnemyShip
{
	var bullet_manager1:BulletManager;
	var bullet_manager2:BulletManager;
	var bullet_manager3:BulletManager;
	var bullet_manager4:BulletManager;
	var bullet_manager5:BulletManager;
	var bullet_manager6:BulletManager;
	var bullet_manager7:BulletManager;
	var bullet_manager8:BulletManager;
	var bullet_manager9:BulletManager;
	var bullet_manager10:BulletManager;

	public function new(_tile_layer:TileLayer) 
	{
		super(_tile_layer, "enemy_ship2");
		
		bullet_manager1 = new BulletManager(_tile_layer, 50, EnemyBullet2, type, new Point(5 - width / 2, 29 - height / 2), Math.PI, 150, 100, 5);
		bullet_manager2 = new BulletManager(_tile_layer, 50, EnemyBullet2, type, new Point(14 - width / 2, 29 - height / 2), Math.PI, 150, 100, 5);
		bullet_manager3 = new BulletManager(_tile_layer, 50, EnemyBullet2, type, new Point(22 - width / 2, 29 - height / 2), Math.PI, 150, 100, 5);
		bullet_manager4 = new BulletManager(_tile_layer, 50, EnemyBullet2, type, new Point(30 - width / 2, 29 - height / 2), Math.PI, 150, 100, 5);
		bullet_manager5 = new BulletManager(_tile_layer, 50, EnemyBullet2, type, new Point(38 - width / 2, 29 - height / 2), Math.PI, 150, 100, 5);
		bullet_manager6 = new BulletManager(_tile_layer, 50, EnemyBullet2, type, new Point(75 - width / 2, 29 - height / 2), Math.PI, 150, 100, 5);
		bullet_manager7 = new BulletManager(_tile_layer, 50, EnemyBullet2, type, new Point(83 - width / 2, 29 - height / 2), Math.PI, 150, 100, 5);
		bullet_manager8 = new BulletManager(_tile_layer, 50, EnemyBullet2, type, new Point(92 - width / 2, 29 - height / 2), Math.PI, 150, 100, 5);
		bullet_manager9 = new BulletManager(_tile_layer, 50, EnemyBullet2, type, new Point(100 - width / 2, 29 - height / 2), Math.PI, 150, 100, 5);
		bullet_manager10 = new BulletManager(_tile_layer, 50, EnemyBullet2, type, new Point(107 - width / 2, 29 - height / 2), Math.PI, 150, 100, 5);		
	}
	
	override public function shoot():Void 
	{
		super.shoot();
		
		bullet_manager1.shoot(x, y);
		bullet_manager2.shoot(x, y);
		bullet_manager3.shoot(x, y);
		bullet_manager4.shoot(x, y);
		bullet_manager5.shoot(x, y);
		bullet_manager6.shoot(x, y);
		bullet_manager7.shoot(x, y);
		bullet_manager8.shoot(x, y);
		bullet_manager9.shoot(x, y);
		bullet_manager10.shoot(x, y);
	}
	
	override public function step(elapsed:Int):Void 
	{
		super.step(elapsed);
		
		if (fly_mode && shoot_on) shoot();
		
		//shoot();
		//
		//if (fly_mode == false)
		//{
			//if (y - target_y > 5)
			//{
				//y += - 100 * elapsed / 1000;
			//}
			//else if (y - target_y < -5)
			//{
				//y += 100 * elapsed / 1000;
			//}
			//else
			//{
				//fly_mode = true;
			//}
		//}
		//else
		//{
			//var target_x = x + 150 * direction * elapsed / 1000;
			//
			//if (target_x > width / 2 && target_x < 800 - width / 2)
			//{
				//x = target_x;
			//}
			//else
			//{
				//direction *= -1;
			//}
			//
		//}
		
	}
	
}