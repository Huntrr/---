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
		
		private var particleWidth:int;
		private var particleHeight:int;
		private var particleColor:uint;
		private var life:Number;
		private var particleDelta:Number;
		
		public function WeatherEmitter(X:Number = 0, Y:Number = 0, width:int = 1, height:int = 1, color:uint = 0xFFFFFFFF, xspeed:Number = 10, yspeed:Number = 10, delta:Number = 0, speed:Number = 0.2, timeDelta:Number = 0) 
		{
			super(X, Y);
			relX = X;
			relY = Y;
			
			particleWidth = width;
			particleHeight = height;
			particleColor = color;
			frequency = speed;
			
			setXSpeed(xspeed - delta, xspeed + delta);
			setYSpeed(yspeed - delta, yspeed + delta);
			
			var steps:Number = 0;
			if (Math.abs(xspeed) > Math.abs(yspeed) && xspeed > 0) {
				//x is determining
				if (xspeed < 0) {
					steps = X / (xspeed - delta);
				} else {
					steps = (FlxG.width - X) / (xspeed - delta);
				}
			} else {
				//y is determining
				if (yspeed < 0) {
					steps = Y / (yspeed - delta);
				} else if (yspeed > 0) {
					steps = (FlxG.height - Y) / (yspeed - delta);
				}
			}
			
			if (steps < 0) {
				steps = 0;
			}
			
			particleDelta = timeDelta;
			
			life = (steps) + 1;
		}
		
		override public function start(Explode:Boolean = false, Lifespan:Number = 0, Frequency:Number = 0.1, Quantity:uint = 0):void {
			var freq:Number = frequency + (FlxG.random() * 2 * particleDelta - particleDelta);
			var particles:int = (life / freq) * 1.4;
			for(var i:int = 0; i < particles; i++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(particleWidth, particleHeight, particleColor);
				particle.exists = false;
				add(particle);
			}
			
			super.start(false, life, freq);
		}
		
	}

}