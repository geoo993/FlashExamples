package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import fl.motion.Color;
	
	public class Main extends MovieClip
	{
		var colorTransSwitch:String = "idle";
		var colorTransNum:Number = 0;
		var curVal:Number= 0;
		
		var backColor1 = 0xFF0000;
		var backColor2 = 0x0000FF;
		var myBackColorTransform = new ColorTransform()  ;
		
		public var myCircleArray:Array = new Array() ;
		public var maxCircles:uint = 40;
	
		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			stage.addEventListener(MouseEvent.CLICK,mouseClick);
			mapp.buttonMode = true;
		}
		function createEnemy()
		{
			var cColor:uint = Math.random() * 0xFFFFFF;
			var cOutColor:uint = Math.random() * 0xFFFFFF;
			
			var transparency:Number = Math.random() * 2;
			var radius:Number = (Math.random() * 3)+1;
			
			var myCircle:MovieClip = new Enemy();
			this.addChild(myCircle);
			myCircleArray.push(myCircle);
			
			myCircle.x = stage.mouseX;
			myCircle.y = stage.mouseY;
			
			//myCircle.alpha = transparency;
			
			var sizeScale:Number = radius; 
			myCircle.scaleX = sizeScale;
			myCircle.scaleY = sizeScale;	
			
			myCircle.CircleLoop();
			
			if(myCircleArray.length > maxCircles)
			{   
				destroyer(myCircle);
			}
			
		}
		function removeEnemy() 
		{
			for (var i:uint = 0; i < myCircleArray.length; i++)
			{
				destroyer(myCircleArray[i]);
			}
		}
		
		public function gL(myEvent:Event):void
		{
			backgroundColorTransition();
			trace(stage.mouseY)
		}
	
		public function backgroundColorTransition()
		{
			if(colorTransSwitch == "goingUp")
			{
				colorTransNum += 5;
			}
			if(colorTransSwitch == "goingDown")
			{
				colorTransNum -= 5;
			}
			
			if(curVal <= 0)
			{
				colorTransSwitch = "goingUp";
				backColor2 = Math.random() * 0xFFFFFF;
			}
			if(curVal >= 1)
			{
				backColor1 = Math.random() * 0xFFFFFF;
				colorTransSwitch = "goingDown"
				
			}
			
			curVal = colorTransNum/255;
			myBackColorTransform.color = Color.interpolateColor(backColor1,backColor2,curVal);
			mapp.transform.colorTransform = myBackColorTransform;
			
			//trace(curVal+"  "+colorTransNum+"  "+colorTransSwitch)
		}
		function circularCollision(mc1:MovieClip,mc2:MovieClip)
		{
			var colliding:Boolean = false;
			var radiusOfBoth:Number = (mc1.width/2) + (mc2.width/2);
			var distance:Number = getDistance(mc1.x - mc2.x, mc1.y - mc2.y);
			
			if (distance <= radiusOfBoth) 
			{
				//trace("yesss")
				colliding = true;
			}
			else 
			{				
				//trace("noooo")
				//colliding = false;
			}
			return colliding;
		}
		/*function getDistance(x1:Number, y1:Number,  x2:Number, y2:Number)
		{
			var xDist:Number = x1 - x2;
			var yDist:Number = y1 - y2;
			return Math.sqrt(xDist * xDist + yDist * yDist);
		}*/
		public function getDistance(deltaX:Number, deltaY:Number):Number
		{
			return Math.sqrt((deltaX*deltaX)+(deltaY*deltaY));
		}
		
		public function getRadians(deltaX:Number, deltaY:Number):Number
		{
			var radian:Number = Math.atan2(deltaY, deltaX);
			
			if (deltaY < 0)
			{
				radian += (2 * Math.PI);
			}
			return radian;
		}
		public function getDegrees(radians:Number):Number
		{
			return Math.floor(radians/(Math.PI/180));
		}
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
		
		public function destroyer(myMc:MovieClip):void
		{
			var thisMc:MovieClip;

			for (var i:uint = 0; i < myCircleArray.length; i++)
			{
				thisMc= myCircleArray[i];

				if (thisMc == myMc)
				{
					myCircleArray.splice(i,1);
					myMc.parent.removeChild(myMc) 
				}
			}
		}
		
		function kDown(event:KeyboardEvent):void
		{  
			if (event.keyCode == 32)
			{
				removeEnemy() 
			}
		}
		function mouseClick(event:MouseEvent):void
		{
			if (stage.mouseY < 52 ||stage.mouseY > 348)
			{
				
			}
			else
			{
				createEnemy();
			}
		}

	}

}