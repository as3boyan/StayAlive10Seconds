package ;
import aze.display.TileLayer;

/**
 * ...
 * @author AS3Boyan
 */
class Bullet extends Entity
{

	var speed_x:Float;
	var speed_y:Float;
	
	public var damage:Int;
	public var type:Int;
	
	public function new(_tile_layer:TileLayer, _tile:String) 
	{
		super(_tile_layer, _tile);
		
		speed_x = 0;
		speed_y = 0;
		
		visible = false;
	}
	
	override public function step(elapsed:Int):Void 
	{
		super.step(elapsed);
		
		if (x<-width/2 || x>800+width/2 || y<-height/2 || y>480+height/2)
		{
			visible = false;
			return;
		}
		
		x += speed_x *elapsed/1000;
		y += speed_y *elapsed/1000;
	}
	
	public function setSpeedAndAngle(_speed:Float, _angle:Float)
	{		
		speed_x = Math.cos(_angle) * _speed;
		speed_y = Math.sin(_angle) * _speed;
	}
	
	public function setDamageAndType(_damage:Int, _type:Int):Void
	{
		damage = _damage;
		type = _type;
	}
	
}