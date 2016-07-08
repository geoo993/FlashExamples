package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.geom.*;
	import fl.motion.*;
	import com.greensock.*;
	import com.greensock.easing.*;


	public class Main extends MovieClip
	{
		public var normalIndex:int = 0;
		public var numberOfBoxes:int = 42;
		public var rows:int = 6;
		public var columns:int = 6;
		
		public var currentIndex:uint;
		public var currentIndex2:uint;
		public var selectedOne:Sprite;
		public var selectedTwo:Sprite;
		
		public var c1Color:uint = Math.random() * 0xFFFFFF;
		public var c2Color:uint = Math.random() * 0xFFFFFF;
		public var length1:Number = 20;
		public var length2:Number = 20;
		
		public var dynamicGridArray:Array = new Array();
		public var canvas2PointsArray:Array = new Array();
		public var deletedPointsArray:Array = new Array();
		
		public var gridOneArray:Array = new Array();
		public var canvas1:Sprite = new Sprite();
		public var textOneArray:Array = new Array();
		public var gridOneAlpha:Number = 2/10;
		
		public var canvas2:Sprite = new Sprite();
		public var gridTwoArray:Array = new Array();
		public var textTwoArray:Array = new Array();
		
		public var TextColor:uint = Math.random() * 0x000000;
		
		
		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			
			canvasOne()
			canvasTwo()
			createGridOne() ;
			//trace(canvas2PointsArray)
		
		}
		public function gL(myEvent:Event):void
		{   
			addListeners();
			//trace(gridTwoArray.length+"   "+textfieldsArray.length)
			//trace("normalInd: "+normalIndex+"   deleteAray: "+ deletedPointsArray.length+"   "+deletedPointsArray+"  currentInd2: "+currentIndex2+"   gridLength: "+gridTwoArray.length)
			
			
		}
		public function canvasOne()
		{
			canvas1.graphics.lineStyle(2,0x000000,1);
			canvas1.graphics.beginFill(Math.random()*0xffffff,1)
			canvas1.graphics.drawRect(0,0,600,700);
			canvas1.graphics.endFill();
			canvas1.x = 0;
			canvas1.y = 0;
			addChild(canvas1);
		}
		public function canvasTwo()
		{
			canvas2.graphics.lineStyle(2,0x000000,1);
			canvas2.graphics.beginFill(Math.random()*0xffffff,1)
			canvas2.graphics.drawRect(0,0,600,700);
			canvas2.graphics.endFill();
			canvas2.x = (stage.stageWidth/2);
			canvas2.y = 0;
			addChild(canvas2);
		}
		public function createGridOne() 
		{
			
			for (var i:int = 0; i < numberOfBoxes; i++) 
			{    
				//c1Color = Math.random() * 0xFFFFFF;
				
				gridOneArray[i] = new Sprite();
				gridOneArray[i].graphics.clear();
				gridOneArray[i].graphics.beginFill(c1Color,.5);
				gridOneArray[i].graphics.moveTo(0,0);
				gridOneArray[i].graphics.lineTo(0,-length1);
				gridOneArray[i].graphics.lineTo(length1,-length1);
				gridOneArray[i].graphics.lineTo(length1,length1);
				gridOneArray[i].graphics.lineTo(-length1,length1);
				gridOneArray[i].graphics.lineTo(-length1,-length1);
				gridOneArray[i].graphics.lineTo(0,-length1);
				gridOneArray[i].graphics.endFill();
				
				gridOneArray[i].x = 80+ (i % rows) * (gridOneArray[i].width+50);
				gridOneArray[i].y = 100+int(i / columns) * (gridOneArray[i].height+50);
				
				canvas2PointsArray.push(new Point(gridOneArray[i].x,gridOneArray[i].y));
				dynamicGridArray.push(new Point(gridOneArray[i].x,gridOneArray[i].y));
				
				var TextOneText:TextField = new TextField();
				var TextOneFormat:TextFormat = new TextFormat  ;
				canvas1.addChild(TextOneText);
				canvas1.addChild(gridOneArray[i]);
				
				TextOneText.text = String(i+1);
				TextOneText.textColor = TextColor;  
				TextOneText.width = 16;
				TextOneText.height = 14;
				TextOneText.selectable = false;
				TextOneText.setTextFormat(TextOneFormat);
				TextOneFormat.italic = true; 
				TextOneFormat.size = 10;
				TextOneFormat.font = "Comic Sans MS";
				TextOneFormat.align = TextFormatAlign.CENTER;
				TextOneText.x = gridOneArray[i].x-6;
				TextOneText.y = gridOneArray[i].y-6;
				textOneArray.push(TextOneText);
			}
		}
		public function createGridTwo() 
		{
			
			if(gridTwoArray.length < numberOfBoxes)
			{   
				
				//c2Color = Math.random() * 0xFFFFFF;
				var boxTwo:Sprite = new Sprite();
				boxTwo.graphics.clear();
				boxTwo.graphics.beginFill(c2Color,.5);
				boxTwo.graphics.moveTo(0,0);
				boxTwo.graphics.lineTo(0,-length2);
				boxTwo.graphics.lineTo(length2,-length2);
				boxTwo.graphics.lineTo(length2,length2);
				boxTwo.graphics.lineTo(-length2,length2);
				boxTwo.graphics.lineTo(-length2,-length2);
				boxTwo.graphics.lineTo(0,-length2);
				boxTwo.graphics.endFill();
				
				gridTwoArray.push(boxTwo);
				
				var TextTwoText:TextField = new TextField();
				var TextTwoFormat:TextFormat = new TextFormat  ;
				
				canvas2.addChild(TextTwoText);
				canvas2.addChild(boxTwo);
				
				TextTwoText.text = String(currentIndex+1);
				TextTwoText.textColor = TextColor;  
				TextTwoText.width = 16;
				TextTwoText.height = 14;
				TextTwoText.selectable = false;
				TextTwoText.setTextFormat(TextTwoFormat);
				TextTwoFormat.italic = true; 
				TextTwoFormat.size = 10;
				TextTwoFormat.font = "Comic Sans MS";
				TextTwoFormat.align = TextFormatAlign.CENTER;
				textTwoArray.push(TextTwoText);
				
				
				if(deletedPointsArray.length <= 0)
				{
					boxTwo.x = dynamicGridArray[normalIndex-1].x;
					boxTwo.y = dynamicGridArray[normalIndex-1].y;
					
					TextTwoText.x = dynamicGridArray[normalIndex-1].x-7;
					TextTwoText.y = dynamicGridArray[normalIndex-1].y-4;
					
				}
				if(deletedPointsArray.length > 0)
				{
					boxTwo.x = deletedPointsArray[0].x;
					boxTwo.y = deletedPointsArray[0].y;
					
					TextTwoText.x = deletedPointsArray[0].x-7;
					TextTwoText.y = deletedPointsArray[0].y-4;
				}
				
			}
		
		}

		public function addListeners():void
		{
			
			//deletedPointsArray.sort();
			
			for (var i:uint = 0; i < gridOneArray.length; i++)
			{
				if(gridOneArray[i].alpha >gridOneAlpha)
				{
					gridOneArray[i].buttonMode = true;
					gridOneArray[i].addEventListener(MouseEvent.MOUSE_OVER,gridOneOver);
					gridOneArray[i].addEventListener(MouseEvent.MOUSE_OUT,gridOneOut);
					gridOneArray[i].addEventListener(MouseEvent.CLICK,clickOneHandler);
				}
			}
			for (var a:uint = 0; a < gridTwoArray.length; a++)
			{
				gridTwoArray[a].buttonMode = true;
				gridTwoArray[a].addEventListener(MouseEvent.MOUSE_OVER,gridTwoOver);
				gridTwoArray[a].addEventListener(MouseEvent.MOUSE_OUT,gridTwoOut);
				gridTwoArray[a].addEventListener(MouseEvent.CLICK,clickTwoHandler);
			}
		}
		public function removeListeners():void
		{
			for (var i:uint = 0; i < gridOneArray.length; i++)
			{
				gridOneArray[i].buttonMode = false;
				gridOneArray[i].removeEventListener(MouseEvent.CLICK,clickOneHandler);
			}
		}
		public function removeListeners2():void
		{
			for (var a:uint = 0; a < gridTwoArray.length; a++)
			{
				gridTwoArray[a].buttonMode = false;
				gridTwoArray[a].removeEventListener(MouseEvent.CLICK,clickTwoHandler);
			}
		}
		
		public function clickOneHandler(e:MouseEvent):void
		{
			selectedOne = e.currentTarget as Sprite;
			currentIndex = gridOneArray.indexOf(e.currentTarget);
			
			gridOneArray[currentIndex].alpha = textOneArray[currentIndex].alpha = gridOneAlpha;
			
			normalIndex += 1; 
			if(normalIndex >= numberOfBoxes)
			{
				normalIndex = numberOfBoxes;
			}
			
			createGridTwo() ;
			deletedPointsArray.shift();
			
			//trace(currentIndex+"   "+gridOneArray.length)
			removeListeners();
			
		}
		public function clickTwoHandler(e:MouseEvent):void
		{
			selectedTwo = e.currentTarget as Sprite;
			currentIndex2 = gridTwoArray.indexOf(e.currentTarget);
			
			textTwoArray[currentIndex2].parent.removeChild(textTwoArray[currentIndex2]);
			textTwoArray.splice(currentIndex2,1);
			
			//canvas2PointsArray.splice(currentIndex2,1);
			//deletedPointsArray.splice(currentIndex2,1);
			
			normalIndex -= 1;
			deletedPointsArray.push(new Point(selectedTwo.x,selectedTwo.y));
			
			destroyGridTwo(selectedTwo)
			//destroyGridTwo(gridTwoArray[currentIndex2])
			
			removeListeners2();
		}
		function gridOneOver(e)
		{
			canvas1.addChild(e.currentTarget);
			if(e.currentTarget.alpha >gridOneAlpha)
			{	
				TweenLite.to(e.currentTarget,0.5,{scaleX:1.2, scaleY:1.2,ease:Elastic.easeOut});
			}
		}
		function gridOneOut(e)
		{
			if(e.currentTarget.alpha >gridOneAlpha)
			{	
				TweenLite.to(e.currentTarget,0.5,{scaleX:1, scaleY:1,ease:Elastic.easeOut});
			}
		}
		function gridTwoOver(e)
		{
			canvas2.addChild(e.currentTarget);
			TweenLite.to(e.currentTarget,0.5,{scaleX:1.2, scaleY:1.2,ease:Strong.easeOut});
		}
		function gridTwoOut(e)
		{
			TweenLite.to(e.currentTarget,0.5,{scaleX:1, scaleY:1,ease:Strong.easeOut});
		}
		public function destroyGrid(newG:Sprite):void
		{
			var thisG:Sprite;

			for (var i:uint = 0; i < gridOneArray.length; i++)
			{
				thisG = gridOneArray[i];

				if ((thisG == newG))
				{
					gridOneArray.splice(i,1);
					newG.parent.removeChild(newG) 
					newG = null;
				}
			}
			
		}
		public function destroyGridTwo(newG:Sprite):void
		{
			var thisG:Sprite;

			for (var i:uint = 0; i < gridTwoArray.length; i++)
			{
				thisG = gridTwoArray[i];

				if ((thisG == newG))
				{
					gridTwoArray.splice(i,1);
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
				//trace (canvas2PointsArray.indexOf(80));
				//trace(myArray.indexOf(2));
			}
		}
		
	}

}