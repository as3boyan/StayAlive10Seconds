package ;

import aze.display.SparrowTilesheet;
import aze.display.TileClip;
import aze.display.TileGroup;
import aze.display.TileLayer;
import aze.display.TileSprite;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.ui.Keyboard;
import haxe.Timer;
import openfl.Assets;

/**
 * ...
 * @author AS3Boyan
 */
class Game extends KeyboardControlsSprite
{
	var tile_layer:TileLayer;
	var prev_time:Int;
	static public var player:PlayerShip;
	
	static public var ships:Array<ShipEntity>;
	static public var bullets:Array<Bullet>;
	static public var particles:Array<Particle>;
	static public var bullets_layer:TileGroup;
	static public var enemy_layer:TileGroup;
	static public var particles_layer:TileGroup;
	
	var enemy_manager1:ShipManager;
	var enemy_manager2:ShipManager;
	var enemy_manager3:ShipManager;
	var tile_layer2:TileLayer;
	var progress_bar:ProgressBar;
	
	static public var particle_system_manager:ParticleSystemManager;
	
	var money_tf:TextField;
	static public var money:Int;
	
	var time:Float;
	var time_tf:TextField;
	var allies_manager:ShipManager;
	var timer:Timer;
	
	var overlay:Sprite;
	var mission_complete:Bool;
	var tf:TextField;
	var retry_tf:TextField;

	public function new() 
	{
		super();
		
		var spritesheet:SparrowTilesheet = new SparrowTilesheet(Assets.getBitmapData("img/spritesheet.png"), Assets.getText("img/spritesheet.xml"));
		tile_layer = new TileLayer(spritesheet);
		
		var background:TileSprite = new TileSprite(tile_layer, "background");
		background.x = background.width / 2;
		background.y = background.height / 2;
		tile_layer.addChild(background);
		
		ships = new Array();
		bullets = new Array();
		particles = new Array();
		
		bullets_layer = new TileGroup(tile_layer);
		tile_layer.addChild(bullets_layer);
		
		enemy_layer = new TileGroup(tile_layer);
		tile_layer.addChild(enemy_layer);
		
		player = new PlayerShip(tile_layer);
		player.x = 800 / 2;
		player.y = 480 * 0.85;
		tile_layer.addChild(player);
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
				
		prev_time = Lib.getTimer();
		
		addChild(tile_layer.view);
		
		//graphics.beginFill(0xD6EFE7);
		//graphics.drawRect(0, 0, 800, 480);
		
		enemy_manager1 = new ShipManager(tile_layer, 25, EnemyShip1, 100, 5);
		enemy_manager2 = new ShipManager(tile_layer, 25, EnemyShip2, 300, 25, 3);
		enemy_manager3 = new ShipManager(tile_layer, 25, EnemyShip3, 150, 10);
		
		allies_manager = new ShipManager(tile_layer, 50, AlliesShip, 200, 0, 0, 0);
				
		progress_bar = new ProgressBar(tile_layer);
		tile_layer.addChild(progress_bar);
		
		tile_layer2 = new TileLayer(spritesheet, true, true);
		addChild(tile_layer2.view);
		
		particles_layer = new TileGroup(tile_layer2);
		tile_layer2.addChild(particles_layer);
		
		particle_system_manager = new ParticleSystemManager(tile_layer2, 1500, Particle);
		
		var text_format:TextFormat = new TextFormat();
		text_format.align = TextFormatAlign.RIGHT;
		
		money_tf = new TextField();
		money_tf.defaultTextFormat = text_format;
		money_tf.text = "$100";
		money_tf.width = 150;
		money_tf.x = 800 - 150;
		addChild(money_tf);
		
		money = 0;
		
		time = 10;
		
		text_format = new TextFormat();
		text_format.align = TextFormatAlign.CENTER;
		
		time_tf = new TextField();
		time_tf.defaultTextFormat = text_format;
		time_tf.text = "Allies coming in " + Std.string(time);
		time_tf.width = 800;
		addChild(time_tf);
		
		overlay = new Sprite();
		overlay.graphics.beginFill(0xC8C8C8);
		overlay.graphics.drawRect(0, 0, 800, 480);
		overlay.graphics.endFill();
		overlay.alpha = 0.8;
		addChild(overlay);
		
		text_format = new TextFormat("Arial", 24);
		text_format.align = TextFormatAlign.CENTER;
		
		tf = new TextField();
		tf.defaultTextFormat = text_format;
		tf.selectable = false;
		tf.mouseEnabled = false;
		tf.width = 800;
		tf.wordWrap = true;
		tf.multiline = true;
		tf.text = "Stay alive! Allies will be here in 10 seconds!\nThey will help you to defend your planet.\nControl your ship with arrow keys and press space to shoot.";
		overlay.addChild(tf);
		
		var retry_button:Sprite = new Sprite();
		retry_button.graphics.beginFill(0x3F8B8B);
		retry_button.graphics.drawRoundRect(0, 0, 150, 50, 25);
		retry_button.graphics.endFill();
		retry_button.useHandCursor = true;
		retry_button.buttonMode = true;
		retry_button.addEventListener(MouseEvent.CLICK, onClick);
		
		text_format.size = 16;
		
		retry_tf = new TextField();
		retry_tf.defaultTextFormat = text_format;
		retry_tf.mouseEnabled = false;
		retry_tf.width = retry_button.width;
		retry_tf.height = retry_button.height;
		retry_tf.text = "Start";
		retry_tf.selectable = false;
		retry_tf.y = (retry_button.height - retry_tf.textHeight) / 2;
		
		retry_button.addChild(retry_tf);
		
		tf.x = (800 - tf.width) / 2; 
		tf.y = (380 - tf.height) / 2;
		retry_button.x = (800 - retry_button.width) / 2; 
		retry_button.y = (520 - retry_button.height) / 2;
		
		overlay.addChild(retry_button);
	}
	
	private function onClick(e:MouseEvent):Void 
	{
		restart();
	}
	
	private function onTick():Void
	{
		if (time > 0)
		{
			time--;
			time_tf.text = "Allies coming in " + Std.string(time);
		}
		else
		{
			mission_complete = true;
			
			timer.stop();
			
			enemy_manager1.setHP(300);
			enemy_manager2.setHP(800);
			enemy_manager3.setHP(350);
			
			var starting_pos_x = (800 - 16 * (36 + 10)) / 2;
			
			for (i in 0...17)
			{
				for (j in 0...7)
				{
					allies_manager.spawnAt(starting_pos_x + i * (36 + 10), 780 - j*(37+10), 400 - j*(37+10));
				}
			}
			
			starting_pos_x = (800 - 9 * (38 + 10)) / 2;
			
			for (i in 0...10)
			{
				for (j in 0...3)
				{
					enemy_manager1.spawnAt(starting_pos_x + i * (38 + 10), -150 - j*(38+10), 280);
				}
			}
			
			starting_pos_x = (800 - 4 * (114 + 10)) / 2;
			
			for (i in 0...5)
			{
				for (j in 0...5)
				{
					enemy_manager2.spawnAt(starting_pos_x + i * (114 + 10), -150 - j*(45+10), 180, 3.5);
				}
			}
			
			starting_pos_x = (800 - 9 * (54 + 10)) / 2;
			
			for (i in 0...10)
			{
				for (j in 0...5)
				{
					enemy_manager3.spawnAt(starting_pos_x + i * (54 + 10), -150 - j*(38+10), 180, 8.5);
				}
			}
			
			var timer2:Timer = new Timer(10000);
			timer2.run = function ():Void
			{
				var enemy_ships_left:Bool = false;
				
				for (i in 0...ships.length)
				{
					if (ships[i].type == 1)
					{
						enemy_ships_left = true;
						break;
					}
				}
				
				if (!enemy_ships_left)
				{
					tf.y = (380 - tf.height) / 2;
					tf.text = "Congratulations! Now planet is safe!\nThanks for playing!";
					overlay.visible = true;
				}
				
			};
			
			
		}
	}
	
	private function spawnEnemies():Void
	{
		enemy_manager1.spawnAt(38/2, -50, 200);
		enemy_manager1.spawnAt(800 - 38 / 2, -50, 300);
		
		var starting_pos_x:Float = (800 - 4 * (114 + 50)) / 2;
		
		var delay:Float = 1.5;
		enemy_manager2.spawnAt(starting_pos_x, -50, 100, delay);
		enemy_manager2.spawnAt(starting_pos_x + (114+50), -50, 100, delay);
		enemy_manager2.spawnAt(starting_pos_x + (114+50)*2, -50, 100, delay);
		enemy_manager2.spawnAt(starting_pos_x + (114+50)*3, -50, 100, delay);
		enemy_manager2.spawnAt(starting_pos_x + (114 + 50) * 4, -50, 100, delay);
		
		delay += 3;
		enemy_manager3.spawnAt(800/2, -50, 35, delay);
		//enemy_manager3.spawnAt(800/2, -50, 200, delay);
	}
	
	private function onEnterFrame(e:Event):Void 
	{
		var current_time:Int = Lib.getTimer();
		var elapsed:Int = current_time - prev_time;
		prev_time = current_time;
		
		if (!mission_complete)
		{
			player.move(0, 0);
		
			if (keys[Keyboard.LEFT]) player.move(-1, null);
			if (keys[Keyboard.RIGHT]) player.move(1, null);
			if (keys[Keyboard.UP]) player.move(null, -1);
			if (keys[Keyboard.DOWN]) player.move(null, 1);
			if (keys[Keyboard.SPACE]) player.shoot();
		}
		else
		{
			if (player.y - 450 > 15)
			{
				player.y += - 100 * elapsed / 1000;
			}
			else if (player.y - 450 < -15)
			{
				player.y += 100 * elapsed / 1000;
			}
		}
		
		var i:Int = 0;
		
		while (i < ships.length)
		{
			if (ships[i].visible)
			{
				ships[i].step(elapsed);
				i++;
			}
			else
			{
				if (ships[i].parent != null)
				{
					ships[i].parent.removeChild(ships[i]);
				}
				
				ships.splice(i, 1);
			}
		}
		
		i = 0;
		while (i < bullets.length)
		{
			var bullet = cast(bullets[i], Bullet);
			
			if (bullet.visible)
			{
				if (bullet.type == 0)
				{
					for (j in 0...Game.ships.length)
					{			
						if (Game.ships[j].type == 1)
						{
							var collide_x:Bool = Math.abs(Game.ships[j].x - bullet.x) < (Game.ships[j].width / 2 + bullet.width / 2);
							var collide_y:Bool = Math.abs(Game.ships[j].y - bullet.y) < (Game.ships[j].height / 2 + bullet.height / 2);
							
							if (collide_x && collide_y)
							{
								bullet.visible = false;
								Game.ships[j].hit(bullet.damage);
							}
						}
					}
				}
				else
				{
					var collide_x:Bool = Math.abs(Game.player.x - bullet.x) < (Game.player.width / 2 + bullet.width / 2);
					var collide_y:Bool = Math.abs(Game.player.y - bullet.y) < (Game.player.height / 2 + bullet.height / 2);
					
					if (collide_x && collide_y && Game.player.visible)
					{
						bullet.visible = false;
						Game.player.hit(bullet.damage);
					}
					for (j in 0...Game.ships.length)
					{
						if (Game.ships[j].type == 0)
						{
							var collide_x:Bool = Math.abs(Game.ships[j].x - bullet.x) < (Game.ships[j].width / 2 + bullet.width / 2);
							var collide_y:Bool = Math.abs(Game.ships[j].y - bullet.y) < (Game.ships[j].height / 2 + bullet.height / 2);
							
							if (collide_x && collide_y)
							{
								bullet.visible = false;
								Game.ships[j].hit(bullet.damage);
							}
						}
					}
				}
				
				bullet.step(elapsed);
				i++;
			}
			else
			{
				if (bullet.parent != null)
				{
					bullet.parent.removeChild(bullet);
				}
				
				bullets.splice(i, 1);
			}
		}
		
		i = 0;
		while (i < particles.length)
		{
			if (particles[i].visible)
			{
				particles[i].step(elapsed);
				i++;
			}
			else
			{
				if (particles[i].parent != null)
				{
					particles[i].parent.removeChild(particles[i]);
				}
				
				particles.splice(i, 1);
			}
		}
		
		if (player.visible) player.step(elapsed);
		
		var player_hp:Int = player.getHP();
		
		if (player_hp > 0)
		{
			progress_bar.setPercent(player.getHP() / 200);
		}
		else
		{
			progress_bar.setPercent(0);
			timer.stop();
			
			tf.y = (480 - tf.height) / 2;
			tf.text = "You can do it! Try it again!";
			overlay.visible = true;
		}
		
		money_tf.text = "$" + money;
		
		tile_layer.render(elapsed);
		
		if (particles.length > 0) tile_layer2.render(elapsed);
	}
	
	private function restart():Void
	{
		enemy_manager1.setHP(100);
		enemy_manager2.setHP(300);
		enemy_manager3.setHP(150);
		
		retry_tf.text = "Restart";
		
		mission_complete = false;
		
		overlay.visible = false;
		player.setHP(200);
		player.visible = true;
		
		player.x = 800 / 2;
		player.y = 480 * 0.85;
		
		var i:Int = 0;
		while (i < ships.length)
		{
			if (ships[i].parent != null) ships[i].parent.removeChild(ships[i]);
			ships.splice(i, 1);
		}
		
		i = 0;
		while (i < bullets.length)
		{
			if (bullets[i].parent != null) bullets[i].parent.removeChild(bullets[i]);
			bullets.splice(i, 1);
		}
		
		i = 0;
		while (i < particles.length)
		{
			if (particles[i].parent != null) particles[i].parent.removeChild(particles[i]);
			particles.splice(i, 1);
		}
		
		spawnEnemies();
		
		timer = new Timer(1000);
		timer.run = onTick;
		
		time = 10;
		time_tf.text = "Allies coming in " + Std.string(time);
	}
	
	override private function onAdded(e:Event):Void 
	{
		super.onAdded(e);
	}
	
}