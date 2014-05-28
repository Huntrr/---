package com.hunter.believe.entity.obstacles 
{
	import com.hunter.believe.entity.Obstacle;
	import com.hunter.believe.entity.Player;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class MidBlock extends Obstacle
	{
		
		[Embed(source = "../../img/midblock.png")] private var blockPNG:Class;
		public function MidBlock(X:Number, Y:Number) 
		{
			super(X, Y, false);
			loadGraphic(blockPNG, false, true);
			locate();
			setBoundary(11, height, 4);
		}
		
		override public function collide(player:Player):void {
			super.collide(player);
		}
	}

}