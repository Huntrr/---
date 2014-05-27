package com.hunter.believe.entity.Floors 
{
	import org.flixel.FlxObject;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class QuickSand extends Floor
	{
		private var staticX:Number;
		[Embed(source="../../img/quicksand.png")] private var floorPNG:Class;
		public function QuickSand(X:Number, Y:Number, ceil:Boolean = false) 
		{
			super(X, Y, ceil);
			staticX = X;
			loadGraphic(floorPNG, false, false);
			this.immovable = false;
			maxVelocity.x = 0;
			
		}
		
		override public function update():void {
			super.update();
			x = staticX;
		}
		
	}

}