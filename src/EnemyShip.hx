package ;
import aze.display.TileLayer;
import aze.display.TileSprite;
import flash.geom.Point;

/**
 * ...
 * @author AS3Boyan
 */
class EnemyShip extends ShipEntity
{
	var direction:Int;

	public function new(_tile_layer:TileLayer, _id:String) 
	{
		super(_tile_layer, _id, 1);
		
		visible = false;
		
		direction = 1;
	}
	
	override public function shoot():Void 
	{
		super.shoot();
	}
	
	override public function step(elapsed:Int):Void 
	{
		super.step(elapsed);
	}
	
}