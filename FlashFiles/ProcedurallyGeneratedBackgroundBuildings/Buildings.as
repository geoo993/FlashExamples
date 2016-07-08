package  {		import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import fl.motion.Color;		public class Buildings extends Sprite 
	{		public var buildingsCount:int;
		public var stageW:Number = 1200; //stage width
		public var stageH:Number = 700; //stage height
		
		public var buildState:Boolean = false;
		public var buildingsArray:Array = new Array(); 
		public var numOfBuild:uint = 1;
		public var buildC:uint = Math.random()*0x444444;
		public var buildingsA:Number = Math.random()*1
		
		public var rows:uint = 3;
		// The amount of rows that would fill the screen
		public var rowsPerScreen:uint = 10;
		
		public var build:Sprite = new Sprite();
				public function Buildings() 
		{  
			this.addEventListener(Event.ENTER_FRAME, updateBuildings);
		}
	
		
		public function createBuilding()
		{
			var widthh = 40+Math.random()*8;
			
			if(buildingsArray.length< numOfBuild)
			{	
				build = new Sprite();
				build.graphics.beginFill(buildC,1);
				build.graphics.drawRect(this.width,stageH,widthh,-(stageH/10+Math.random()*stageH/4));
				build.graphics.endFill();
				addChild(build);
				buildingsArray.push(build)
			}
			for (var i:uint = 0; i < buildingsArray.length; i++)
			{  
				if(this.x <= -10)
				{
					numOfBuild --
					buildingsArray.pop();
				}
			}
		}
		
		function updateBuildings(e:Event):void
		{
			createBuilding()
			
			buildingsCount++
			
			if(buildingsCount >10)
			{   
				numOfBuild ++;
				buildingsCount = 0;
			}
			
			//trace(buildingsArray.length+"  "+buildingsCount+"  "+numOfBuild)
		}
	
		function randomRange(minNum:int,maxNum:int)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}	}}