package com.hunter.believe.entity 
{
	import com.hunter.believe.entity.floors.Floor;
	import com.hunter.believe.entity.floors.QuickSand;
	import com.hunter.believe.entity.obstacles.MidBlock;
	import com.hunter.believe.entity.obstacles.Rock;
	import com.hunter.believe.entity.obstacles.TopBlock;
	import com.hunter.believe.util.ObsPicker;
	import com.hunter.believe.util.SpecHandler;
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
		
		[Embed(source = "../img/pillar.png")] private var pillarPNG:Class;
		
		public var floor:FlxGroup;
		public var ceiling:FlxGroup;
		private var coins:FlxGroup;
		public var obstacles:FlxGroup;
		public var decor:FlxGroup;
		private var x:Number;
		private var lastY:Number;
		private var lastPillar:int = 0;
		private var floorTile:Floor;
		private var levelSizes:Array = [750, 1000, 1000, 1250, 1250];
		private var hasExit:Boolean = false;
		private var level:int;
		
		public function Level() 
		{
			super();
			level = FlxG.level;
			//setup floor
			x = 0;
			
			floor = new FlxGroup();
			ceiling = new FlxGroup();
			coins = new FlxGroup();
			obstacles = new FlxGroup();
			decor = new FlxGroup();
			
			add(decor);
			add(obstacles);
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
			removeOffscreen(decor);
			
			if (FlxG.camera.scroll.x + FlxG.width > x - floorTile.width) {
				generateUntil(x + 100);
			}
		}
		
		private function generateUntil(next:Number):void {
			while (x < next) {
				var randFloor:Number = FlxG.random()
				if (randFloor > 0.05) {
					addFloor(lastY); // flat floor
				} else if(randFloor > 0.00) {
					addFloor(lastY - Math.floor(FlxG.random() * 25 + 5)); //not so flat floor
				}
				
				if (FlxG.random() < 0.1 && x - lastPillar > 20) {
					//make a pillar
					addPillar();
					flatFloor(lastY, 3);
				}
				
				if(x - 75 < size()) {
					var rand:Number = Math.floor(FlxG.random() * 1000);
					
					if (rand > 900) {
						addCoin(lastY - 10);
					} else if (rand > 800) {
						addCoin(lastY - (10 + Math.floor(FlxG.random() * 80)));
					} else if (rand > 400) {
						addObstacle();
					} else if (rand > 325 && SpecHandler.canQuickSand()) {
						//quicksand!
						if(!SpecHandler.fallingFloor()) {
							flatFloor(lastY, Math.floor(FlxG.random() * 10 + 4), true, SpecHandler.solidQuickSand() ? 1 : 0);
						} else {
							flatFloor(lastY, Math.floor(FlxG.random() * 8 + 4), false, 0);
						}
					} else if (rand > 275) {
						flatFloor(lastY, 2);
						x += floorTile.width * Math.floor(FlxG.random() * 5 + 3);
						flatFloor(lastY, 4);
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
			
			if (obj is Collidable) {
				(obj as Collidable).collide(player as Player);
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
		
		public function addFloor(y:Number, quicksand:Boolean = false, solid:int = -1):void {
			lastY = y;
			if (quicksand) {
				floor.add(new QuickSand(x, lastY, false, solid != -1 ? solid == 1 : false));
			} else {
				floor.add(new Floor(x, lastY, false, solid != -1 ? solid == 1 : true));
			}
			ceiling.add(new Floor(x, lastY - FlxG.height + floorTile.height, true));
			x += floorTile.width;
		}
		
		public function flatFloor(y:Number, dist:int, quicksand:Boolean = false, solid:int = -1):void {
			for (var i:int = 0; i < dist; i++) {
				addFloor(y, quicksand, solid);
			}
		}
		
		public function addPillar():void {
			var init:Number = lastY;
			var y:Number = init;
			lastPillar = x;
			while (y > init - FlxG.height + floorTile.height) {
				//add pillar blocks
				var tile:FlxSprite = new FlxSprite(x, y);
				tile.loadGraphic(pillarPNG);
				y -= tile.height;
				tile.alpha = 0.2;
				decor.add(tile);
			}
		}
		
		public function addCoin(y:Number):void {
			coins.add(new Coin(x, y));
		}
		
		public function addObstacle():void {
			var pair:Array = ObsPicker.getObstable(x, lastY);
			obstacles.add(pair[0]);
			flatFloor(lastY, pair[1]);
		}
		
		public function addExit():void {
			add(new Exit(x, lastY));
			flatFloor(lastY, 5);
		}
		
		public function size():Number {
			if (level < levelSizes.length) {
				return levelSizes[level];
			}
			
			return 1500;
		}
		
	}

}