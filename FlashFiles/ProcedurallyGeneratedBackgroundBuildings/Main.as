package 
{		import flash.display.*;	import flash.events.*;
	import fl.motion.*;
	import flash.geom.*;
		public class Main extends Sprite 
	{				public var skyColorArray:Array = new Array(); 
		public var carArray:Array = new Array();
		public var cloudsArray:Array = new Array();
		public var starsArray:Array = new Array();
		public var buildArray:Array = new Array();
		
		public var randomBackGroundNum:int = 0;
		public var numOfStars:uint = randomRange(1000,2000);;
		
		public var stars:Sprite;
		public var sky:Sprite;
		public var car:Sprite ;
		
		public var stageW:Number = stage.stageWidth;
		public var stageH:Number = stage.stageHeight;
		
		public var bSpeed:Number = 1;
		
		public var windowsArray:Array = new Array();
				public function Main() 
		{
						stage.addEventListener(MouseEvent.CLICK, generate); 
			this.addEventListener(Event.ENTER_FRAME,gameLoop);
			
			SkyColour();
			Starss()
			clouds();
			mooon(); 
			
			homes();
			vehicle();
			
					}		public function gameLoop(myEvent:Event)
		{
			for (var i:uint = 0; i < buildArray.length; i++)
			{  
				//buildArray[i].x -= bSpeed;
			}
			
			
		}				public function generate(m:MouseEvent) 
		{   
			
			remover();
			SkyColour();
			clouds();
			mooon();
			homes();
			
			bSpeed = Math.random()*5;
			vehicle()
					}
		
		public function vehicle()
		{
			car = new Cadillac();
			addChild(car)
			carArray.push(car)
		
		}
		public function SkyColour()
		{
			sky = new SkyLine();
			addChild(sky);
			skyColorArray.push(sky);

		}
		public function mooon()
		{
			var moon:Moon = new Moon(stageH/4+Math.random()*stageH/2);
			addChild(moon);
		}
		public function Starss()
		{
			for (var i:uint = 0; i < numOfStars; i++) 
			{
				stars = new Stars() ;
				stars.graphics.clear();
				stars.graphics.beginFill(0xFFFFFF,Math.random() * 2);
				stars.graphics.drawRect(0,0,randomRange(0,1),randomRange(0,1));
				stars.graphics.endFill();
				
				stage.addChild(stars);
				starsArray.push(stars);
				starsArray[i].StarsCreator();
			}
			
		}
		public function remover()
		{
			// remove all children
			
			/*while(numChildren>0) 
			{
				removeChildAt(0)
			}
			while (numChildren>0) removeChildAt(0);  */
			
			/*while(skyColorArray.numChildren > 0)
			{
				skyColorArray.removeChild(skyColorArray.getChildAt(0));
			}*/
			
			for (var e:uint = 0; e < carArray.length; e++)
			{ 
				if(carArray.length >0)
				{
					carArray.splice(e,1); 
				}
			}
			
			for (var s:uint = 0; s < skyColorArray.length; s++)
			{ 
				if(skyColorArray.length >0)
				{
					skyColorArray.splice(s,1); 
				}
			}
			
			for (var o:uint = 0; o < buildArray.length; o++)
			{ 
				if(buildArray.length >0)
				{
					buildArray.splice(o,1); 
				}
			}
			
			for (var a:uint = 0; a < cloudsArray.length; a++)
			{ 
				if(cloudsArray.length >0)
				{
					cloudsArray.splice(a,1); 
				}
			}
			
			for (var i:uint = 0; i < starsArray.length; i++)
			{   
				//starsArray[i].StarsDestructor();
				//starsArray.splice(i,0);
				/*while(starsArray.numChildren > 0)
				{
					starsArray.removeChild(starsArray.getChildAt(0));
				}
				starsArray[i].parent.removeChild(starsArray[i]); */
				
				starsArray[i].x = Math.random() * stageW;
				starsArray[i].y = Math.random() * stageH/1.1;
			}
			
		}
		public function clouds()
		{
			var cloud:Sprite = new Clouds();
			addChild(cloud);
			cloudsArray.push(cloud)
			
			cloud.x = randomRange(-200,0)
			
		}
		public function homes()
		{
			var build:Sprite = new Buildings();
			addChild(build); 
			buildArray.push(build)
			
		}
		function randomRange(minNum:int,maxNum:int)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
			}}