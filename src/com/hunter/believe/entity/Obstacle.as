package com.hunter.believe.entity 
{
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class Obstacle extends FlxSprite implements Collidable
	{
		private var onCeil:Boolean = false;
		private var origHeight:Number;
		private var origWidth:Number;
		
		public function Obstacle(X:Number, Y:Number, onCeiling:Boolean = false ) 
		{
			x = X;
			y = Y;	
			onCeil = onCeiling;
			immovable = true;
			flip(FlxG.random() > 0.5);
		}
		
		public function locate():void {
			x = x;
			if(!onCeil) {
				y = y - height;
			} else {
				y = y - FlxG.height + 12;
			}
		}
		
		public function collide(player:Player):void {
			if(!player.fallen && !player.standing) {
				player.fall();
			}
			
			//get the player off this surface
			player.velocity.y = -50;
			player.velocity.x = (player.facing == FlxObject.RIGHT ? 1 : -1) * 50;
		}
		
		public function flip(flipped:Boolean):void {
			facing = flipped ? FlxObject.RIGHT : FlxObject.LEFT;
		}
		
		public function setBoundary(w:Number, h:Number, wo:Number = 0, ho:Number = 0):void {
			if(!origHeight) {
				origHeight = height;
				origWidth = width;
			}
			
			width = w;
			height = h;
			
			offset.y = ho;
			y += ho;
			offset.x = wo;
			x += wo;
		}
	}

}