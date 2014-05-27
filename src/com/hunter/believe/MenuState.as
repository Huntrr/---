package com.hunter.believe
{
	import org.flixel.*;

	public class MenuState extends FlxState
	{
		override public function create():void
		{
			var t:FlxText;
			t = new FlxText(0,FlxG.height/2-20,FlxG.width,"... ?");
			t.size = 16;
			t.alignment = "center";
			t.shadow = 0xFF000000;
			add(t);
			t = new FlxText(FlxG.width/2-50,FlxG.height-20,100,"!");
			t.alignment = "center";
			t.shadow = 0xFF000000;
			add(t);
			
			FlxG.mouse.show();
			
			FlxG.level = 0;
			FlxG.score = 0;
			FlxG.bgColor = 0xFF280001;	
		}

		override public function update():void
		{
			super.update();
			if(FlxG.mouse.justPressed() || FlxG.keys.SPACE)
			{
				FlxG.mouse.hide();
				FlxG.fade(0xFF000000, 0.50, play);
				
			}
		}
		
		public function play():void {
			FlxG.switchState(new PlayState());
		}
	}
}