package  
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	public class Main extends MovieClip
	{		
		public var player:MovieClip;
		public var playerSpeed:Number = 20;
		public var playerArray:Array = new Array();
		public var playerColor = Math.random() * 0xFFFFFF;
		public var playerOutColor:uint = Math.random() * 0xFFFFFF;
		
		public var destinationX:int = 0;
		public var destinationY:int = 0;
		
		
		public function Main() 
		{
			createPlayer();
			stage.addEventListener(Event.ENTER_FRAME, gameLoop);
		}
		
		public function createPlayer():void
		{
			player = new MovieClip();
			player.graphics.lineStyle(2,playerOutColor,1,true);
			player.graphics.beginFill(playerColor,1);
			player.graphics.drawCircle(0,0,randomRange(10,20));
			player.graphics.endFill();
			
			//player = new Player();
			player.x = stage.stageWidth / 2;
			player.y = stage.stageHeight / 2;
			stage.addChild(player);
			playerArray.push(player);
			
		}
		
		public function gameLoop(event:Event):void
		{
			trace(playerArray.length)
			destinationX = stage.mouseX;
			destinationY = stage.mouseY;
			
			player.x += (destinationX - player.x) / playerSpeed;
			player.y += (destinationY - player.y) / playerSpeed;
			
			rotatePlayer();
		}
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
		private function rotatePlayer():void
		{
			
			var radians:Number = Math.atan2(destinationY - player.y, destinationX - player.x);
			var degrees:Number = radians / (Math.PI / 180) + 90;
			player.rotation = degrees;
		}
		
	}
	
}