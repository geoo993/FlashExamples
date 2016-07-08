package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;	import flash.geom.*;
	import fl.motion.Color;
	import com.cartogrammar.drawing.CubicBezier;
		public class Main extends MovieClip
	{
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		public var color1:uint;
		public var color2:uint;
		
		public var curveShapeColor:uint = Math.random() * 0xFFFFFF;
		public var dotColor:uint = Math.random() * 0xFFFFFF;
		public var line1Color:uint = Math.random() * 0xFFFFFF;
		public var line2Color:uint = Math.random() * 0xFFFFFF;
		
		//public var points:Array = new Array(new Point(47,109),new Point(112,72),new Point(145,192),new Point(300,299));
		public var dotsArray:Array = new Array();
		public var points:Array = new Array();
		public var curveArray:Array = new Array();
		
		public var selectedDot:Sprite;
		public var curves:Sprite = new Sprite();
		
		public var newPointX:Number;
		public var newPointY:Number;
		public var numberOfPoints:Number = 5;
		public var dotRadius:Number = 15;
		public var linesTransparency:Number;
		public var curvesState:Boolean = true;
		public var curveFillState:Boolean = false;
		public var curveFill:Number;
		
		public var toggleAnimation = false;
		public var curveCreator:String = "idle";
				public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gloop);
			addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			stage.addEventListener(MouseEvent.CLICK,handleClick);
			
			drawDots()
		}
		public function drawPoints()
		{
			if(points.length < numberOfPoints)
			{   
				for(var i:int = 0; i < numberOfPoints; i++)
				{
					newPointX = randomRange(50,stage.stageWidth-100)
					newPointY = randomRange(50,stage.stageHeight-100)
					var p:Point = new Point(newPointX,newPointY);
					points.push(p);     
				}
			}
		}
		public function drawDots()
		{
			drawPoints();
			curves = new Sprite();
			for (var i:uint=0 ; i<points.length;i++)
			{
				var dot:Sprite = new Dotss();
				with(dot.graphics) beginFill(dotColor), drawCircle(0,0,dotRadius); 
				dot.x = points[i].x;
				dot.y = points[i].y;
				curves.addChild(dot);
				dotsArray[i] = dot;
			}
		}
		public function drawCurves()
		{
			curves.graphics.clear();
			curves.graphics.lineStyle(2,line1Color,linesTransparency);
			//curves.graphics.beginFill(curveShapeColor); // fill1
			CubicBezier.curveThroughPoints(curves.graphics,points,.5,.75);
		
			curves.graphics.lineStyle(0.5,line2Color,linesTransparency);
			
			curves.graphics.beginFill(curveShapeColor,curveFill);// fill2
			curves.graphics.moveTo(points[0].x, points[0].y);
			//curves.graphics.endFill();//endfill1
			for (var i:uint = 1; i < points.length-2; i ++)
			{
				var xc:Number = (points[i].x + points[i + 1].x) / 2;
				var yc:Number = (points[i].y + points[i + 1].y) / 2;
				curves.graphics.curveTo(points[i].x, points[i].y, xc, yc);
			}
			
			curves.graphics.curveTo(points[i].x, points[i].y, points[i+1].x, points[i+1].y);
			curves.graphics.endFill();//endfill2
			
			addChild(curves);
			curveArray.push(curves);
			
			if(curveArray.length > 1)
			{
				curveArray.pop();
			}
			
		}
		public function newPointOnClick()
		{
			var newPx:Number = stage.mouseX;
			var newPy:Number = stage.mouseY;
			var newP:Point = new Point(newPx,newPy);
			points.push(newP); 
			
			var newDot:Sprite = new Dotss();
			with(newDot.graphics) beginFill(dotColor), drawCircle(0,0,dotRadius); 
			newDot.x = newPx;
			newDot.y = newPy;
			dotsArray.push(newDot);
			addChild(newDot);
			
			drawCurves();
		}		public function gloop(myEvent:Event):void		{     
			//trace(dotsArray.length+"  "+points.length+"  "+curveArray.length+"  "+curveCreator)
			backgroundColorTransition();
			
			if(curveCreator == "create")
			{ 
				drawPoints()
				curveCreator = "draw";
			}
			if(curveCreator == "draw")
			{   
				drawCurves();
				
				for (var d:uint=0 ; d < dotsArray.length;d++)
				{
					if(curvesState == true)
					{
						linesTransparency = 1; 
						dotsArray[d].buttonMode = true;
						dotsArray[d].visible = true;
					}
					if(curvesState == false)
					{
						linesTransparency = 0; 
						dotsArray[d].visible = false;
					}
				}
				
				if(curveFillState == false)
				{
					curveFill = 0;
				}
				if(curveFillState == true)
				{
					curveFill = 1;
				}
			
			}
			if(curveCreator == "remove")
			{
				curves.graphics.clear();
			}
			
		}
		
		public function changeColorr()
		{
			curveShapeColor = Math.random() * 0xFFFFFF;
			line1Color = Math.random() * 0xFFFFFF;
			line2Color = Math.random() * 0xFFFFFF;
		}
		public function backgroundColorTransition()
		{
			if(colorTransSwitch == "goingUp")
			{
				colorTransNum += .5;
			}
			if(colorTransSwitch == "goingDown")
			{
				colorTransNum -= .5; 
			}
			if(curVal <= 0)
			{   
				colorTransSwitch = "goingUp";
				color2 = Math.random() * 0xFFFFFF;
			}
			if(curVal >= 1)
			{
				color1 = Math.random() * 0xFFFFFF;
				colorTransSwitch = "goingDown"
			}
			
			curVal = colorTransNum/255;
			stage.color = Color.interpolateColor(color1,color2,curVal);
			
		}
		public function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
		public function onMouseDown(evt:MouseEvent)
		{
			if(curveCreator == "draw" && curvesState == true)
			{
				if (evt.target is Dotss)
				{
					selectedDot = evt.target as Sprite;
					stage.addEventListener(MouseEvent.MOUSE_MOVE,moveDot);
					stage.addEventListener(MouseEvent.MOUSE_UP,releaseDot);
				}
			}
		}
		public function moveDot(evt:MouseEvent)
		{
			if(curveCreator == "draw" && curvesState == true)
			{
				var currentIndex = dotsArray.indexOf(selectedDot);
				points[currentIndex].x = selectedDot.x = curves.mouseX;
				points[currentIndex].y = selectedDot.y = curves.mouseY;
				drawCurves();
			}
		}
		public function releaseDot(e:MouseEvent)
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,moveDot);
			stage.removeEventListener(MouseEvent.MOUSE_UP,releaseDot);
		}
		function handleClick(evt:MouseEvent):void 
		{
			if(evt.target == dBut)
			{
				if (toggleAnimation == false) 
				{
					curveCreator = "create";
					
					toggleAnimation = true;
				}
				else
				{
					curveCreator = "remove";
					for (var d:uint=0 ; d < dotsArray.length;d++)
					{
						dotsArray[d].visible = false;
					}
					toggleAnimation = false;
					
				}
				return; 
			}
				
			if(curveCreator == "draw")
			{   
				if(evt.target == cFill)
				{
					curveFillState = !curveFillState;
					return;
				}
				if(evt.target == laBut)
				{
					curvesState = !curvesState;
					return; 
				}
				if(evt.target == colorBut)
				{
					changeColorr();
					return; 
				}
				
				if (evt.target is Dotss) 
				{ 
					return; 
				}
				
				if(curvesState == true)
				{
					newPointOnClick()
				}
			}
		}
			}}