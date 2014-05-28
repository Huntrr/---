package com.hunter.believe
{
	import com.hunter.believe.entity.Level;
	import com.hunter.believe.entity.Player;
	import com.hunter.believe.entity.SmokeMonster;
	import com.hunter.believe.util.SpecHandler;
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		/* TODO LIST:
			 * Level up-difficulties:
				 * 1 normal
				 * 2 normal
				 * 3 random no double jump
				 * 4 random broken jump ((allow space -> get up))
				 * 5 more random broken jump
				 * 6 broken jump
			 * Obstacles:
				 * different floors (quick sand (sometimes solid?? sometimes reg floor unsolid?) and hole)
				 * wall
			 * Decorative:
				 * Background
				 * Weather (progressively worse)
				 * Sounds:
					 * Death
					 * Fall
					 * Jump
					 * Land
					 * Win
					 * Coin
					 * MUSIC
		*/
		//CONST
		private static const OFFSET:Number = 75;
		
		//Actual objects
		private var playerEmitter:FlxEmitter;
		private var player:Player;
		private var monster:SmokeMonster;
		private var level:Level;
		
		//Overlays/HUD
		private var progress:FlxText;
		private var lvl:FlxText;
		private var warning:FlxText;
		private var blinkTimer:int = 0;
		
		private var oldScore:int;
		
		override public function create():void
		{
			FlxG.levels[0] = 0;
			oldScore = FlxG.score;
			//Init games
			FlxG.framerate = 30;
			FlxG.flashFramerate = 30;
			FlxG.bgColor = 0xFF280001;		
			
			//Add objects
			level = new Level();
			add(level);
			
			player = new Player();
			player.x = OFFSET;
			add(player);			
			
			monster = new SmokeMonster();
			monster.setX(player.x - SpecHandler.monsterDist());
			add(monster);
			
			playerEmitter = new FlxEmitter(100, 100);
			emit();
			
			//Add HUD
			progress = new FlxText(0, 0, FlxG.width);
			progress.alignment = "center";
			progress.shadow = 0xFF000000;
			updateProgress();
			add(progress);
			
			lvl = new FlxText(0, FlxG.height - 12, FlxG.width, "" + FlxG.level);
			lvl.alignment = "right";
			lvl.shadow = 0xFF000000;
			add(lvl);
			
			warning = new FlxText(0, FlxG.height / 2 - 5, FlxG.width);
			warning.alignment = "center";
			warning.shadow = 0xFF000000;
			warning.color = 0xFF00FF00;
			add(warning);
			warning.text = "[<] [^] [>]";
			warning.exists = true;
			
		}
		
		override public function update():void {
			super.update();
			//handle the emitter
			playerEmitter.x = player.facing == FlxObject.RIGHT ? player.x + 14 : player.x - 9;
			playerEmitter.y = player.y + 9;
			if (player.animation == "fall" || player.animation == "stand") {
				playerEmitter.on = false;
			} else {
				playerEmitter.on = true;
			}
			
			//direct the monster
			monster.direct(player.x, player.y);
			
			//handle collisions
			FlxG.overlap(monster, player, monster.collide);
			FlxG.overlap(level, player, level.collide);
			
			FlxG.collide(level.floor, player);
			FlxG.collide(level.ceiling, player);
			FlxG.collide(level.obstacles, player);
			
			if (player.y > FlxG.height) {
				player.die();
			}
			
			//camerawork
			var camX:Number = player.x - OFFSET;
			FlxG.camera.scroll.x = Math.max(FlxG.camera.scroll.x, camX);
			progress.x = FlxG.camera.scroll.x;
			warning.x = FlxG.camera.scroll.x;
			lvl.x = FlxG.camera.scroll.x;
			
			FlxG.camera.scroll.y = FlxG.camera.scroll.y + (FlxG.levels[0] - FlxG.camera.scroll.y) / 3
			progress.y = FlxG.camera.scroll.y;
			warning.y = FlxG.camera.scroll.y + FlxG.height / 2 - 5;
			lvl.y = FlxG.camera.scroll.y + FlxG.height - 12;
			
			FlxG.worldBounds = new FlxRect(FlxG.camera.scroll.x, FlxG.camera.scroll.y, FlxG.width, FlxG.height * 2);
			
			//update progress
			updateProgress();
			
			if (player.fallen) {
				warning.exists = true;
				if (!player.isDead()) {
					warning.color = 0xFFFF0000;
					warning.text = "!! [SPACE] !!";
					blinkTimer--;
					if (blinkTimer < 0) {
						warning.visible = true;
					} else {
						warning.visible = false;
					}
					if (blinkTimer < -10) {
						blinkTimer = 10;
					}
				} else {
					warning.visible = true;
					warning.color = 0xFFFF0000;
					warning.text = "X [X] X";
				}
			} else if(!player.isDead() && player.hasMoved()) {
				warning.exists = false;
			} else if(player.hasWon()) {
				//has won
				monster.kill();
				warning.exists = true;
				warning.color = 0xFF00FF00;
				warning.text = "!! [X] !!";
			}
			
			//Exit or restart stuffs
			if (FlxG.keys.ESCAPE || FlxG.keys.BACKSPACE) {
				FlxG.fade(0xFF000000, 1, FlxG.resetGame);
			}
			
			if (FlxG.keys.justPressed("X") || FlxG.keys.justPressed("SPACE")) {
				if (player.isDead()) {
					if (!player.hasWon()) {
						FlxG.score = oldScore;
					}
					FlxG.fade(0xFF000000, 1, FlxG.resetState);
				}
			}
		}
		
		private function emit():void {
			var particles:int = 10;
			for(var i:int = 0; i < particles; i++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(1, 1, 0xCC44CC00);
				particle.exists = false;
				playerEmitter.add(particle);
			}
			 
			add(playerEmitter);
			playerEmitter.setXSpeed(-10, 10);
			playerEmitter.setYSpeed(-10, 10);
			playerEmitter.start(false, 0.5, 0.1, 0);
		}
		
		private function updateProgress():void {
			var dist:int = Math.ceil((Math.abs(monster.getX() - player.x) / SpecHandler.monsterDist()) * 10);
			var distLeft:int = Math.floor(((player.x - OFFSET) / level.size()) * 100);
			progress.text = "" + dist + " | " + (distLeft < 100 ? distLeft : 100) + "% | " + FlxG.score;
			
			if (dist > 5)
				progress.color = 0xFFFFFFFF;
			else if (dist > 3)
				progress.color = 0xFFFFAAAA;
			else if (dist > 2) 
				progress.color = 0xFFFF8888;
			else if (dist > 1)
				progress.color = 0xFFFF4444;
			else 
				progress.color = 0xFFFF1111;
		}
	}
}