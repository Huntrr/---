package com.hunter.believe.entity.weather 
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxParticle;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class WeatherEmitter extends FlxEmitter
	{
		public var relX:Number = 0;
		public var relY:Number = 0;
		
		private var particleSize:int;
		private var particleColor:uint;
		private var life:Number;
		
		public function WeatherEmitter(X:Number, Y:Number, size:int, color:uint, xspeed:Number, yspeed:Number, delta:Number, speed:Number) 
		{
			super(X, Y);
			relX = X;
			relY = Y;
			
			particleSize = size;
			particleColor = color;
			frequency = speed;
			
			setXSpeed(xspeed - delta, xspeed + delta);
			setYSpeed(yspeed - delta, yspeed + delta);
			
			var slowestX:Number = xspeed - delta;
			var slowestY:Number = yspeed - delta;
			
			var steps:Number = 0;
			if (Math.abs(xspeed) > Math.abs(yspeed) && xspeed > 0) {
				//x is determining
				if (xspeed < 0) {
					steps = X / xspeed;
				} else {
					steps = (FlxG.width - X) / xspeed;
				}
			} else {
				//y is determining
				if (yspeed < 0) {
					steps = Y / yspeed;
				} else if (yspeed > 0) {
					steps = (FlxG.height - Y) / yspeed;
				}
			}
			
			if (steps < 0) {
				steps = 0;
			}
			
			life = (steps / FlxG.framerate) + 1;
		}
		
		override public function start(Explode:Boolean = false, Lifespan:Number = 0, Frequency:Number = 0.1, Quantity:uint = 0):void {
			var particles:int = life / frequency;
			for(var i:int = 0; i < particles; i++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(particleSize, particleSize, particleColor);
				particle.exists = false;
				add(particle);
			}
			
			super.start(false, life, frequency);
		}
		
	}

}