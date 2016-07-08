package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;	import flash.geom.*;
	import fl.motion.Color;
	//import com.cartogrammar.drawing.CubicBezier;
		public class Main extends Sprite
	{
		public var sColor:uint = Math.random() * 0xFFFFFF;
		public var dColor:uint = Math.random() * 0xFFFFFF;
		
		public var points:Array = new Array(
		new Point(50, 50), new Point(100, 50), new Point(200, 50), new Point(300, 50),
		new Point(300, 100), new Point(400, 100), new Point(500, 100), new Point(600, 100), new Point(700, 100), 
		new Point(800, 100), new Point(900, 100), new Point(900, 200), new Point(800, 200), new Point(700, 200), 
		new Point(600, 200), new Point(500, 200), new Point(500, 300), new Point(400, 300), new Point(300, 300),
		new Point(300, 400), new Point(300, 500), new Point(300, 600), new Point(300, 650),
		new Point(200, 650), new Point(200, 600), new Point(200, 500), new Point(200, 400), new Point(200, 300),
		new Point(100, 300), new Point(50, 300), new Point(50, 200), new Point(50, 100))//,new Point(50, 50));
			
		public var dotsArray:Array = new Array();
		public var sArray:Array = new Array();;
		
		public var canvas:Sprite;
		public var d:Sprite;
		public var s:Sprite = new Sprite();;
		
		public var selectedDot:Sprite;
		public var currentIndex:uint;
		
		public var rad:int = 10;
		
		public var shapeType:Boolean = true;
				public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gloop);
			stage.addEventListener(MouseEvent.CLICK,mClick);
			addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			
			stage.color = Math.random()*0xFFFFFF;
			
			createCanvas();
			
			drawDots();
			drawShape();
		}
		public function gloop(myEvent:Event):void
		{ 
			//trace(points.length+"  "+dotsArray.length+"  "+sArray.length)
			
		}
		
		public function createCanvas()
		{
			canvas = new Sprite()
			canvas.x = 100;
			canvas.y = 10;
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
			
			s.graphics.clear();
			s.graphics.lineStyle(4,sColor,1);
			s.graphics.beginFill(sColor,.5);
			
			if(shapeType == false)
			{
				s.graphics.moveTo(dotsArray[i].x, dotsArray[i].y);
				for (var i:uint = 1; i < dotsArray.length-2; i ++)
				{
					var xCurve:Number = (dotsArray[i].x + dotsArray[i + 1].x) / 2;
					var yCurve:Number = (dotsArray[i].y + dotsArray[i + 1].y) / 2;
					s.graphics.curveTo(dotsArray[i].x, dotsArray[i].y, xCurve, yCurve);
				}
				s.graphics.curveTo(dotsArray[i].x, dotsArray[i].y, dotsArray[i+1].x, dotsArray[i+1].y);
				//s.graphics.curveTo(dotsArray[31].x, dotsArray[31].y, dotsArray[0].x, dotsArray[0].y);
			}
			if(shapeType == true)
			{
			
				s.graphics.moveTo(dotsArray[0].x,dotsArray[0].y);
				s.graphics.lineTo(dotsArray[1].x,dotsArray[1].y);
				s.graphics.lineTo(dotsArray[2].x,dotsArray[2].y);
				s.graphics.lineTo(dotsArray[3].x,dotsArray[3].y);
				s.graphics.lineTo(dotsArray[4].x,dotsArray[4].y);
				s.graphics.lineTo(dotsArray[5].x,dotsArray[5].y);
				s.graphics.lineTo(dotsArray[6].x,dotsArray[6].y);
				s.graphics.lineTo(dotsArray[7].x,dotsArray[7].y);
				s.graphics.lineTo(dotsArray[8].x,dotsArray[8].y);
				s.graphics.lineTo(dotsArray[9].x,dotsArray[9].y);
				s.graphics.lineTo(dotsArray[10].x,dotsArray[10].y);
				s.graphics.lineTo(dotsArray[11].x,dotsArray[11].y);
				s.graphics.lineTo(dotsArray[12].x,dotsArray[12].y);
				s.graphics.lineTo(dotsArray[13].x,dotsArray[13].y);
				s.graphics.lineTo(dotsArray[14].x,dotsArray[14].y);
				s.graphics.lineTo(dotsArray[15].x,dotsArray[15].y);
				s.graphics.lineTo(dotsArray[16].x,dotsArray[16].y);
				s.graphics.lineTo(dotsArray[17].x,dotsArray[17].y);
				s.graphics.lineTo(dotsArray[18].x,dotsArray[18].y);
				s.graphics.lineTo(dotsArray[19].x,dotsArray[19].y);
				s.graphics.lineTo(dotsArray[20].x,dotsArray[20].y);
				s.graphics.lineTo(dotsArray[21].x,dotsArray[21].y);
				s.graphics.lineTo(dotsArray[22].x,dotsArray[22].y);
				s.graphics.lineTo(dotsArray[23].x,dotsArray[23].y);
				s.graphics.lineTo(dotsArray[24].x,dotsArray[24].y);
				s.graphics.lineTo(dotsArray[25].x,dotsArray[25].y);
				s.graphics.lineTo(dotsArray[26].x,dotsArray[26].y);
				s.graphics.lineTo(dotsArray[27].x,dotsArray[27].y);
				s.graphics.lineTo(dotsArray[28].x,dotsArray[28].y);
				s.graphics.lineTo(dotsArray[29].x,dotsArray[29].y);
				s.graphics.lineTo(dotsArray[30].x,dotsArray[30].y);
				s.graphics.lineTo(dotsArray[31].x,dotsArray[31].y);
				//s.graphics.lineTo(dotsArray[0].x,dotsArray[0].y);
			}
			
			s.graphics.endFill();
			canvas.addChildAt(s,1);
			sArray.push(s); 
			
			if(sArray.length > 1)
			{
				sArray.pop(); 
				//while (numChildren>0) removeChildAt(0);
				//sArray.splice(0);
			}
			
		}
		public function onMouseDown(e:MouseEvent)
		{
			if (e.target is Dots)
			{
				selectedDot = e.target as Sprite;
				stage.addEventListener(MouseEvent.MOUSE_MOVE,moveDot);
				stage.addEventListener(MouseEvent.MOUSE_UP,releaseDot);
			}
		}
		public function moveDot(e:MouseEvent)
		{
			currentIndex = dotsArray.indexOf(selectedDot);
			points[currentIndex].x = selectedDot.x = s.mouseX;
			points[currentIndex].y = selectedDot.y = s.mouseY;
			drawShape();
			
		}
		public function releaseDot(e:MouseEvent)
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,moveDot);
			stage.removeEventListener(MouseEvent.MOUSE_UP,releaseDot);
		}
		
		public function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
		
		public function mClick(e:MouseEvent)
		{
			if (e.target is Dots) 
			{ 
				return; 
			}
			
			stage.color = Math.random()*0xFFFFFF;
			sColor = Math.random() * 0xFFFFFF;
			
			shapeType = !shapeType;
			drawShape();
		}
		}}