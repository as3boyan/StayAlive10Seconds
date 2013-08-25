package ;
import aze.display.TileLayer;
import haxe.Timer;

/**
 * ...
 * @author AS3Boyan
 */
class ShipEntity extends Entity
{
	var hp:Int;
	public var type:Int;
	var reward:Int;
	var target_y:Float;
	var fly_mode:Bool;
	var cooldown:Float;
	var shoot_on:Bool;
	var timer:Timer;

	public function new(_tile_layer:TileLayer, _tile:String, _type:Int) 
	{
		super(_tile_layer, _tile);
		
		type = _type;
		
		y = -100;
	}
	
	public function setHP(_hp:Int):Void
	{
		hp = _hp;
	}
	
	public function setReward(_reward:Int):Void
	{
		reward = _reward;
	}
	
	public function setTarget(_y:Float):Void
	{
		target_y = _y;
		fly_mode = false;
	}
	
	public function setCooldown(_cooldown:Float):Void
	{
		cooldown = _cooldown;
		shoot_on = true;
		
		timer = new Timer(Std.int(cooldown*1000));
		timer.run = function ():Void
		{
			shoot_on = !shoot_on;
		};
	}
	
	public function hit(_damage:Int):Void
	{
		hp += -_damage;
		
		if (visible && hp < 0)
		{
			visible = false;
			Game.particle_system_manager.burst(x, y);
			
			if (type == 1 && reward != 0)
			{
				Game.money += reward;
			}
			
			if (timer != null)
			{
				timer.stop();
				timer = null;
			}
		}
	}
	
	override public function step(elapsed:Int):Void 
	{
		super.step(elapsed);
		
		if (fly_mode == false)
		{
			if (y - target_y > 5)
			{
				y += - 100 * elapsed / 1000;
			}
			else if (y - target_y < -5)
			{
				y += 100 * elapsed / 1000;
			}
			else
			{
				fly_mode = true;
			}
		}
	}
	
}