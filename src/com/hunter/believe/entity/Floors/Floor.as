package com.hunter.believe.entity.Floors 
{
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class Floor extends FlxSprite
	{
		[Embed(source="../../img/floor.png")] private var floorPNG:Class;
		
		public function Floor(X:Number, Y:Number, ceil:Boolean = false) 
		{
			super(X, Y);
			loadGraphic(floorPNG, false, false);
			solid = (ceil ? FlxObject.CEILING : FlxObject.FLOOR);
			this.immovable = true;
		}
		
	}

}