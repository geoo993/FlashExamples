package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import fl.motion.*;
	import com.greensock.*;
	import com.greensock.easing.*;


	public class Main extends MovieClip
	{
		
		public var currentIndex:uint;
		public var selectedBox:Sprite;
		
		public var bColor:uint = Math.random() * 0xFFFFFF;
		public var boxlength:Number = 30;
		public var numberOfBoxes:Number = 40;
		
		public var canvas:Sprite = new Sprite();
		public var gridArray:Array = new Array();
		
		
		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			
			stage.color =  Math.random()*0xffffff
			canvass();
			//trace(canvas2PointsArray)
		}
		public function gL(myEvent:Event):void
		{   
			addListeners();
			
			for (var i:uint = 0; i < gridArray.length; i++)
			{
				//gridArray[i].x = (i % 8) * (boxlength+80);
				//gridArray[i].y = int(i / 8) * (boxlength+80);
			
				TweenMax.to(gridArray[i],1,{x:(i % 8) * (boxlength+80), y:int(i / 8) * (boxlength+80)});
			}
		}
		
		public function canvass()
		{
			canvas.x = 150;
			canvas.y = 100;
			addChild(canvas);
			
		}
		public function createGrid() 
		{
			if(gridArray.length < numberOfBoxes)
			{
				var boxTwo:Sprite = new Sprite();
				boxTwo.graphics.clear();
				boxTwo.graphics.beginFill(bColor,1);
				boxTwo.graphics.moveTo(0,0);
				boxTwo.graphics.lineTo(0,-boxlength);
				boxTwo.graphics.lineTo(boxlength,-boxlength);
				boxTwo.graphics.lineTo(boxlength,boxlength);
				boxTwo.graphics.lineTo(-boxlength,boxlength);
				boxTwo.graphics.lineTo(-boxlength,-boxlength);
				boxTwo.graphics.lineTo(0,-boxlength);
				boxTwo.graphics.endFill();
				
				canvas.addChild(boxTwo);
				gridArray.push(boxTwo);
				
			}
		}
		public function addListeners():void
		{
			
			for (var a:uint = 0; a < gridArray.length; a++)
			{
				gridArray[a].buttonMode = true;
				gridArray[a].addEventListener(MouseEvent.MOUSE_OVER,gridOver);
				gridArray[a].addEventListener(MouseEvent.MOUSE_OUT,gridOut);
				gridArray[a].addEventListener(MouseEvent.CLICK,clickHandler);
			}
		}
		
		public function removeListeners():void
		{
			for (var a:uint = 0; a < gridArray.length; a++)
			{
				gridArray[a].buttonMode = false;
				gridArray[a].removeEventListener(MouseEvent.CLICK,clickHandler);
			}
		}
		
		public function clickHandler(e:MouseEvent):void
		{
			selectedBox = e.currentTarget as Sprite;
			currentIndex = gridArray.indexOf(e.currentTarget);
			
			//canvasPointsArray.splice(currentIndex,1);
			//boxRemoverArray.splice(currentIndex,1);
			
			destroyGridTwo(selectedBox)
			//destroyGridTwo(gridArray[currentIndex])
			
			removeListeners();
		}
		function gridOver(e)
		{
			canvas.addChild(e.currentTarget);
			TweenLite.to(e.currentTarget,0.5,{scaleX:1.2, scaleY:1.2,ease:Strong.easeOut});
		}
		function gridOut(e)
		{
			TweenLite.to(e.currentTarget,0.5,{scaleX:1, scaleY:1,ease:Strong.easeOut});
			
			//Elastic.easeOut
			//Strong.easeOut
			//Back.easeOut
			//Bounce.easeOut
		}
		
		public function destroyGridTwo(newG:Sprite):void
		{
			var thisG:Sprite;

			for (var i:uint = 0; i < gridArray.length; i++)
			{
				thisG = gridArray[i];

				if ((thisG == newG))
				{
					gridArray.splice(i,1);
					newG.parent.removeChild(newG);
					newG = null;
				}
			}
			
		}
	
		public function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.random() * (maxNum - minNum) + 1 + minNum;
		}
		function kDown(event:KeyboardEvent):void
		{  
			if (event.keyCode == 32)
			{
				//trace (boxRemoverArray.indexOf(5));
				
				createGrid();
				
			}
		}
		
	}

}