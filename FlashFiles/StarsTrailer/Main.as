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
		
		public var sLength:Number = 10;
		public var xVel:Number = 0;
		public var yVel:Number = 0;
		public var numParticles:uint = 30;
		public var circlesArray:Array = new Array();
		public var starsArray:Array = new Array();
		
		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			
		}
		public function gL(myEvent:Event):void
		{   
			startListening();
			backgroundColorTransition();
			removeTrails();
			
			//part2......
			for(var i:uint = 0; i < starsArray.length; i++)
			{
				  var particle:MovieClip = starsArray[i];
				  particle.x += particle.xVel;
				  particle.y += particle.yVel;
				  particle.alpha -= 0.06;
				  
				if(particle.alpha <= 0)
				{
					starsArray.splice(i,1);
					removeChild(particle);
				}
				
			 }
		}
		public function createStar(e:MouseEvent)
		{
			sColor = Math.random() * 0xFFFFFF;
			
			if(starsArray.length < numParticles)
			{
				var star:MovieClip = new MovieClip();
				star.graphics.clear();
				star.graphics.beginFill(sColor,1);
				star.graphics.moveTo(0,0);
				star.graphics.lineTo(-2,-3);
				star.graphics.lineTo(0,-sLength);
				star.graphics.lineTo(2,-3);
				star.graphics.lineTo(sLength,-3);
				star.graphics.lineTo(3,1);
				star.graphics.lineTo(6,sLength);
				star.graphics.lineTo(0,4);
				star.graphics.lineTo(-6,sLength);
				star.graphics.lineTo(-3,1);
				star.graphics.lineTo(-sLength,-3);
				star.graphics.lineTo(-2,-3);
				star.graphics.endFill();
				
				star.x= stage.mouseX;
				star.y= stage.mouseY;
				var starScale:Number = randomRange(.1,.5);
				star.scaleX= starScale;
				star.scaleY= starScale;
				
				//part1......
				//TweenLite.to(star, 1, {alpha:0,rotation: randomRange(0, 360),x:stage.mouseX + randomRange(-60, 60),y:stage.mouseY + randomRange(-60, 60),onComplete:function(){removeChild(star);}});
			
				//part2.......
				star.alpha = randomRange(0.5,0.9);
				star.rotation = randomRange(0,360);
				star.xVel = randomRange(-4,4);
				star.yVel = randomRange(-4,4);
				  
				addChild(star);
				starsArray.push(star);
				
			}
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
		
			circle.scaleX= randomRange(3,6);
			circle.scaleY= randomRange(3,6);;
			
			addChild(circle);
			circlesArray.push(circle);
			
			//TweenLite.to(circle, 2, {alpha:0,rotation: randomRange(0, 360),x:stage.mouseX + randomRange(-60, 60),y:stage.mouseY + randomRange(-60, 60),onComplete:removeTrailer});
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
			
			//trace(starsArray.length+"   "+circlesArray.length)
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
			stage.addEventListener(MouseEvent.MOUSE_MOVE, createStar);
		}

	}

}