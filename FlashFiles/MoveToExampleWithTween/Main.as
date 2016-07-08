package {	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import fl.motion.Color;
	import flash.ui.*;	import com.greensock.TweenLite;	import com.greensock.easing.*;	public class Main extends MovieClip	{
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		public var color1:uint;
		public var color2:uint;
		
		public var cShape:MovieClip = new MovieClip() ;
		public var cColor:uint = Math.random() * 0xFFFFFF;
		public var cArray:Array = new Array();
				public function Main()		{
			this.addEventListener(Event.ENTER_FRAME,gLoop);			stage.addEventListener(MouseEvent.CLICK, moveToClick);
			Mouse.cursor = "button";
			createShape();		}		public function gLoop(myEvent:Event)
		{
			  backgroundColorTransition();
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
			
		}
				function moveToClick(e:MouseEvent):void		{			moveTo(cShape,Math.random()*2);		}
		function createShape()
		{
			cShape.graphics.clear();
			cShape.graphics.beginFill(cColor,1);
			cShape.graphics.drawCircle(0,0,randomRange(5,20));
			cShape.graphics.endFill();
			
			cShape.x = Math.random() * stage.stageWidth;
			cShape.y = Math.random() * stage.stageHeight;
		
			stage.addChild(cShape);
			//cArray.push(cShape); 
			
		}
		public function moveTo(mc:MovieClip,Speeed:Number)
		{
			//mc.x =  stage.mouseX;
			//mc.y =  stage.mouseY;
			
			TweenLite.to(mc, Speeed, {x:stage.mouseX, y:stage.mouseY, ease:Cubic.easeIn});
		}
		
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}	}}