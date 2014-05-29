package com.hunter.believe.entity.obstacles 
{
	import com.hunter.believe.entity.Obstacle;
	import com.hunter.believe.entity.Player;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class LowBlock extends Obstacle
	{
		
		[Embed(source = "../../img/lava.png")] private var blockPNG:Class;
		public function LowBlock(X:Number, Y:Number) 
		{
			super(X, Y, false);
			loadGraphic(blockPNG, false, true);
			locate();
			setBoundary(width - 4, height, 2);
		}
		
		override public function collide(player:Player):void {
			super.collide(player);
		}
	}

}