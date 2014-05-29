package com.hunter.believe.entity.weather 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class Storm extends Weather
	{
		
		public function Storm() 
		{
			super();
			
			var x:Number = 0;
			while (x < FlxG.width * 1.75) {
				this.addEmitter(new WeatherEmitter(x, -3, 1, 2, 0x990000CC, -35, 95, 20, 0.2, 0.05));
				x += 10;
			}
			
			this.setEffects(6, 3, 0x66FFFFFF, 0.7, 0.06, 0.1);
			
			emit();
		}
		
	}

}