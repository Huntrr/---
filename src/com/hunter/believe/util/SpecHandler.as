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
			var likelihood:Number = 0;
			return FlxG.random() < likelihood;
		}
		
		public static function jumpFail():Boolean {
			var likelihood:Number = 0;
			return FlxG.random() < likelihood;
		}
		
		public static function getUp():Boolean {
			var likelihood:Number = 1;
			return FlxG.random() < likelihood;
		}
		
		public static function canQuickSand():Boolean {
			if(FlxG.level > 0) {
				return true;
			}
			
			return false;
		}
		
		public static function solidQuickSand():Boolean {
			var likelihood:Number = 0;
			return FlxG.random() < likelihood;
		}
		
		public static function fallingFloor():Boolean {
			var likelihood:Number = 0;
			return FlxG.random() < likelihood;
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
			var x:Number = FlxG.level;
			var y:Number = x + 48
			return y;
		}
		
		public static function monsterDist():Number {
			var x:Number = FlxG.level;
			var y:Number = 900 - x;
			return y;
		}
		
		public static function controlsReversed():Boolean {
			return false;
		}
		
		private static var levelSizes:Array = [750, 1000, 1000, 1250, 1250];
		public static function levelLength():Number {
			if (FlxG.level < levelSizes.length) {
				return levelSizes[FlxG.level];
			}
			
			var x:Number = FlxG.level;
			var y:Number = x + 1500;
			return y;
		}
		
	}

}