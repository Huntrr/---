package com.hunter.believe.entity 
{
	import com.hunter.believe.entity.floors.Floor;
	import com.hunter.believe.util.PlaySound;
	import com.hunter.believe.util.SpecHandler;
	import flash.events.TimerEvent;
	import org.flixel.FlxBasic;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxObject;
	import org.flixel.FlxParticle;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxTileblock;
	import org.flixel.FlxTimer;
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class Player extends FlxSprite
	{
		[Embed(source = "../img/player.png")] private var playerPNG:Class;
		
		private var jumping:Boolean = false;
		private var doubleJumped:Boolean = false;
		private var dead:Boolean = false;
		private var canGetUp:Boolean = true;
		private var fallTimer:FlxTimer;
		private var win:Boolean = false;
		private var moved:Boolean = false;
		
		private var blockLast:Floor;
		
		public function Player():void {
			super();
			fallTimer = new FlxTimer();
			fallTimer.start(0.01);
			
			maxVelocity.x = 50;
			maxVelocity.y = 200;
			acceleration.y = 200;
			drag.x = maxVelocity.x * 4;
			
			
			loadGraphic(playerPNG, true, true, 26, 30, true);
			addAnimation("idle", [0, 1, 2, 3], 2, true); 
			addAnimation("run", [7, 8, 9], 5, true); 
			addAnimation("jump", [14], 10, false); 
			addAnimation("jumping", [15, 16, 17, 18], 5, true); 
			addAnimation("fall", [21, 22, 23, 24], 3, false); 
			addAnimation("stand", [25, 26, 27], 3, false); 
			
			//play("idle", true);
			
			x = 10;
			y = FlxG.height / 2 + this.height / 2;
			
			//change collision boundary
			height = 29;
			offset.y = 1;
			width = 9;
			offset.x = 5;
			
		}
		
		public function get fallen():Boolean {
			return animation == "fall";
		}
		public function get standing():Boolean {
			return animation == "stand";
		}
		
		override public function update():void {
			super.update();
			
			//Status
			if (isTouching(FlxObject.FLOOR)) {
				if (jumping) {
					PlaySound.land();
				}
				jumping = false;
				doubleJumped = false;
			} else {
				if (finished || !_curAnim) {
					play("jumping");
				}
			}
			
			//Controls
			acceleration.x = 0;
			if(!fallen && !standing && !dead) {
				if ((!SpecHandler.controlsReversed() && (FlxG.keys.LEFT || FlxG.keys.A)) || (SpecHandler.controlsReversed() && (FlxG.keys.RIGHT || FlxG.keys.D))) {
					if (facing == FlxObject.RIGHT) {
						facing = FlxObject.LEFT;
						offset.x = 13;
						x -= 5;
					}
					moved = true;
					acceleration.x = (x - FlxG.camera.scroll.x > width) ? -maxVelocity.x * 4 : 0;
					if(isTouching(FlxObject.FLOOR))
						play("run");
				}
				if ((!SpecHandler.controlsReversed() && (FlxG.keys.RIGHT || FlxG.keys.D)) || (SpecHandler.controlsReversed() && (FlxG.keys.LEFT || FlxG.keys.A))) {
					if (facing == FlxObject.LEFT) {
						facing = FlxObject.RIGHT;
						x += 5;
						offset.x = 5;
					}
					moved = true;
					acceleration.x = maxVelocity.x * 4;
					if(isTouching(FlxObject.FLOOR))
						play("run");
				}
				if (acceleration.x == 0) {
					if(isTouching(FlxObject.FLOOR))
						play("idle");
				}
				
				if (FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("W")) {
					moved = true;
					if (isTouching(FlxObject.FLOOR)) {
						
						velocity.y = -maxVelocity.y / 2;
						play("jump", true);
						jumping = true;
						PlaySound.jump();
						if (SpecHandler.jumpFail()) {
							//TRIP
							fall(true, false, true);
						}
					} else if (!doubleJumped) {
						play("jump", true);
						doubleJumped = true;
						velocity.y = -maxVelocity.y / 2;
						PlaySound.jump();
						if (SpecHandler.doubleJumpFail()) {
							//TRIP
							fall(true, false, true);
						}
					}
				}
			} else if(fallen) {
				if (finished) {
					if (!dead && canGetUp && fallTimer.finished) {
						var time:Number = Math.floor(FlxG.random() * 3 + 1);
						
						fallTimer.start(time, 1, stand);
					}
				}
			} else if (standing) {
				if (finished) {
					play("idle");
				}
			}
			
			if (FlxG.keys.justPressed("SPACE")) {
				FlxG.shake(0.01, 0.25);
				PlaySound.space();
				FlxG.camera.flash(0x990000AA, 0.25);
				
				if (SpecHandler.getUp()) {
					if (fallen) {
						fallTimer.stop();
						play("stand", true);
					}
				}
			}
			
			
			
			//Camera
			if (lastBlock) {
				if (isTouching(FlxObject.FLOOR)) {
					FlxG.levels[0] = lastBlock.y - FlxG.height + 5;
				}
			}
		}
		
		public function get animation():String {
			return _curAnim ? _curAnim.name : "none";
		}
		
		public function die(anim:Boolean = true ):void {
			if (!dead && anim) {
				PlaySound.death();
				fall(false);
				FlxG.flash(0x88FF0000, 2);
			}
			
			if (!anim) {
				play("idle", true);
				win = true;
				dead = false;
			}
			dead = true;
		}
		
		public function hasWon():Boolean {
			return win;
		}
		
		public function hasMoved():Boolean {
			//basic check to see if the player has moved
			return moved;
		}
		
		public function fall(getUp:Boolean = true, noise:Boolean = true, altNoise:Boolean = false):void {
			if (canGetUp) {
				if(animation != "fall" && noise) {
					PlaySound.trip();
				} else if (animation != "fall" && altNoise) {
					PlaySound.slip();
				}
				velocity.y = -maxVelocity.y / 3;
			}
			play("fall", true);
			FlxG.shake(0.025, 0.5);
			FlxG.flash(0x88FF0000, 0.5);
			canGetUp = getUp;
			
		}
		public function stand(e:FlxTimer):void {
			e.stop();
			play("stand", true);
			dead = false;
		}
		
		public function isDead():Boolean { 
			return dead;
		}
		
		public function set lastBlock(block:Floor):void {
			blockLast = block;
		}
		
		public function get lastBlock():Floor {
			return blockLast
		}
	}

}