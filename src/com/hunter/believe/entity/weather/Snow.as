package com.hunter.believe.entity.weather 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class Snow extends Weather
	{
		
		public function Snow() 
		{
			super();
			
			var x:Number = 0;
			while (x < FlxG.width * 1.5) {
				this.addEmitter(new WeatherEmitter(x, -3, 1, 1, 0x99DDDDDD, 0, 20, 15, 0.7, 0.2));
				x += 10;
			}
			
			emit();
		}
		
	}

}