package ;
import aze.display.TileLayer;
import aze.display.TileSprite;
import flash.geom.Point;

/**
 * ...
 * @author AS3Boyan
 */
class PlayerShip extends AlliesShip
{
	var speed_x:Float;
	var speed_y:Float;
	var speed:Float;
	
	public function new(_tile_layer:TileLayer) 
	{
		super(_tile_layer);
		
		speed_x = 0;
		speed_y = 0;
		
		speed = 210;
	}
	
	override public function step(elapsed:Int):Void 
	{		
		var target_x:Float = x + speed_x * elapsed / 1000 * speed;
		var target_y:Float = y + speed_y * elapsed / 1000 * speed;

		if (target_x > width / 2 && target_x < 800 - width / 2) x = target_x;
		if (target_y > height / 2 && target_y < 480 - height / 2) y = target_y;
	}
	
	public function move(_speed_x:Null<Float>, _speed_y:Null<Float>) 
	{
		if (_speed_x != null) speed_x = _speed_x;
		if (_speed_y != null) speed_y = _speed_y;
	}
	
	override public function shoot():Void 
	{
		if (visible)
		{		
			bullet_manager1.shoot(x, y);
			bullet_manager2.shoot(x, y);
		}		
	}
	
	public function getHP() 
	{
		return hp;
	}
	
}