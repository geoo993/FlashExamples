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
		public var mainIndex:int = 0;
		public var numberOfBoxes:int = 42;
		public var rows:int = 6;
		public var columns:int = 6;
		
		public var currentIndex:uint;
		public var currentIndex2:uint;
		public var selectedOne:Sprite;
		public var selectedTwo:Sprite;
		
		public var boxesColorState:Boolean = false;
		public var boxesColorTransform = new ColorTransform  ;
		public var b1Color:uint = Math.random() * 0xFFFFFF;
		public var b2Color;
		public var length1:Number = 20;
		public var length2:Number = 20;
		
		public var dynamicGridArray:Array = new Array();
		public var dynamicGridStringArray:Array = new Array()
		public var pointsIndexArray:Array = new Array();
		
		public var gridOneArray:Array = new Array();
		public var canvas1:Sprite = new Sprite();
		public var textOneArray:Array = new Array();
		public var gridOneAlpha:Number = 1/10;
		
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
			boxesColor();
			pointsIndexArray.sort(Array.NUMERIC);
			
			//trace(dynamicGridStringArray.indexOf("(x=350, y=100)"));
			//trace(dynamicGridStringArray)
			trace(pointsIndexArray)
			trace(mainIndex) 
			
			//trace(gridTwoArray.length+"   "+textfieldsArray.length)
			//trace("mainIndex: "+mainIndex+"   GridTwoPoints Lefts: "+ pointsIndexArray.length+"  current Clicked Index: "+currentIndex2+"   gridTwo Length: "+gridTwoArray.length)
			
		}
		public function boxesColor()
		{    
			
			if(boxesColorState == false)
			{  
				for (var i:uint = 0; i < gridOneArray.length; i++)
				{
					b1Color = Math.random() * 0xFFFFFF;
					boxesColorTransform.color = b1Color;
					gridOneArray[i].transform.colorTransform = boxesColorTransform;
				}  
				boxesColorState = true;
			}
			
			//trace(b1Color.toString(16)+"  "+gridOneArray[currentIndex].transform.colorTransform.color.toString(16))
		}
		public function canvasOne()
		{
			canvas1.graphics.lineStyle(2,0x000000,1);
			canvas1.graphics.beginFill(Math.random()*0xffffff,.2)
			canvas1.graphics.drawRect(0,0,550,650);
			canvas1.graphics.endFill();
			canvas1.x = 50;
			canvas1.y = 25;
			addChild(canvas1);
		}
		public function canvasTwo()
		{
			canvas2.graphics.lineStyle(2,0x000000,1);
			canvas2.graphics.beginFill(Math.random()*0xffffff,.2)
			canvas2.graphics.drawRect(0,0,550,650);
			canvas2.graphics.endFill();
			canvas2.x = (stage.stageWidth/2);
			canvas2.y = 25;
			addChild(canvas2);
		}
		public function createGridOne() 
		{
			for (var i:int = 0; i < numberOfBoxes; i++) 
			{    
				gridOneArray[i] = new Sprite();
				gridOneArray[i].graphics.clear();
				gridOneArray[i].graphics.beginFill(0x000000,1);
				gridOneArray[i].graphics.moveTo(0,0);
				gridOneArray[i].graphics.lineTo(0,-length1);
				gridOneArray[i].graphics.lineTo(length1,-length1);
				gridOneArray[i].graphics.lineTo(length1,length1);
				gridOneArray[i].graphics.lineTo(-length1,length1);
				gridOneArray[i].graphics.lineTo(-length1,-length1);
				gridOneArray[i].graphics.lineTo(0,-length1);
				gridOneArray[i].graphics.endFill();
				
				gridOneArray[i].x = 70+ (i % rows) * (gridOneArray[i].width+40);
				gridOneArray[i].y = 50+int(i / columns) * (gridOneArray[i].height+50);
				canvas1.addChild(gridOneArray[i]);
				
				dynamicGridArray.push(new Point(gridOneArray[i].x,gridOneArray[i].y));
				dynamicGridStringArray.push(String(new Point(gridOneArray[i].x,gridOneArray[i].y)))
				pointsIndexArray.push(dynamicGridArray.length-1)
				
				var TextOneText:TextField = new TextField();
				var TextOneFormat:TextFormat = new TextFormat  ;
				gridOneArray[i].addChild(TextOneText);
				
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
				TextOneText.x = 20;
				TextOneText.y = 5;
				textOneArray.push(TextOneText);
			}
		}
		public function createGridTwo() 
		{
			
			if(gridTwoArray.length < numberOfBoxes)
			{   
				
				var boxTwo:Sprite = new Sprite();
				boxTwo.graphics.clear();
				boxTwo.graphics.beginFill(b2Color,1);
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
				boxTwo.addChild(TextTwoText);
				
				mainIndex = pointsIndexArray[0];
				
				boxTwo.x = dynamicGridArray[mainIndex].x;
				boxTwo.y = dynamicGridArray[mainIndex].y;
				
				TextTwoText.x = 20;
				TextTwoText.y = 5;
				
				//pointsIndexArray.splice(pointsIndexArray.indexOf(gridTwoArray.length-1), 1);
				pointsIndexArray.shift()
				
			}
		
		}

		public function addListeners():void
		{
			
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
			
			b2Color = "0x"+gridOneArray[currentIndex].transform.colorTransform.color.toString(16);
			gridOneArray[currentIndex].alpha = textOneArray[currentIndex].alpha = gridOneAlpha;
			
			createGridTwo() ;
			
			//trace(currentIndex+"   "+gridOneArray.length)
			removeListeners();
			
		}
		public function clickTwoHandler(e:MouseEvent):void
		{
			selectedTwo = e.currentTarget as Sprite;
			currentIndex2 = gridTwoArray.indexOf(e.currentTarget);
			
			textTwoArray[currentIndex2].parent.removeChild(textTwoArray[currentIndex2]);
			textTwoArray.splice(currentIndex2,1);
	
			//trace(dynamicGridStringArray.indexOf("(x="+String(selectedTwo.x)+", y="+String(selectedTwo.y)+")"));
			pointsIndexArray.push(dynamicGridStringArray.indexOf("(x="+String(selectedTwo.x)+", y="+String(selectedTwo.y)+")"))
			
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
				
			}
		}
		
	}

}