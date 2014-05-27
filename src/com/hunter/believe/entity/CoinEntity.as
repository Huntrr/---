package com.hunter.believe.entity 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class CoinEntity extends FlxSprite
	{
		private var group:Coin;
		public function CoinEntity(myGroup:Coin) 
		{
			allowCollisions = FlxObject.OVERLAP_BIAS;
			makeGraphic(1, 2, 0xFF00FF00, true);
			immovable = true;
			group = myGroup;
		}
		
		public function getGroup():Coin {
			return group;
		}
		
	}

}