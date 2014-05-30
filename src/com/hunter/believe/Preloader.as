package com.hunter.believe
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import org.flixel.system.FlxPreloader;

	public class Preloader extends FlxPreloader
	{
		public function Preloader()
		{
			className = "com.hunter.believe.Believe";
			//this.minDisplayTime = 10;
			
			super();
		}
		
		private var loadingBarContainer:MovieClip;
		private var loadingBar:MovieClip;
		private var loadingPercent:TextField
		
		private static const BAR_SIZE:Number = 300;
		private static const HEIGHT:Number = 20;
		private static const SPACE:Number = 3;
		
		private var canUpdate:Boolean = false;
		private var updateTimer:int = 1;
		
		override protected function create():void {
			_buffer = new Sprite();
			addChild(_buffer);
			//Add stuff to the buffer...
			var cover:MovieClip = new MovieClip();
			cover.graphics.beginFill(0x280001);
			cover.graphics.drawRect(0, 0, stage.width, stage.height);
			_buffer.addChild(cover);
			
			loadingBarContainer = new MovieClip();
			loadingBarContainer.graphics.beginFill(0xFFFFFF);
			loadingBarContainer.graphics.drawRect( -SPACE, -SPACE, BAR_SIZE + SPACE * 2, HEIGHT + SPACE * 2);
			
			loadingBar = new MovieClip();
			loadingBar.graphics.beginFill(0x280001);
			loadingBar.graphics.drawRect(0, 0, 1, HEIGHT);
			
			loadingPercent = new TextField();
			loadingPercent.text = "Loading..."
			loadingPercent.selectable = false;
			loadingPercent.width = loadingBarContainer.width;
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.bold = true;
			format.size = 24;
			format.color = 0xFFFFFF;
			loadingPercent.setTextFormat(format);
			
			loadingBarContainer.x = (stage.width + loadingBarContainer.width) / 2;
			loadingBarContainer.y = (400 + loadingBarContainer.height) / 2;
		  
			loadingBar.x = loadingBarContainer.x;
			loadingBar.y = loadingBarContainer.y;
		  
			loadingPercent.x = loadingBarContainer.x;
			loadingPercent.y = loadingBarContainer.y + loadingBarContainer.height + 10;
			
			_buffer.addChild(loadingBarContainer);
			_buffer.addChild(loadingBar);
			_buffer.addChild(loadingPercent);
			
			canUpdate = true;
		}
		override protected function update(Percent:Number):void {
			updateTimer --;
			//Update the graphics...
			if (updateTimer < 0 && canUpdate) {
				updateTimer = 0;
				loadingBar.scaleX = (Percent) * BAR_SIZE;
			}
		}
	}
}