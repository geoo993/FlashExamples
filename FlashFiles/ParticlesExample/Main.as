package {	import flash.display.*;	import flash.events.*;	import flash.geom.*;
	import flash.filters.*;
	import fl.motion.*;	public class Main extends MovieClip	{
		public var myColor:uint; // = Math.random()*0xB19210;
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		public var color1:uint;
		public var color2:uint;
		public var colorTransit:ColorTransform = new ColorTransform  ;
		
		public var particleArray:Array = new Array();
		public var maxParticles:Number = 100;
		
		public var xMovement:Number = 0;
		public var yMovement:Number = 0;
		public var myTimer:Number = 0;
		
		public var player:Sprite = new Sprite();;
		public var playerSpeed:Number = 10;
		public var playerArray:Array = new Array();
		public var playerColor = Math.random() * 0xFFFFFF;
		
				public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gLoop);			
			stage.color = Math.random()* 0xFFFFFF;
			createPlayer();		}		public function gLoop(myEvent:Event):void		{
			
			//trace(particleArray.length +"   "+playerArray.length)			
			myTimer++
			if(myTimer > 1)
			{
				addParticle()
				myTimer = 0;
			}
			
			for (var i:uint = 0; i < particleArray.length; i++)
			{
				if(particleArray[i].alpha <= 0 || particleArray[i].scaleX <= 0 && particleArray[i].scaleY <= 0)
				{
					particleArray[i].partDestructor();
					particleArray.splice(i,1);
				}
			}
			
			movePlayer(); 
			colorTransition();		}
		public function createPlayer():void
		{
			player.graphics.beginFill(playerColor,1);
			player.graphics.drawCircle(0,0,10);
			player.graphics.endFill();
			
			player.x = stage.stageWidth / 2;
			player.y = stage.stageHeight / 2;
			stage.addChild(player);
			playerArray.push(player);
			
		}
		private function movePlayer():void
		{
			var radians:Number = Math.atan2(mouseY - player.y, mouseX - player.x);
			var degrees:Number = radians / (Math.PI / 180) + 90;
			player.rotation = degrees;
			
			player.x += (mouseX - player.x) / playerSpeed;
			player.y += (mouseY - player.y) / playerSpeed;
		}
		public function addParticle()
		{
			var dot:Sprite = new Dots();
			dot.graphics.clear()
			//dot.graphics.lineStyle(2,Math.random()*0xffffff,1,true);
			dot.graphics.beginFill(myColor,1)
			dot.graphics.drawCircle(0,0, randomRange(14,20))
			dot.graphics.endFill();
			
			dot.x = player.x;
			dot.y = player.y;
			
			//dot.scaleX = dot.scaleY = Math.random() * 1 + .2;
			
			particleArray.push(dot);
			addChild(dot);
			
			/*if (particleArray.length >= maxParticles)
			{
				removeChild(particleArray.shift());
			}*/
			
		}
		public function colorTransition()
		{
			if(colorTransSwitch == "goingUp")
			{
				colorTransNum += .5;
			}
			if(colorTransSwitch == "goingDown")
			{
				colorTransNum -= .5; 
			}
			if(curVal <= 0)
			{   
				colorTransSwitch = "goingUp";
				color2 = Math.random() * 0xFFFFFF;
			}
			if(curVal >= 1)
			{
				color1 = Math.random() * 0xFFFFFF;
				colorTransSwitch = "goingDown"
			}
			
			curVal = colorTransNum/255;
			myColor = Color.interpolateColor(color1,color2,curVal);
			
			colorTransit.color = myColor;
			player.transform.colorTransform = colorTransit;
			
			for (var i:uint = 0; i < particleArray.length; i++)
			{
				//particleArray[i].transform.colorTransform = colorTransit;
			}
			
		}
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}	}}