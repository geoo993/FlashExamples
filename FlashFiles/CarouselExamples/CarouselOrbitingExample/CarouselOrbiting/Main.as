package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;	import flash.geom.*;
	import fl.motion.Color;
	import com.theflashblog.fp10.*;
	import com.greensock.*;	public class Main extends MovieClip
	{
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		public var color1:uint;
		public var color2:uint;
		
		public var rotationValue:Number;
		public var shapesColor:uint = Math.random() * 0xFFFFFF;
		public var shapesColor2:uint = Math.random() * 0xFFFFFF;
		public var shapesColorTransform = new ColorTransform  ;
		
		public var numOfShapes:uint = 10;
		public var myShapesArray:Array = new Array  ;
		public var containerArray:Array = new Array  ;
		
		public var shapesType:Number = 0;
		public var lengthh:Number = 10;
		public var curvee:Number = 5;
		
		public var toggleAnimation = false;
		public var rotateState:Number = 0;
		
		public var container:MovieClip =  new MovieClip();;
		
		public var currentShapeIndex:uint;
		public var selectedShape:MovieClip;
				public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gloop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			
			//part1
			orbiterr(); 
			
			//part2
			containerr();
		}
				public function gloop(myEvent:Event):void		{
			
			backgroundColorTransition();
			
			if (toggleAnimation == false) 
			{
				if(myShapesArray.length < 10)
				{
					AllShapes();
				}
			}
			if (toggleAnimation == true) 
			{
				removeShapes() ;
			}
			
			//orbitStageShapes();
			orbitCreatedShapes();
			
			addListeners();
		}
		
		///part1
		public function orbiterr()
		{
			orbit.visible = false;
			orbit.x = stage.stageWidth/2;
			orbit.y = stage.stageHeight/2;
			
			orbit.rotationX = 90; //rotate orbit sheet
			for(var i=0; i < orbit.numChildren; i++)
			{ 
				var planet = orbit.getChildAt(i);// get all children of planet
				planet.rotationX = -90; //rotate all the children of planet to -90;
			}
		}
		public function orbitStageShapes()
		{
			rotationValue = (stage.mouseX + stage.stageWidth / 2) * 1.5 ;
			TweenLite.to(orbit,0.5,{rotationY:rotationValue});
			for(var i=0; i<orbit.numChildren; i++)
			{
				var planet = orbit.getChildAt(i);
				TweenLite.to(planet,0.5,{rotationZ:rotationValue});
			}
			SimpleZSorter.sortClips(orbit);
		
		}
		
		
		///part2
		public function containerr()
		{
			addChild(container);
			containerArray.push(container) 
			container.x = stage.stageWidth/2;
			container.y = stage.stageHeight/2;
			
			container.rotationX = 90;
		}
		public function AllShapes()
		{
			shapesType = randomRange(0,4);
			//shapesColor = Math.random() * 0xFFFFFF;
			
			var thisShape:MovieClip = new MovieClip();
			thisShape.graphics.clear();
			thisShape.graphics.beginFill(shapesColor,1);
			
			if (shapesType == 0)
			{
				thisShape.graphics.drawCircle(0,0,lengthh);
			}
			if (shapesType == 1)
			{
				//square
				thisShape.graphics.moveTo(0,0);
				thisShape.graphics.lineTo(0,-lengthh);
				thisShape.graphics.lineTo(lengthh,-lengthh);
				thisShape.graphics.lineTo(lengthh,lengthh);
				thisShape.graphics.lineTo(-lengthh,lengthh);
				thisShape.graphics.lineTo(-lengthh,-lengthh);
				thisShape.graphics.lineTo(0,-lengthh);
			}
			if (shapesType == 2)
			{
				//triangle
				thisShape.graphics.moveTo(0,0);
				thisShape.graphics.lineTo(0,-lengthh);
				thisShape.graphics.lineTo(lengthh,lengthh);
				thisShape.graphics.lineTo(-lengthh,lengthh);
				thisShape.graphics.lineTo(0,-lengthh);
			}
	
			if (shapesType == 3)
			{
				//Diamond
				thisShape.graphics.moveTo(0,0);
				thisShape.graphics.lineTo(0,-lengthh*2);
				thisShape.graphics.lineTo(lengthh,0);
				thisShape.graphics.lineTo(0,lengthh*2);
				thisShape.graphics.lineTo(-lengthh,0);
				thisShape.graphics.lineTo(0,-lengthh*2);
			}
		
			if (shapesType == 4)
			{
				//star
				thisShape.graphics.moveTo(0,0);
				thisShape.graphics.lineTo(-4,-6);
				thisShape.graphics.lineTo(0,-(lengthh*2));
				thisShape.graphics.lineTo(4,-6);
				thisShape.graphics.lineTo((lengthh*2),-3);
				thisShape.graphics.lineTo(6,2);
				thisShape.graphics.lineTo(12,(lengthh*2));
				thisShape.graphics.lineTo(0,8);
				thisShape.graphics.lineTo(-12,(lengthh*2));
				thisShape.graphics.lineTo(-6,2);
				thisShape.graphics.lineTo(-(lengthh*2),-3);
				thisShape.graphics.lineTo(-4,-6);
			}
			thisShape.graphics.endFill();
			
			container.addChild(thisShape);
			myShapesArray.push(thisShape);
			
			var shapesScale:Number = randomRange(2,4);
			thisShape.scaleX = shapesScale;
			thisShape.scaleY = shapesScale;
			
			for (var i:uint = 0; i < myShapesArray.length; i++)
			{
				var pos:Point = Point.polar(400, (i / 10) * Math.PI * 2);
				myShapesArray[i].x = pos.x;
				myShapesArray[i].y = pos.y;
				myShapesArray[i].rotationX = -90; 
			}
				
		}
		public function orbitCreatedShapes()
		{
			
			if(rotateState == 0)
			{
				container.rotationY -= 1;
			}
			
			if(rotateState == 1)
			{
				rotationValue = (stage.mouseX + stage.stageWidth / 2) * 1.5 ;
				TweenLite.to(container,0.5,{rotationY:rotationValue});
				
				for (var o:uint = 0; o < myShapesArray.length; o++)
				{
					TweenLite.to(myShapesArray[o],0.5,{rotationZ:rotationValue});
				}
				
				SimpleZSorter.sortClips(container);
			}
		}
		function removeShapes() 
		{
			for (var i:uint = 0; i < myShapesArray.length; i++)
			{
				shapesDestroyer(myShapesArray[i]);
			}
		}
		public function addListeners():void
		{
			for (var i:uint = 0; i < myShapesArray.length; i++)
			{
				myShapesArray[i].buttonMode = true;
				myShapesArray[i].addEventListener(MouseEvent.CLICK,clickHandler);
			}
		}
		public function removeListeners():void
		{
			for (var i:uint = 0; i < myShapesArray.length; i++)
			{
				myShapesArray[i].buttonMode = false;
				myShapesArray[i].removeEventListener(MouseEvent.CLICK,clickHandler);
			}
		}
		public function clickHandler(e:MouseEvent):void
		{
			selectedShape = e.currentTarget as MovieClip;
			currentShapeIndex = myShapesArray.indexOf(e.currentTarget);
		
			trace(currentShapeIndex);
			removeListeners();
			
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
			if(curVal <= 0)
			{   
				colorTransSwitch = "goingUp";
				color2 = Math.random() * 0xFFFFFF;
				
				shapesColor2 = Math.random() * 0xFFFFFF;
			}
			if(curVal >= 1)
			{
				color1 = Math.random() * 0xFFFFFF;
				colorTransSwitch = "goingDown"
				
				shapesColor  = Math.random() * 0xFFFFFF;
			}
			
			curVal = colorTransNum/255;
			stage.color = Color.interpolateColor(color1,color2,curVal);
			
			for (var i:uint = 0; i < myShapesArray.length; i++)
			{
				shapesColorTransform.color = Color.interpolateColor(shapesColor,shapesColor2,curVal);
				myShapesArray[i].transform.colorTransform = shapesColorTransform;
			}
		}
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
		public function shapesDestroyer(myShapes:MovieClip)
		{
			var thisShape:MovieClip;

			for (var i:uint = 0; i < myShapesArray.length; i++)
			{
				thisShape = myShapesArray[i];

				if (thisShape == myShapes)
				{
					myShapesArray.splice(i,1);	
					myShapes.parent.removeChild(myShapes) 
				}
			}
		}
		public function kDown(event:KeyboardEvent):void
		{
			if (event.keyCode == 32)
			{   
				toggleAnimation = !toggleAnimation;
				rotateState = randomRange(0,1);
			}
		}
			}}