package ;
import aze.display.TileGroup;
import aze.display.TileLayer;
import aze.display.TileSprite;
import flash.geom.Point;

/**
 * ...
 * @author AS3Boyan
 */
class ProgressBar extends TileGroup
{
	var fill:TileSprite;
	var image:TileSprite;
	
	public function new(_tile_layer:TileLayer) 
	{
		super(_tile_layer);
		
		fill = new TileSprite(_tile_layer, "progressbar_fill");
		fill.x = 1;
		fill.y = 1;
		addChild(fill);
		
		image = new TileSprite(_tile_layer, "progressbar");
		addChild(image);
		
		x = 800 - width / 2;
		y = 480 - height / 2;
		
		image.alpha = 0.8;
		fill.alpha = 0.8;
	}
	
	public function setPercent(_percent:Float):Void
	{
		fill.scaleX = Math.max(_percent, 0);
		fill.x = image.x - image.width / 2 + fill.width/2;
	}
	
}