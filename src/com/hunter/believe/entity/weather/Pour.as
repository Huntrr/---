package com.hunter.believe.entity.weather 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class Pour extends Weather
	{
		
		public function Pour() 
		{
			super();
			
			var x:Number = 0;
			while (x < FlxG.width * 1.75) {
				this.addEmitter(new WeatherEmitter(x, -3, 1, 2, 0x990000CC, -30, 90, 15, 0.2, 0.05));
				x += 10;
			}
			
			this.setEffects(10, 3, 0x66FFFFFF, 0.5, 0.02, 0.1);
			
			emit();
		}
		
	}

}