package com.hunter.believe.entity.weather 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class Drizzle extends Weather
	{
		
		public function Drizzle() 
		{
			super();
			
			var x:Number = 0;
			while (x < FlxG.width * 1.5) {
				this.addEmitter(new WeatherEmitter(x, -3, 1, 1, 0x990000CC, 0, 50, 5, 0.7, 0.2));
				x += 10;
			}
			
			emit();
		}
		
	}

}