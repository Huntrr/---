package com.hunter.believe.util 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class PlaySound 
	{
		[Embed(source = "../sound/coin.mp3")] private static var coinSound:Class;
		[Embed(source = "../sound/death.mp3")] private static var deathSound:Class;
		[Embed(source = "../sound/finish.mp3")] private static var finishSound:Class;
		[Embed(source = "../sound/jump.mp3")] private static var jumpSound:Class;
		[Embed(source = "../sound/land.mp3")] private static var landSound:Class;
		[Embed(source = "../sound/loop.mp3")] private static var loopSound:Class;
		[Embed(source = "../sound/win.mp3")] private static var winSound:Class;
		[Embed(source = "../sound/space.mp3")] private static var spaceSound:Class;
		[Embed(source = "../sound/trip.mp3")] private static var tripSound:Class;
		[Embed(source = "../sound/slip.mp3")] private static var slipSound:Class;
		
		private static var volume:Number = 0.75
		
		public static function coin():void {
			FlxG.play(coinSound, volume); 
		}
		public static function death():void {
			FlxG.play(deathSound, volume); 
		}
		public static function finish():void {
			FlxG.play(finishSound, volume); 
		}
		public static function jump():void {
			FlxG.play(jumpSound, volume); 
		}
		public static function land():void {
			FlxG.play(landSound, volume); 
		}
		public static function win():void {
			FlxG.play(winSound, volume); 
		}
		public static function space():void {
			FlxG.play(spaceSound, volume); 
		}
		public static function trip():void {
			FlxG.play(tripSound, volume); 
		}
		public static function slip():void {
			FlxG.play(slipSound, volume); 
		}
		
	}

}