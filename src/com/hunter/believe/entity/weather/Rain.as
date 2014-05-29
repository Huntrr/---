package com.hunter.believe.entity.weather 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class Rain extends Weather
	{
		
		public function Rain() 
		{
			super();
			
			var x:Number = 0;
			while (x < FlxG.width * 1.5) {
				this.addEmitter(new WeatherEmitter(x, -3, 1, 2, 0x990000CC, -20, 80, 5, 0.2, 0.05));
				x += 10;
			}
			
			emit();
		}
		
	}

}