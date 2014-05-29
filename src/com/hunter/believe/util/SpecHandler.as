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
			   getWeather() - (animated sprite (?) for weather)
			   monsterVelocity() - (higher at higher levels)
			   monsterDist() - (lower at higher levels)
			   controlsReversed() - (ehhh)
			 */
		
		
			 
		public static function doubleJumpFail():Boolean {
			var likelihood:Number = 0;
			if (FlxG.level > 4) {
				likelihood = Math.min(FlxG.level - 3, 24) / 24;
			}
			
			return FlxG.random() < likelihood;
		}
		
		public static function jumpFail():Boolean {
			var likelihood:Number = 0;
			if (FlxG.level > 7) {
				likelihood = Math.min(FlxG.level - 6, 25) / 25;
			}
			
			return FlxG.random() < likelihood;
		}
		
		public static function getUp():Boolean {
			var likelihood:Number = 0;
			if (FlxG.level > 9) {
				likelihood = 0;
				return FlxG.random() < likelihood;
			}
			
			if (FlxG.level > 7) {
				likelihood = 0.03;
				return FlxG.random() < likelihood;
			}
			
			if (FlxG.level > 5) {
				likelihood = 0.1;
				return FlxG.random() < likelihood;
			}
			
			if (FlxG.level > 4) {
				likelihood = 0.15;
				return FlxG.random() < likelihood;
			}
			
			if (FlxG.level > 2) {
				likelihood = 0.25;
				return FlxG.random() < likelihood;
			}
			
			if (FlxG.level > 0) {
				likelihood = 0.5;
				return FlxG.random() < likelihood;
			}
			
			return true;
		}
		
		public static function canQuickSand():Boolean {
			if(FlxG.level > 0) {
				return true;
			}
			
			return false;
		}
		
		public static function solidQuickSand():Boolean {
			if(FlxG.level > 2) {
				var likelihood:Number = 0.2;
				return FlxG.random() < likelihood;
			} else if (FlxG.level == 1) {
				return true;
			}
			
			return false;
		}
		
		public static function fallingFloor():Boolean {
			var likelihood:Number = 0;
			if(FlxG.level > 8) {
				likelihood = 0.8;
				return FlxG.random() < likelihood;
			}
			
			if(FlxG.level > 5) {
				likelihood = 0.3;
				return FlxG.random() < likelihood;
			}
			
			if(FlxG.level > 3) {
				likelihood = 0.2;
				return FlxG.random() < likelihood;
			}
			
			if(FlxG.level > 2) {
				likelihood = 0.1;
				return FlxG.random() < likelihood;
			}
			
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
			var x:Number = FlxG.level;
			var y:Number = x * 0.2 + 45;
			return y;
		}
		
		public static function monsterDist():Number {
			var x:Number = FlxG.level;
			var y:Number = 900 - x * 20;
			if (y < 500) {
				y = 500;
			}
			return y;
		}
		
		private static var reverse:Boolean = false;
		private static var lastPicked:int = 0;
		public static function controlsReversed():Boolean {
			if (FlxG.level != lastPicked) {
				lastPicked = FlxG.level;
				reverse = false;
				var likelihood:Number = 0.75;
				if (FlxG.level > 8) {
					likelihood = 0.75;
					reverse =  FlxG.random() < likelihood;
				} else if (FlxG.level > 6) {
					likelihood = 0.5;
					reverse =  FlxG.random() < likelihood;
				}
			}
			return reverse;
		}
		
		private static var levelSizes:Array = [750, 1000, 1000, 1250, 1500, 1500, 1750, 1750, 2000, 2000, 2000, 2200, 2400, 2500];
		public static function levelLength():Number {
			if (FlxG.level < levelSizes.length) {
				return levelSizes[FlxG.level];
			}
			
			var x:Number = FlxG.level;
			var y:Number = (x - 12) * 100 + 2500;
			return y;
		}
		
	}

}