package  
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	
	public class Main extends MovieClip
	{		
		public var player:MovieClip;
		public var playerSpeed:Number = 20;
		public var playerArray:Array = new Array();
		public var playerColor:uint = Math.random() * 0xFFFFFF;
		public var playerOutColor:uint = Math.random() * 0xFFFFFF;
		
		public var bitmapData:BitmapData;
		public var bitmap:Bitmap;
		public var radius:Number;
		public var display:Sprite;
		public var origin:Point;
		public var blur:BlurFilter;
		public var bitmapColorTransform:ColorTransform;
		
		public function Main() 
		{
			stage.addEventListener(Event.ENTER_FRAME, gameLoop);
			createTrailer();
		}
		
		public function createTrailer():void 
		{
			radius = 5;
			
			player = new MovieClip();
			//player.graphics.lineStyle(2,playerOutColor,1,true);
			player.graphics.beginFill(playerColor,1);
			player.graphics.drawCircle(0,0,randomRange(5,10));
			//player.graphics.drawEllipse(-radius,-radius,2*radius,2*radius);
			player.graphics.endFill();
			
			player.x = stage.stageWidth / 2;
			player.y = stage.stageHeight / 2;
			
			display = new MovieClip();
			display.addChild(player);
			playerArray.push(player);
			
			bitmapData = new BitmapData(stage.stageWidth,stage.stageHeight,true,Math.random() * 0xFFFFFF);
			bitmap = new Bitmap(bitmapData);
			
			blur = new BlurFilter(5,5);
			//bitmapColorTransform = new ColorTransform(0.999,0.95,0.9,.9);
			bitmapColorTransform = new ColorTransform(randomRange(0,1),randomRange(0,1),randomRange(0,1),.9);
			origin = new Point(0,0);
			
			addChild(bitmap);
			
		}
		public function gameLoop(event:Event):void
		{
			player.x += (stage.mouseX - player.x) / playerSpeed;
			player.y += (stage.mouseY - player.y) / playerSpeed;
			rotateToward(player,stage.mouseX,stage.mouseY);
			
			bitmapData.applyFilter(bitmapData,bitmapData.rect,origin,blur);
			bitmapData.colorTransform(bitmapData.rect, bitmapColorTransform);
			bitmapData.draw(display);
			
		}
		function randomRange(low:Number, high:Number):Number 
		{
			var randNum:Number = (Math.random() * (high - low)) + low;
			return randNum;
		} 
		public function rotateToward(mc:MovieClip,targetX:Number,targetY:Number):void
		{
			var radians:Number = Math.atan2(targetY - mc.y, targetX - mc.x);
			var degrees:Number = radians / (Math.PI / 180) + 90;
			mc.rotation = degrees;
		}
		
	}
	
}