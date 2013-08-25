package ;
import aze.display.TileLayer;
import flash.geom.Point;
import flash.Lib;

/**
 * ...
 * @author AS3Boyan
 */
class BulletManager extends Manager
{
	var offset:Point;
	var angle_offset:Float;
	var speed:Int;
	var rate:Int;
	var last_shoot_time:Int;
	var type:Int;
	var damage:Int;

	public function new(_tile_layer:TileLayer, _n:Int, _bullet_class:Dynamic, _type:Int, _offset:Point, _angle_offset:Float, _speed:Int, _rate:Int, _damage:Int) 
	{
		super(tile_layer, _n, _bullet_class);
		
		offset = _offset;
		angle_offset = _angle_offset;
		speed = _speed;
		rate = _rate;
		type = _type;
		damage = _damage;
		
		last_shoot_time = 0;
	}
	
	public function shoot(x:Float, y:Float):Void
	{
		var current_time:Int = Lib.getTimer();
		
		if (current_time - last_shoot_time > rate)
		{
			var bullet = null;
		
			for (i in 0...pool.length)
			{
				if (pool[i].visible == false && pool[i].parent == null)
				{
					bullet = pool[i];
					break;
				}
			}
			
			if (bullet == null)
			{
				bullet = Type.createInstance(_class, [tile_layer]);
				pool.push(bullet);
			}
			
			bullet = cast (bullet, Bullet);
			
			bullet.x = x + offset.x;
			bullet.y = y + offset.y;
			
			bullet.setDamageAndType(damage, type);
			
			bullet.setSpeedAndAngle(speed, angle_offset - 90 / 180 * Math.PI);
			
			bullet.visible = true;
			
			Game.bullets.push(bullet);
			Game.bullets_layer.addChild(bullet);
			
			last_shoot_time = current_time;
		}
	}
	
}