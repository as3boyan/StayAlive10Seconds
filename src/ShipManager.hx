package ;
import aze.display.TileLayer;
import haxe.Timer;

/**
 * ...
 * @author AS3Boyan
 */
class ShipManager extends Manager
{
	var hp:Int;
	var reward:Int;
	var cooldown:Float;
	var type:Int;

	public function new(_tile_layer:TileLayer, _n:Int, ship_class:Dynamic, _hp:Int,  _reward:Int, _cooldown:Float = 0, _type:Int = 1) 
	{
		super(_tile_layer, _n, ship_class);
		
		hp = _hp;
		reward = _reward;
		cooldown = _cooldown;
		type = _type;
	}
	
	public function spawnAt(_x:Float, _y:Float, _target_y:Float, _delay:Float = 0) 
	{
		if (_delay > 0)
		{
			var timer:Timer = new Timer(Std.int(_delay * 1000));
			timer.run = function ():Void
			{
				spawn(_x, _y, _target_y);
				timer.stop();
			}
		}
		else
		{
			spawn(_x, _y, _target_y);
		}
	}
	
	private function spawn(_x:Float, _y:Float, _target_y:Float):Void
	{
		var ship = null;
	
		for (i in 0...pool.length)
		{
			if (pool[i].visible == false && pool[i].parent == null)
			{
				ship = pool[i];
				break;
			}
		}
		
		if (ship == null)
		{
			ship = Type.createInstance(_class, [tile_layer]);
			pool.push(ship);
		}
		
		ship = cast (ship, ShipEntity);
		
		ship.x = _x;
		ship.y = _y;
		ship.setHP(hp);
		ship.setReward(reward);
		ship.setTarget(_target_y);
		ship.setCooldown(cooldown);
		
		//bullet.setSpeedAndAngle(speed, -90/180*Math.PI);
		
		Game.ships.push(ship);
		Game.enemy_layer.addChild(ship);
		
		ship.visible = true;
	}
	
	public function setHP(_hp:Int):Void
	{
		hp = _hp;
	}
	
}