package com.hunter.believe.entity 
{
	import com.hunter.believe.util.PlaySound;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class Exit extends FlxSprite implements Collidable
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
		
		public function collide(player:Player):void {
			if(!player.isDead()) {
				FlxG.level = FlxG.level + 1;
				FlxG.camera.flash();
				PlaySound.win();
				player.die(false);
			}
		}
		
	}

}