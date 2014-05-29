package com.hunter.believe.entity.weather 
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxTimer;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class Weather extends FlxGroup
	{
		private var emitters:Array;
		private var timer:FlxTimer;
		private var shakeIntensity:Number = 0;
		private var shakeDuration:Number = 0;
		private var flashColor:uint = 0x00000000;
		private var flashDuration:Number = 0;
		
		public function Weather() 
		{
			super();
			timer = new FlxTimer();
			emitters = new Array();
		}
		
		override public function update():void {
			super.update();
			
			var len:int = emitters.length;
			for (var i:int = 0; i < len; i++) {
				(emitters[i] as WeatherEmitter).x = FlxG.camera.scroll.x + (emitters[i] as WeatherEmitter).relX;
				(emitters[i] as WeatherEmitter).y = FlxG.camera.scroll.y + (emitters[i] as WeatherEmitter).relY;
			}
		}
		
		public function addEmitter(emit:WeatherEmitter):void {
			emitters.push(emit);
		}
		
		public function setEffectTimer(time:Number):void {
			timer.stop();
			timer.start(time, 1, fireEffects);
		}
		
		public function setShake(intensity:Number, duration:Number):void {
			shakeIntensity = intensity;
			shakeDuration = duration;
		}
		
		public function setFlash(color:uint, duration:Number):void {
			flashColor = color;
			flashDuration = duration;
		}
		
		public function setEffects(time:Number, flashCol:uint = 0x00000000, flashDur:Number = 0, shakeInt:Number = 0, shakeDur:Number = 0):void {
			setShake(shakeInt, shakeDur);
			setFlash(flashCol, flashDur);
			setEffectTimer(time);			
		}
		
		private function fireEffects(t:FlxTimer):void {
			timer.stop();
			
			//effects
			FlxG.shake(shakeIntensity, shakeDuration);
			FlxG.flash(flashColor, flashDuration);
			
			timer.start(timer.time, 1, fireEffects);
		}
		
		
		
		public function emit():void {
			for (var i:int = 0; i < emitters.length; i++) {
				add(emitters[i]);
				(emitters[i] as WeatherEmitter).start();
			}
		}
		
	}

}