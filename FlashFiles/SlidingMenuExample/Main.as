package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;	import flash.geom.*;
	import com.greensock.*;
	import com.greensock.plugins.*;	public class Main extends MovieClip	{
		
		public var rColor = Math.random() * 0xFFFFFF;
		public var blurr:BlurFilter = new BlurFilter(5, 5, 3);
		
		public var recWidth:Number = stage.stageWidth/2;
		public var recHeight:Number = stage.stageHeight/2;
		
		public var numberOfMenus:Number = 5;		public var container:MovieClip =  new MovieClip();;
		public var recArray:Array = new Array();
		
		public var selectedMenu:MovieClip;
		public var menuIndex:uint;
		
				public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gameL);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
					}				public function gameL(myEvent:Event):void		{
			
			//startListening();
			addListeners();
					}		public function createRec() 
		//public function createRec(e:MouseEvent) 
		{
			rColor = Math.random() * 0xFFFFFF;
			addChild(container);
			
			if(recArray.length < numberOfMenus)
			{
				var rec:MovieClip = new MovieClip();
				rec.graphics.clear();
				rec.graphics.beginFill(rColor,1);
				//rec.graphics.drawRoundRect(x1,y1,widthN,heightN,ellipseWidth,ellipseHeight);
				rec.graphics.drawRect(0,0,recWidth,recHeight);
				//rec.graphics.drawCircle(0,0,1);
				rec.graphics.endFill();
				
				//rec.filters = [blurr];
				
				rec.x = randomRange(recWidth,stage.stageWidth);
				
				container.addChild(rec);
				recArray.push(rec); 
				
				TweenLite.to(rec, 0.5, {x:container.x});
			}
			
			
		}
		function addListeners():void
		{
			for (var i:uint = 0; i < recArray.length; i++) 
			{
				recArray[i].buttonMode = true;
				recArray[i].addEventListener(MouseEvent.CLICK, clickHandler);
			}
		}
		function removeListeners():void
		{
			for (var i:uint = 0; i < recArray.length; i++) 
			{
				recArray[i].buttonMode = false;
				recArray[i].removeEventListener(MouseEvent.CLICK, clickHandler);
			}
		}
		function clickHandler(e:MouseEvent):void
		{
			selectedMenu = e.currentTarget as MovieClip;
			menuIndex = recArray.indexOf(e.currentTarget);
			
			removeListeners();
			//trace(menuIndex);
			
			if(selectedMenu.x <= container.x)
			{
				TweenLite.to(selectedMenu, 0.5, {x:recWidth});
			}
			
			if(selectedMenu.x >= recWidth)
			{
				TweenLite.to(selectedMenu, 0.5, {x:container.x});
			}
			
		}
		public function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.random() * (maxNum - minNum) + 1 + minNum;
		}
		function startListening() 
		{	
			stage.addEventListener(MouseEvent.CLICK, createRec);
		}
		function kDown(event:KeyboardEvent):void
		{  
			if (event.keyCode == 32)
			{
				createRec();
			}
		}
			}}