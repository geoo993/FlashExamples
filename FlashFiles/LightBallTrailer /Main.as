package {	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.ui.*;
	import fl.motion.Color;	public class Main extends Sprite	{
		public var particleArray:Array = new Array();
		
		public var colorTransSwitch:String = "idle";
		public var colorTransNum:Number = 0;
		public var curVal:Number= 0;
		public var color1 = Math.random () * 0xFFFFFF;
		public var color2 = 0x0000FF;
				public function Main():void		{			//Mouse.hide();
			this.addEventListener(Event.ENTER_FRAME,gameLoop);		}		private function createTrailer(e:MouseEvent):void		{			//var myTrail:LightSpark = new LightSpark();			var myTrail:LightBall = new LightBall();			myTrail.x = stage.mouseX + Math.random() * myTrail.width;			myTrail.y = stage.mouseY - Math.random() * myTrail.height;
			
			var lightBallScale:Number = randomRange(.1,1);
			myTrail.scaleX = lightBallScale;
			myTrail.scaleY = lightBallScale;			addChild(myTrail);
			particleArray.push(myTrail)
					}
		function addListening() {
	
			stage.addEventListener(MouseEvent.MOUSE_MOVE, createTrailer);
		}
				public function gameLoop(e:Event):void		{			addListening() ;
			backgroundColorTransition();
			
			for(var i:uint = 0; i < particleArray.length; i++)
			{
				var particle:MovieClip = particleArray[i];
				particle.y += 3;
				particle.alpha -= 0.04;
				particle.scaleX -= 0.1;
				particle.scaleY -= 0.1;
			
				if(particle.alpha <= 0)
				{
					particleArray.splice(i, 1);
					removeChild(particle);
				}
			 }				}
		public function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.random() * (maxNum - minNum) + 1 + minNum;
		}
		public function backgroundColorTransition()
		{
			if(colorTransSwitch == "goingUp")
			{
				colorTransNum += 1;
			}
			if(colorTransSwitch == "goingDown")
			{
				colorTransNum -= 1; 
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
			stage.color = Color.interpolateColor(color1,color2,curVal);
			
		}	}}