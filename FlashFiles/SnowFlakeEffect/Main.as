package 
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	public class Main extends MovieClip
	{
		
		public var snowColorTransform = new ColorTransform()  ;
		public var colorCount:Number = 0;
		public var colorState:Number = 0;
		public var sColor:uint = 0xFFFFFF;
		
		public var numberOfFlakes:Number = 500;
		
		public var speed:Number = 2;
		public var wind:Number = -2;
		public var stageWidth:Number = stage.stageWidth;
		public var stageHeight:Number = stage.stageHeight;
		
		public var rad:Number;;
		public var r:Number;
		public var k:Number;
		
		public var randomScale:Number = 0;
		public var snowCreator:String = "create";
		public var toggleAnimation = false;
		
		public var snowArray:Array = new Array();
		public var bgArray:Array = new Array();
		
		
		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gameLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			stage.addEventListener(MouseEvent.CLICK,mClick);
			
			noneB.buttonMode = true;
			rightB.buttonMode = true;
			leftB.buttonMode = true;
			slowB.buttonMode = true;
			normalB.buttonMode = true;
			fastB.buttonMode = true;
			reallyfastB.buttonMode = true;
			
			bgArray.push(bg1);
			bgArray.push(bg2);
			bgArray.push(bg3);
			bgArray.push(bg4);
			bgArray.push(bg5);
			bgArray.push(bg6);
			bgArray.push(bg7);
			bgArray.push(bg8);
			bgArray.push(bg9);
			bgArray.push(bg10);
			bgArray.push(bg11);
			bgArray.push(bg12);
			
		}
		
		public function createSnow() 
		{
			randomScale = randomRange(2,3.5);
			
			for (var i = 0; i < numberOfFlakes; i++) 
			{	
				var tempFlake:MovieClip = new SnowFlake() ;
				tempFlake.graphics.clear();
				tempFlake.graphics.beginFill(sColor,1);
				tempFlake.graphics.drawCircle(0,0,randomRange(.5,1));
				tempFlake.graphics.endFill();
				
				tempFlake.r = 1+Math.random()*speed;
				tempFlake.k = -Math.PI+Math.random()*Math.PI;
				tempFlake.rad = 0;
				
				tempFlake.scaleX = randomScale;
				tempFlake.scaleY = randomScale
				tempFlake.alpha = randomRange(.6,1);
				
				tempFlake.x = randomRange(0,stageWidth);
				tempFlake.y = randomRange(0,stageHeight);
				
				stage.addChild(tempFlake);
				snowArray.push(tempFlake)
				
				if(snowArray.length > numberOfFlakes)
				{
					removeSnow() ;
				}
			}
		}
		function removeSnow() 
		{
			for (var i:uint = 0; i < snowArray.length; i++)
			{
				snowDestroyer(snowArray[i]);
			}
		}
		public function gameLoop(myEvent:Event)
		{
			//trace(wind+"  "+colorCount+"  "+colorState)
			trace(bgArray.length)
			
			if(snowCreator == "create")
			{
				createSnow(); 
				snowCreator = "play";
			}
			if(snowCreator == "play")
			{
				for (var i:uint = 0; i < snowArray.length; i++)
				{
					snowArray[i].rad = degreesToRadians(snowArray[i].k);
					//snowArray[i].rad += (snowArray[i].k / 180) * Math.PI;
					snowArray[i].x -= Math.cos(snowArray[i].rad)+wind;
					snowArray[i].y += speed;
					
					if (snowArray[i].y >= stageHeight) 
					{
						snowArray[i].y = -5;
						snowArray[i].alpha = randomRange(.6,1);
						snowArray[i].scaleX = randomScale;
						snowArray[i].scaleY = randomScale;
					}
					if (snowArray[i].x >= stageWidth) 
					{
						snowArray[i].x = 1
						snowArray[i].alpha = randomRange(.6,1);
						snowArray[i].scaleX = randomScale;
						snowArray[i].scaleY = randomScale;
					}
					if (snowArray[i].x <= 0) 
					{
						snowArray[i].x = stageWidth - 1;
						snowArray[i].alpha = randomRange(.6,1);
						snowArray[i].scaleX = randomScale;
						snowArray[i].scaleY = randomScale;
					}
				}
			}
			if(snowCreator == "remove")
			{
				removeSnow(); 
			}
			
			colorChanger();
		
		}
		
		public function colorChanger()
		{
			
			colorCount++
			if(colorCount > 1000)
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
			for (var i:uint = 0; i < snowArray.length; i++)
			{
				if (snowArray[i].y >= stageHeight-1 || snowArray[i].x >= stageWidth-1||snowArray[i].x <= 1)
				{
					snowColorTransform.color = sColor;
					snowArray[i].transform.colorTransform = snowColorTransform;
					
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
		function degreesToRadians(degrees:Number):Number 
		{
			return degrees * Math.PI / 180;
		}
		public function snowDestroyer(myMc:MovieClip)
		{
			var thisMc:MovieClip;

			for (var i:uint = 0; i < snowArray.length; i++)
			{
				thisMc = snowArray[i];

				if (thisMc == myMc)
				{
					snowArray.splice(i,1);	
					myMc.parent.removeChild(myMc) 
				}
			}
		}
		
		function kDown(event:KeyboardEvent):void
		{  
			if (event.keyCode == 32)
			{
				for (var o:uint = 0; o < bgArray.length; o++)
				{
					bgArray[o].visible = false;
				}
			
				bgArray[randomRange(0,bgArray.length)].visible = true;
				
				
				/*if (toggleAnimation == false) 
				{
					snowCreator = "create";
					toggleAnimation = true;
				}
				else
				{
					snowCreator = "remove";
					toggleAnimation = false;
				}*/
			}
		}
		public function mClick(event:MouseEvent):void
		{
			if(event.target == noneB)
			{
				wind = 0;
			}
			if(event.target == rightB)
			{
				wind = -2;
			}
			if(event.target == leftB)
			{
				wind = 2;
			}
			if(event.target == slowB)
			{
				speed = .5;
			}
			if(event.target == normalB)
			{
				speed = 1.5;
			}
			if(event.target == fastB)
			{
				speed = 3;
			}
			if(event.target == reallyfastB)
			{
				speed = 6;
			}
		} 
		
		
	}

}