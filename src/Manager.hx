package ;
import aze.display.TileLayer;

/**
 * ...
 * @author AS3Boyan
 */
class Manager
{
	var pool:Array<Dynamic>;
	var _class:Dynamic;
	var tile_layer:TileLayer;
	
	public function new(_tile_layer:TileLayer, _n:Int, entity_class:Dynamic) 
	{
		tile_layer = _tile_layer;
		
		_class = entity_class;
		
		pool = new Array();
		
		for (i in 0..._n)
		{
			var class_instance = Type.createInstance(_class, [tile_layer]);
			pool.push(class_instance);
		}
	}
	
}