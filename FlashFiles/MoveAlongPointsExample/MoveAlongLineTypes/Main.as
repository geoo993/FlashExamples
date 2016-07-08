package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;	import flash.geom.*;
	import fl.motion.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.senocular.drawing.Path;	public class Main extends Sprite	{
		public var cColor:uint = Math.random()*0xffffff;
		public var mColor:uint = Math.random()*0xffffff;
		public var sColor:uint = Math.random() * 0xFFFFFF;
		public var dColor:uint = Math.random() * 0xFFFFFF;
		
		public var countriesArray:Array = new Array();
		
		public var points:Array = new Array(
		new Point(100, 50), new Point(200, 50), new Point(300, 50),
		new Point(400, 50), new Point(400, 150), new Point(500, 150), new Point(600, 150), new Point(700, 150), 
		new Point(700, 250), new Point(700, 350), new Point(700, 450), new Point(700, 550), 
		new Point(600, 600), new Point(500, 600), new Point(400, 600),
		new Point(400, 500), new Point(300, 500), new Point(200, 500), new Point(100, 500),
		new Point(100, 400), new Point(100, 340), new Point(100, 240),new Point(100, 100));
		
		public var mArray:Array = new Array();
		public var dotsArray:Array = new Array();
		public var sArray:Array = new Array();;
		
		public var canvas:Sprite;
		public var d:Sprite;
		public var s:Sprite = new Sprite();;
		
		public var curvesBall:Sprite = new Sprite();;
		public var linesBall:Sprite = new Sprite();
		
		public var rad:int = 10;
		public var sAplha:Number = .1;
		
		public var xPos:Number;
		public var yPos:Number;
		
		public var thisIndex:int;
		public var currentIndex:int = 0;
		public var selectedDot:Sprite;
		
		public var pause:Boolean = false;
		public var shapeType:String = "Lines";
		
		public var curvePath:Path = new Path();
		public var pathPoints:Point = new Point();
		public var DistPercentage:Number = 0;
		public var ballsSpeed:Number = .005;
		
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		public var color1:uint;
		public var color2:uint;
				public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(MouseEvent.CLICK,mClick);
			addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			
			createCanvas()
			
			drawDots();
			drawShape();
			
			createCurveBall();		}				public function gL(myEvent:Event):void		{   
			//trace(curvePath.length+"  "+DistPercentage)
			//trace(dotsArray.length+"   "+mArray.length+"  "+sArray.length) 
			Movement();
			backgroundColorTransition();
			
			sTypeText.text = String(shapeType);		}
		public function createCanvas()
		{
			canvas = new Sprite()
			canvas.x = 200
			addChild(canvas); 
			
		}
		public function drawDots()
		{
			
			for(var i:uint = 0; i<points.length; i++)
			{
				d = new Dots();
				d.buttonMode = true;
				d.graphics.clear();
				d.graphics.lineStyle(4,dColor,1);
				d.graphics.beginFill(dColor,1);
				d.graphics.drawCircle(0, 0, rad);
				
				d.graphics.endFill();
			
				canvas.addChild(d);
				dotsArray.push(d);
				
				d.x = points[i].x;
				d.y = points[i].y;
			}
			
		}
		function drawShape():void
		{
			curvePath.clear();
			s.graphics.clear();
			s.graphics.lineStyle(4,sColor,1); 
			s.graphics.beginFill(sColor,sAplha);
			
			if(shapeType == "Curves")
			{
				curvePath.moveTo(points[i].x, points[i].x);
				//s.graphics.moveTo(points[i].x, points[i].y);
				
				for (var i:uint = 0; i < points.length-2; i ++)
				{
					var xCurve:Number = (points[i].x + points[i+1].x) / 2;
					var yCurve:Number = (points[i].y + points[i+1].y) / 2;
					
					//s.graphics.curveTo(points[i].x, points[i].y, xCurve, yCurve);
					curvePath.curveTo(points[i].x, points[i].y, xCurve, yCurve);
				}
				//s.graphics.curveTo(points[i].x, points[i].y, points[i+1].x, points[i+1].y);
				
				curvePath.curveTo(points[i].x, points[i].y, points[i+1].x, points[i+1].y);
				curvePath.draw(s.graphics);
				
				curvesBall.visible = true;
				//pause = true;
			}
			
			if(shapeType == "Lines")
			{
				s.graphics.moveTo(points[0].x,points[0].y);
				for (var a:uint = 1; a < points.length; a ++)
				{
					s.graphics.lineTo(points[a].x,points[a].y);
				}
				s.graphics.lineTo(points[i].x, points[i].y);
				curvesBall.visible = false;
				//pause = false;
			}
			
			curvesBall.graphics.beginFill(cColor, 1);
			curvesBall.graphics.drawCircle(0, 0, 10);
			curvesBall.graphics.endFill();
			
			s.addChild(curvesBall);
			
			s.graphics.endFill();
			canvas.addChildAt(s,0);
			sArray.push(s); 
			
			if(sArray.length > 1)
			{
				sArray.pop(); 
				//while (numChildren>0) removeChildAt(0);
				//sArray.splice(0);
			}
			
		}
		public function createCurveBall()
		{
			
			linesBall.graphics.clear();
			linesBall.graphics.beginFill(mColor,1);
			linesBall.graphics.drawCircle(0,0,10);
			linesBall.graphics.endFill();
			
			linesBall.x = points[0].x
			linesBall.y = points[0].y
			canvas.addChild(linesBall);
			mArray.push(linesBall);
			
			if(mArray.length>1)
			{
				mArray.pop();
			}
			
		}
		
		public function Movement()
		{   
			//lineball
			var getDistanceTo:Number = getDistances(points[currentIndex].x - linesBall.x, points[currentIndex].y - linesBall.y);
			if(getDistanceTo<5)
			{
				currentIndex++
				if (currentIndex >= points.length)
				{
					currentIndex = 0;
					//currentIndex = dotsArray.length-1;
				}
			} 
			if(pause == false)
			{
				TweenMax.to(linesBall, 1, {x:points[currentIndex].x, y:points[currentIndex].y});
			}
			
			//curveball
			DistPercentage += ballsSpeed;
			pathPoints = curvePath.pointAt(DistPercentage);
			curvesBall.x = pathPoints.x;
			curvesBall.y = pathPoints.y;
			if(DistPercentage>=1)
			{
				//ballsSpeed *= -1;
				DistPercentage = 0;
			}
			/*if(DistPercentage<=0)
			{
				ballsSpeed *= -1;
			}*/
			
		}		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}		public function getDistances(delta_x:Number, delta_y:Number):Number
		{
			return Math.sqrt((delta_x*delta_x)+(delta_y*delta_y));
		}
		public function onMouseDown(e:MouseEvent)
		{
			if (e.target is Dots)
			{
				selectedDot = e.target as Sprite; 
				thisIndex = dotsArray.indexOf(selectedDot);
				stage.addEventListener(MouseEvent.MOUSE_MOVE,moveDot);
				stage.addEventListener(MouseEvent.MOUSE_UP,releaseDot);
			}
		}
		public function moveDot(e:MouseEvent)
		{
			
			points[thisIndex].x = selectedDot.x = s.mouseX;
			points[thisIndex].y = selectedDot.y = s.mouseY;
			drawShape();
			
		}
		public function releaseDot(e:MouseEvent)
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,moveDot);
			stage.removeEventListener(MouseEvent.MOUSE_UP,releaseDot);
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
			}
			if(curVal >= 1)
			{
				color1 = Math.random() * 0xFFFFFF;
				colorTransSwitch = "goingDown"
			}
			
			curVal = colorTransNum/255;
			stage.color = Color.interpolateColor(color1,color2,curVal);
			
		}
		public function mClick(e:MouseEvent)
		{
			if (e.target is Dots) 
			{ 
				return; 
			}
			
			sColor = Math.random()*0xFFFFFF;
			cColor = Math.random()*0xffffff;
			sAplha = Math.random()*.5;
			
			if(shapeType =="Curves")
			{
				shapeType = "Lines";
			}
			else if(shapeType == "Lines")
			{
				shapeType = "Curves";
			}
			drawShape();
		}	}}