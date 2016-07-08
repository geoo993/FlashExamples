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
		public var indexControl:int = 0;
		public var numberOfBoxes:Number = 40;
		
		public var dynamicGridArray:Array = new Array();
		public var canvasPointsArray:Array = new Array();
		public var boxRemoverArray:Array = new Array();
		
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
			boxRemoverArray.sort();
			
			trace("IndexControl: "+indexControl+"   boxRemover: "+ boxRemoverArray.length+"   "+boxRemoverArray+"   gridLength: "+gridArray.length)
			
		}
		
		public function canvass()
		{
			canvas.x = 150;
			canvas.y = 100;
			addChild(canvas);
			
			for (var i:int = 0; i < numberOfBoxes; i++) 
			{    
				var myBox:Sprite = new Sprite();
				myBox.x = (i % 8) * (boxlength+80);
				myBox.y = int(i / 8) * (boxlength+80);
				
				canvasPointsArray.push(new Point(myBox.x,myBox.y));
				dynamicGridArray.push(new Point(myBox.x,myBox.y));
				
			}
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
				
				
				if(boxRemoverArray.length <= 0)
				{
					//boxTwo.x = dynamicGridArray[indexControl-1].x;
					//boxTwo.y = dynamicGridArray[indexControl-1].y;
					
					TweenMax.to(boxTwo,1,{x:dynamicGridArray[indexControl-1].x, y:dynamicGridArray[indexControl-1].y});
			
				}
				if(boxRemoverArray.length > 0)
				{
					//boxTwo.x = boxRemoverArray[0].x;
					//boxTwo.y = boxRemoverArray[0].y;
					
					TweenMax.to(boxTwo,1,{x:boxRemoverArray[0].x, y:boxRemoverArray[0].y});
				}
				
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
			
			indexControl -= 1;
			boxRemoverArray.push(new Point(selectedBox.x,selectedBox.y));
			destroyGridTwo(selectedBox)
			//destroyGridTwo(gridArray[currentIndex])
			
			removeListeners();
		}
		function gridOver(e)
		{
			canvas.addChild(e.currentTarget);
			TweenLite.to(e.currentTarget,0.5,{scaleX:1.2, scaleY:1.2,ease:Elastic.easeOut});
		}
		function gridOut(e)
		{
			TweenLite.to(e.currentTarget,0.5,{scaleX:1, scaleY:1,ease:Elastic.easeOut});
			
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
				
				indexControl += 1;
				if(indexControl >= numberOfBoxes)
				{
					indexControl = numberOfBoxes;
				}
				createGrid();
				boxRemoverArray.shift();
				
			}
		}
		
	}

}