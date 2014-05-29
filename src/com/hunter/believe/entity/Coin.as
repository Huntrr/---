package com.hunter.believe.entity 
{
	import com.hunter.believe.util.PlaySound;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class Coin extends FlxGroup
	{
		public var coin:CoinEntity;
		public var emitter:FlxEmitter;
		
		public function Coin(X:int, Y:int) 
		{
			coin = new CoinEntity(this);
			coin.x = X - 5;
			coin.y = Y - 5;
			add(coin);
			
			emitter = new FlxEmitter();
			add(emitter);
			emit();
		}
		
		private function emit():void {
			var particles:int = 10;
			for(var i:int = 0; i < particles; i++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(1, 1, 0xFFAAFF00);
				particle.exists = false;
				emitter.add(particle);
			}
			 
			emitter.setXSpeed(-10, 10);
			emitter.setYSpeed( -10, 10);
			emitter.at(coin);
			emitter.start(false, 0.75, 0.2, 0);
		}
		
		public function collide(player:Player):void {
			FlxG.camera.flash(0x9944FF00, 0.25, null, true);
			PlaySound.coin();
			FlxG.score = FlxG.score + 1;
			kill();
		}
	}

}