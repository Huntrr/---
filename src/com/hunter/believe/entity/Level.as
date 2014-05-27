package com.hunter.believe.entity 
{
	import com.hunter.believe.entity.Floors.Floor;
	import com.hunter.believe.entity.Floors.QuickSand;
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Hunter Lightman
	 */
	public class Level extends FlxGroup
	{
		
		public var floor:FlxGroup;
		public var ceiling:FlxGroup;
		private var coins:FlxGroup;
		public var obstacles:FlxGroup;
		private var x:Number;
		private var lastY:Number;
		private var floorTile:Floor;
		private var levelSizes:Array = [750, 1000, 1000, 1250, 1250];
		private var hasExit:Boolean = false;
		
		public function Level() 
		{
			super();
			//setup floor
			x = 0;
			
			floor = new FlxGroup();
			ceiling = new FlxGroup();
			coins = new FlxGroup();
			obstacles = new FlxGroup();
			add(floor);
			add(ceiling);
			add(coins);
			add(obstacles);
			
			floorTile = new Floor(0, 0);
			lastY = FlxG.height - floorTile.height;
			while (x < FlxG.width) {
				addFloor(lastY);
			}
		}
		
		override public function update():void {
			super.update();
			//FlxG.camera.scroll.y = (lastY - FlxG.height + floorTile.height);
			
			removeOffscreen(floor);
			removeOffscreen(ceiling);
			removeOffscreen(coins);
			removeOffscreen(obstacles);
			
			if (FlxG.camera.scroll.x + FlxG.width > x - floorTile.width) {
				generateUntil(x + 100);
			}
		}
		
		private function generateUntil(next:Number):void {
			while (x < next) {
				
				if (FlxG.random() > 0.05) {
					addFloor(lastY); // flat floor
				} else {
					addFloor(lastY - Math.floor(FlxG.random() * 25 + 5)); //not so flat floor
				}
				if(x - 75 < size()) {
					var rand:Number = Math.floor(FlxG.random() * 1000);
					
					if (rand > 900) {
						addCoin(lastY - 10);
					} else if (rand > 800) {
						addCoin(lastY - (10 + Math.floor(FlxG.random() * 80)));
					} else if (rand > 400) {
						addObstacle();
					} else if (rand > 300) {
						//quicksand!
						flatFloor(lastY, Math.floor(FlxG.random() * 10 + 4), true);
					}
				} else if (!hasExit) {
					hasExit = true;
					addExit();
				}
			}
		}
		
		public function collide(obj:FlxSprite, player:FlxSprite):void {
			if (obj is CoinEntity) {
				(obj as CoinEntity).getGroup().collide(player as Player);
				coins.remove(obj);
			}
			
			if (obj is Exit) {
				(obj as Exit).collide(player as Player);
			}
		}
		
		private function removeOffscreen(group:FlxGroup):void {
			//trace(group.members.length);
			for (var i:int = 0; i < group.length; i++ ) {
				var obj:FlxBasic = group.members[i];
				if (obj != null && obj is FlxSprite) {
					if ((obj as FlxSprite).x + (obj as FlxSprite).width < FlxG.camera.scroll.x) {
						obj.kill();
						group.remove(obj, true);
					}
				}
			}
		}
		
		public function addFloor(y:Number, quicksand:Boolean = false):void {
			lastY = y;
			if (quicksand) {
				floor.add(new QuickSand(x, lastY));
			} else {
				floor.add(new Floor(x, lastY));
			}
			ceiling.add(new Floor(x, lastY - FlxG.height + floorTile.height, true));
			x += floorTile.width;
		}
		
		public function flatFloor(y:Number, dist:int, quicksand:Boolean = false) {
			for (var i:int = 0; i < dist; i++) {
				addFloor(y, quicksand);
			}
		}
		
		public function addCoin(y:Number):void {
			coins.add(new Coin(x, y));
		}
		
		public function addObstacle():void {
			
		}
		
		public function addExit():void {
			add(new Exit(x, lastY));
			flatFloor(lastY, 5);
		}
		
		public function size():Number {
			if (FlxG.level < levelSizes.length) {
				return levelSizes[FlxG.level];
			}
			
			return 1500;
		}
		
	}

}