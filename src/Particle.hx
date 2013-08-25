package ;
import aze.display.TileLayer;

/**
 * ...
 * @author AS3Boyan
 */
class Particle extends Bullet
{

	var speed:Float;
	var angle:Float;
	var delay:Int;
	
	public function new(_tile_layer:TileLayer) 
	{
		super(_tile_layer, "particle");
		alpha = 0.1;
	}
	
	override public function setSpeedAndAngle(_speed:Float, _angle:Float):Void 
	{
		super.setSpeedAndAngle(_speed, _angle);
		
		speed = _speed;
		angle = _angle;
	}
	
	override public function step(elapsed:Int):Void 
	{
		if (delay > 0)
		{
			delay--;
			return;
		}
		
		super.step(elapsed);
		
		speed *= 0.95;
		alpha = speed / 80 * 0.1;
		
		if (alpha < 0.001)
		{
			visible = false;
		}
		
		setSpeedAndAngle(speed, angle);
	}
	
	public function setDelay(_delay:Int):Void
	{
		delay = _delay;
	}
	
}