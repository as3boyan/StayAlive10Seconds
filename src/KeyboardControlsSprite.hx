package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;

/**
 * ...
 * @author AS3Boyan
 */
class KeyboardControlsSprite extends Sprite
{
	var keys:Array<Bool>;
	
	public function new() 
	{
		super();
		
		keys = new Array();
		
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
	}
	
	private function onAdded(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		
		stage.addEventListener(Event.DEACTIVATE, function (_) { keys = new Array();} );
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey.bind(true));
		stage.addEventListener(KeyboardEvent.KEY_UP, onKey.bind(false));
	}
	
	private function onKey(down:Bool, e:KeyboardEvent):Void 
	{
		keys[e.keyCode] = down;
	}
	
}