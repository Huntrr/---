package com.hunter.believe.util 
{
	import com.hunter.believe.entity.Obstacle;
	import com.hunter.believe.entity.obstacles.LowBlock;
	import com.hunter.believe.entity.obstacles.MidBlock;
	import com.hunter.believe.entity.obstacles.Rock;
	import com.hunter.believe.entity.obstacles.Spike;
	import com.hunter.believe.entity.obstacles.TopBlock;
	import com.hunter.believe.entity.obstacles.TopBlockAlt;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class ObsPicker 
	{
		public static function getObstable(x:Number, y:Number):Array {
			var NUM:int = 5;
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
					if(FlxG.random() < 0.5) {
						obj = new TopBlock(x, y);
					} else {
						obj = new TopBlockAlt(x, y);
					}
					size = 2;
					break;
				
				case 4:
					obj = new LowBlock(x, y);
					size = 8;
					break;
				
				case 5:
					obj = new Spike(x, y);
					size = 3;
					break;
				
				default:
					obj = new Rock(x, y);
					size = 5;
			}
			
			return [obj, size];
		}
		
	}

}