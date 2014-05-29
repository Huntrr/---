package com.hunter.believe.util 
{
	import com.hunter.believe.entity.weather.Drizzle;
	import com.hunter.believe.entity.weather.Pour;
	import com.hunter.believe.entity.weather.Rain;
	import com.hunter.believe.entity.weather.Snow;
	import com.hunter.believe.entity.weather.Storm;
	import com.hunter.believe.entity.weather.Weather;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class SpecHandler 
	{
		
		/* Variables to handle:
			   doubleJumpFail() - (computes probability based on level, higher level = higher chance)
			   jumpFail() - (computes probability based on level, higher level = higher chance)
			   getUp() - (computes probability of SPACE working, higher level = lower chance)
			   canQuickSand() - (true or false based on availability of quick sand)
			   solidQuickSand() - (more true more often at higher levels)
			   fallingFloor() - (more true more often at higher levels - for regular flooring)
	! UNUSED ! getWeather() - (animated sprite (?) for weather)
			   monsterVelocity() - (higher at higher levels)
			   monsterDist() - (lower at higher levels)
			   controlsReversed() - (ehhh)
			 */
		
		public static function doubleJumpFail():Boolean {
			return false;
		}
		
		public static function jumpFail():Boolean {
			return false;
		}
		
		public static function getUp():Boolean {
			return true;
		}
		
		public static function canQuickSand():Boolean {
			return true;
		}
		
		public static function solidQuickSand():Boolean {
			return false;
		}
		
		public static function fallingFloor():Boolean {
			return false;
		}
		
		public static function getWeather():Weather {
			var weather:Weather = new Weather();
			
			if (FlxG.level > 0) {
				//new weather effect
				if (FlxG.level < 2) {
					weather = new Snow();
				} else if (FlxG.level < 4) {
					weather = new Drizzle();
				} else if (FlxG.level < 6) {
					weather = new Rain();
				} else if (FlxG.level < 8) {
					weather = new Pour();
				} else {
					weather = new Storm();
				}
			}
			return weather;
		}
		
		public static function monsterVelocity():Number {
			return 48;
		}
		
		public static function monsterDist():Number {
			return 900;
		}
		
		public static function controlsReversed():Boolean {
			return false;
		}
		
	}

}