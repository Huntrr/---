package com.hunter.believe.entity 
{
	import com.hunter.believe.util.SpecHandler;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class SmokeMonster extends FlxGroup
	{
		public var monster:FlxSprite;
		public var emitter:FlxEmitter;
		
		public function SmokeMonster() 
		{
			monster = new FlxSprite(10, 10);
			monster.makeGraphic(5, 3, 0xFF000000, true);
			add(monster);
			
			emitter = new FlxEmitter();
			add(emitter);
			emit();
			
			monster.maxVelocity.x = SpecHandler.monsterVelocity();
			monster.maxVelocity.y = SpecHandler.monsterVelocity();
			monster.drag.x = monster.maxVelocity.x * 4;
			monster.drag.y = monster.maxVelocity.y * 4;
		}
		
		public function setX(newX:Number):void {
			monster.x = newX;
		}
		public function getX():Number {
			return monster.x;
		}
		
		public function direct(toX:Number, toY:Number):void {
			if (toX > monster.x) {
				monster.acceleration.x = monster.maxVelocity.x * 4;
			} else {
				monster.acceleration.x = -monster.maxVelocity.x * 4;
			}
			
			if (toY > monster.y) {
				monster.acceleration.y = monster.maxVelocity.y * 4;
			} else {
				monster.acceleration.y = -monster.maxVelocity.y * 4;
			}
		}
		
		override public function update():void {
			super.update();
			emitter.at(monster);
		}
		
		private function emit():void {
			var particles:int = 50;
			for(var i:int = 0; i < particles; i++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(2, 2, 0xFF000000);
				particle.exists = false;
				emitter.add(particle);
			}
			 
			emitter.setXSpeed(-10, 10);
			emitter.setYSpeed( -10, 10);
			
			emitter.start(false, 0.75, 0.018, 0);
		}
		
		public function collide(monster:FlxSprite, player:FlxSprite):void {
			(player as Player).die();
		}
	}

}