package com.hunter.believe.entity.floors 
{
	import com.hunter.believe.entity.Player;
	import org.flixel.FlxObject;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class QuickSand extends Floor
	{
		
		[Embed(source="../../img/quicksand.png")] private var floorPNG:Class;
		public function QuickSand(X:Number, Y:Number, ceil:Boolean = false, sol:Boolean = false) 
		{
			super(X, Y, ceil, sol);
			loadGraphic(floorPNG, false, false);
		}
		
		override public function collide(player:Player):void {
			//do nothing
		}
		
	}

}