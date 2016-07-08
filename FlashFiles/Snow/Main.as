package 
{
	import flash.display.*
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import fl.motion.*;
	import Snowflake;
	
	public class Main extends MovieClip
	{
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var Transitions:ColorTransform = new ColorTransform  ;
		public var curVal:Number;
		public var curVal2:Number;
		public var color1:uint;
		public var color2:uint =  0xFFFFFF;
		public var interpolationColor; 
		
		public var wi:int = 1400 //stage.stageWidth; 
		public var he:int = 720 //stage.stageHeight;
		
        public var bg:Sprite = new Sprite();
		
		public var snowflakeVect:Vector.<Snowflake> = new Vector.<Snowflake>;

		public var numberOfSnowflakes:uint = 300;
		public var toggleAnimation = false;
		
		public var mySnowColorTransform = new ColorTransform()  ;
		public var colorCount:Number = 0;
		public var colorState:Number = 0;
		public var sColor:uint = 0xFFFFFF;
		public var snowColor:Number = 0;
		public var minSize:Number = 5;
		public var maxSize:Number = 20;
		public var radius:Number = 0;
		public var transparency:Number = Math.random() * 2;
		public var thickness:Number = Math.random() * 4;
		public var snowCreator:String = "idle";
		public var snowflakeArray:Array = new Array();

		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gameL);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			
		}
		public function gameL(myEvent:Event)
		{
			
			changeColorOvertime();
			backgroundColorTransition();
			
			if(snowCreator == "create")
			{
				createSnow(); 
				snowCreator = "idle";
			}
			if(snowCreator == "remove")
			{
				removeSnow(); 
			}
	
		}
		//part1...............................
		function addSnowflakes()
		{
			for (var i:uint = 0; i < numberOfSnowflakes; i++) 
			{
				snowflakeVect.push(new Snowflake());
				
				snowflakeVect[i].x = Math.random() * stage.stageWidth;
				snowflakeVect[i].y = Math.random() * stage.stageHeight;
		
				snowflakeVect[i].alpha = randomRange(.5,1);
			
				var flakeScale:Number = randomRange(.4,.8);	
				snowflakeVect[i].scaleX = flakeScale;
				snowflakeVect[i].scaleY = flakeScale;	
				
				addChild(snowflakeVect[i]);
			} 
			
		} 
		function removeSnowflakes()
		{
			for (var i:uint = 0; i < numberOfSnowflakes; i++) 
			{
				snowflakeVect[i].SnowflakeDestructor();
				removeChild(snowflakeVect[i]);		
			}
			while(snowflakeVect.length > 0) 
			{
				snowflakeVect.pop();
			}
		}
		
		//part2..............................
		function createSnow()
		{
		
			for (var i:uint = 0; i < numberOfSnowflakes; i++) 
			{
				transparency = Math.random() * 2;
				
				var mySnow:MovieClip = new Snowflake2() ;
				mySnow.graphics.clear();
				mySnow.graphics.beginFill(sColor,transparency);
				mySnow.graphics.drawCircle(0,0,randomRange(.5,1));
				mySnow.graphics.endFill();
				
				mySnow.x = Math.random() * stage.stageWidth;
				mySnow.y = Math.random() * stage.stageHeight;
				
				var flakeScale:Number = randomRange(3,5);	
				mySnow.scaleX = flakeScale;
				mySnow.scaleY = flakeScale;	
			
				stage.addChild(mySnow);
				snowflakeArray.push(mySnow); 
			}
			
			if(snowflakeArray.length > numberOfSnowflakes)
			{   
				removeSnow() 
			}
		}
		
		function removeSnow() 
		{
			for (var p:uint = 0; p < snowflakeArray.length; p++)
			{
				snowflakeArray[p].SnowflakeDestructor();
				snowDestroyer(snowflakeArray[p]);
			}
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
			if(curVal2 <= 0)
			{   
				colorTransSwitch = "goingUp";
				color2 = Math.random() * 0xFFFFFF;
			}
			if(curVal2 >= 1)
			{
				color1 = Math.random() * 0xFFFFFF;
				colorTransSwitch = "goingDown"
			}
			
			curVal2 = colorTransNum/255;

			Transitions.color = Color.interpolateColor(color1,color2,curVal2);
			interpolationColor = "0x"+Transitions.color.toString(16);
			//stage.color = interpolationColor;
			//stage.color = Color.interpolateColor(color1,color2,curVal2)
			
			var colours = [0xFFFFFF,interpolationColor] 
			var alphas = [ 1, 1 ]; 
			var ratios = [ 0, 180 ]; 
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(wi, he, Math.PI/2);
			
			bg.graphics.clear();
			bg.graphics.beginGradientFill(GradientType.LINEAR, colours, alphas, ratios, matrix);
			bg.graphics.drawRect(-100,0,wi,he-30);
			bg.graphics.endFill();
			addChild(bg);
		}
		public function changeColorOvertime()
		{
			colorCount++
			if(colorCount >500)
			{
				colorState = randomRange(0,5);
				colorCount = 0;
			}
			if(colorState == 0)
			{
				sColor = 0xFFFFFF;
			}
			if(colorState == randomRange(1,4))
			{
				sColor = Math.random() * 0xFFFFFF;
				colorState = 10;
			}
			for (var d:uint = 0; d < snowflakeArray.length; d++)
			{
				if (snowflakeArray[d].y > stage.stageHeight)
				{
					mySnowColorTransform.color = sColor;
					snowflakeArray[d].transform.colorTransform = mySnowColorTransform;
					
					if(colorState == 5)
					{
						sColor = Math.random() * 0xFFFFFF;
					}
				}
			}
		}

		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
		public function snowDestroyer(myMc:MovieClip)
		{
			var thisMc:MovieClip;

			for (var i:uint = 0; i < snowflakeArray.length; i++)
			{
				thisMc = snowflakeArray[i];

				if (thisMc == myMc)
				{
					snowflakeArray.splice(i,1);	
					myMc.parent.removeChild(myMc) 
				}
			}
		}
		
		function kDown(event:KeyboardEvent):void
		{  
			if (event.keyCode == 32)
			{
			
				if (toggleAnimation == false) 
				{
					//addSnowflakes();
					snowCreator = "create";
					toggleAnimation = true;
				}
				else
				{
					//removeSnowflakes(); 
					snowCreator = "remove";
					toggleAnimation = false;
					
				}
			}
		}


	}

}