package ;
import aze.display.TileLayer;

/**
 * ...
 * @author AS3Boyan
 */
class ParticleSystemManager extends Manager
{

	public function new(_tile_layer:TileLayer, _n:Int, _particle_class:Dynamic) 
	{
		super(_tile_layer, _n, _particle_class);
	}
	
	public function burst(_x:Float, _y:Float):Void
	{		
		var n:Int = 0;
		
		for (i in 0...pool.length)
		{
			if (pool[i].visible == false)
			{
				var particle = cast (pool[i], Particle);
				
				particle.x = _x;
				particle.y = _y;
				particle.setSpeedAndAngle(150 + Std.random(30), 2 * Math.PI * Math.random());
				particle.setDelay(Std.random(10));
				particle.visible = true;
				
				Game.particles.push(particle);
				Game.particles_layer.addChild(particle);
				
				n++;
				
				if (n >= 25)
				{
					break;
				}
			}
		}
	}
	
}