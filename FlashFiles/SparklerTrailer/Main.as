package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import fl.motion.Color;
	import com.greensock.*;
	import com.greensock.easing.*;


	public class Main extends MovieClip
	{
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		public var color1:uint;
		public var color2:uint;
		
		public var sColor = Math.random() * 0xFFFFFF;
		public var cColor = Math.random() * 0xFFFFFF;
		
		public var blurr:BlurFilter = new BlurFilter(5, 5, 3);
		
		public var circlesArray:Array = new Array();
		public var sparklerArray:Array = new Array();
		
		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
		}
		public function gL(myEvent:Event):void
		{   
			startListening();
			backgroundColorTransition();
			removeTrails();
		}
		public function sparkler(e:MouseEvent) 
		{
			var spark:MovieClip = new MovieClip();
			spark.graphics.clear();
			spark.graphics.beginFill(sColor,1);
			spark.graphics.drawCircle(0,0,10);
			spark.graphics.endFill();
			
			addChild(spark);
			sparklerArray.push(spark);
			
			spark.x= stage.mouseX;
			spark.y= stage.mouseY;
			
			var size:Number = Math.random()*15;
			var size2:Number = Math.random()*(size-size/2) *(Math.random()*2-1);
			spark.width = size;
			spark.height = size;
			//spark.filters = [blurr];
			
			TweenLite.to(spark, 1, {width:size+size2,height:size+size2,alpha:0,x:mouseX+(Math.random()*150-75),y:mouseY+(Math.random()*150-75), onComplete:function(){removeChild(spark)}});
			
		}
		
		public function createCircle(e:MouseEvent) 
		{
			cColor = Math.random() * 0xFFFFFF;
			
			var circle:MovieClip = new MovieClip();
			circle.graphics.clear();
			circle.graphics.beginFill(cColor,1);
			circle.graphics.drawCircle(0,0,1);
			circle.graphics.endFill();
			
			circle.x= stage.mouseX;
			circle.y= stage.mouseY;
			
			//var starScale:Number = randomRange(3,3);
			circle.scaleX= randomRange(3,6);
			circle.scaleY= randomRange(3,6);;
			circle.alpha = randomRange(0.5,0.9);
			circle.rotation = randomRange(0,360);
			circle.filters = [blurr];
			
			addChild(circle);
			circlesArray.push(circle);
			
			TweenLite.to(circle, 1, {alpha:0,rotation: randomRange(0, 360),x:stage.mouseX + randomRange(-60, 60),y:stage.mouseY + randomRange(-60, 60),onComplete:function(){removeChild(circle);}});
			
		}
		public function removeTrails()
		{
			for (var o:uint = 0; o < circlesArray.length; o++)
			{
				if(circlesArray[o].alpha <= 0)
				{
					circlesArray.splice(o,1);
				}
			}
			for (var i:uint = 0; i < sparklerArray.length; i++)
			{
				if(sparklerArray[i].alpha <= 0)
				{
					sparklerArray.splice(i,1);
				}
			}
			//trace(sparklerArray.length+"   "+circlesArray.length)
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
	
		public function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.random() * (maxNum - minNum) + 1 + minNum;
		}
		
		function startListening() {
	
			stage.addEventListener(MouseEvent.MOUSE_MOVE, createCircle);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, sparkler);
			
		}

	}

}