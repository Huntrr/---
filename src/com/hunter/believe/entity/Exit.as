package com.hunter.believe.entity 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class Exit extends Obstacle
	{
		[Embed(source = "../img/door.png")] private var exitPNG:Class;
		
		public function Exit(X:Number, Y:Number) 
		{
			loadGraphic(exitPNG);
			x = X + width / 2;
			y = FlxG.camera.scroll.y;
			var oldHeight:Number = height;
			height = FlxG.height;
			offset.y = -(Y - oldHeight) + FlxG.camera.scroll.y;
			offset.x = width / 3;
			
		}
		
		override public function collide(player:Player):void {
			if(!player.isDead()) {
				FlxG.level = FlxG.level + 1;
				FlxG.camera.flash();
				player.die(false);
			}
		}
		
	}

}