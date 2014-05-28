package com.hunter.believe.entity.obstacles 
{
	import com.hunter.believe.entity.Obstacle;
	import com.hunter.believe.entity.Player;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class Rock extends Obstacle
	{
		
		[Embed(source = "../../img/bottomblock.png")] private var rockPNG:Class;
		public function Rock(X:Number, Y:Number) 
		{
			super(X, Y, false);
			loadGraphic(rockPNG, false, true);
			locate();
			
			//set real collision box
			setBoundary(14, 21, 5, 3);
		}
		
		override public function collide(player:Player):void {
			//do nothing
		}
		
	}

}