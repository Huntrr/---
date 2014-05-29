package com.hunter.believe.util 
{
	import com.hunter.believe.entity.Obstacle;
	import com.hunter.believe.entity.obstacles.MidBlock;
	import com.hunter.believe.entity.obstacles.Rock;
	import com.hunter.believe.entity.obstacles.TopBlock;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class ObsPicker 
	{
		public static function getObstable(x:Number, y:Number):Array {
			var NUM:int = 3;
			var rand:int = Math.floor(FlxG.random() * NUM + 1);
			var obj:Obstacle;
			var size:int = 0;
			switch(rand) {
				case 1:
					obj = new Rock(x, y);
					size = 5;
					break;
				
				case 2:
					obj = new MidBlock(x, y);
					size = 5;
					break;
				
				case 3:
					obj = new TopBlock(x, y);
					size = 2;
					break;
				
				default:
					obj = new Rock(x, y);
					size = 5;
			}
			
			return [obj, size];
		}
		
	}

}