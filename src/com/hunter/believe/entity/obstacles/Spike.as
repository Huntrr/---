package com.hunter.believe.entity.obstacles 
{
	import com.hunter.believe.entity.Obstacle;
	import com.hunter.believe.entity.Player;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class Spike extends Obstacle
	{
		
		[Embed(source = "../../img/spike.png")] private var blockPNG:Class;
		
		private var curY:Number = 0;
		private var maxY:Number;
		private var goingUp:Boolean = true;
		private var origY:Number;
		
		private static const SPEED:Number = 1.5;
		
		public function Spike(X:Number, Y:Number) 
		{
			super(X, Y, false);
			loadGraphic(blockPNG, false, true);
			locate();
			maxY = FlxG.height - height - 28;
			y -= 4;
			origY = this.y;
			curY = FlxG.random() * maxY;
			setBoundary(width - 4, height - 4, 2, 2);
		}
		
		override public function update():void {
			if (goingUp) {
				if (curY < maxY) {
					curY += SPEED;
				} else {
					goingUp = false;
				}
			} else {
				if (curY >= 0) {
					curY -= SPEED;
				} else {
					goingUp = true;
				}
			}
			
			y = origY - curY;
		}
		
		override public function collide(player:Player):void {
			super.collide(player);
			FlxG.shake(0.025, 0.3);
			player.x += width - (player.x - x);
		}
	}

}