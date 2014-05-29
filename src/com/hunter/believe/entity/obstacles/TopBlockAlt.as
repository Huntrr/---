package com.hunter.believe.entity.obstacles 
{
	import com.hunter.believe.entity.Obstacle;
	import com.hunter.believe.entity.Player;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class TopBlockAlt extends Obstacle
	{
		
		[Embed(source = "../../img/topblock_alt.png")] private var blockPNG:Class;
		public function TopBlockAlt(X:Number, Y:Number) 
		{
			super(X, Y, true);
			loadGraphic(blockPNG, false, true);
			locate();
			
			setBoundary(6, height, 7);
		}
		
		override public function collide(player:Player):void {
			super.collide(player);
		}
		
	}

}