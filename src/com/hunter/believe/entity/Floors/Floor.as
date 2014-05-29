package com.hunter.believe.entity.floors 
{
	import com.hunter.believe.entity.Collidable;
	import com.hunter.believe.entity.Player;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class Floor extends FlxSprite implements Collidable
	{
		[Embed(source="../../img/floor.png")] private var floorPNG:Class;
		private var staticX:Number;
		public function Floor(X:Number, Y:Number, ceil:Boolean = false, sol:Boolean = true) 
		{
			super(X, Y);
			loadGraphic(floorPNG, false, false);
			staticX = X;
			this.immovable = sol;
			maxVelocity.x = 0;
			
		}
		
		override public function update():void {
			super.update();
			x = staticX;
		}
		
		public function collide(player:Player):void {
			if(this.immovable) {
				player.lastBlock = this;
			}
		}
		
	}

}