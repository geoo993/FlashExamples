package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;	import flash.geom.*;
	import fl.motion.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	//import com.cartogrammar.drawing.CubicBezier;
	import traer.physics.Attraction;
	import traer.physics.Particle;
	import traer.physics.ParticleSystem;
	import traer.physics.Spring;
		public class Main extends Sprite
	{
		public var dArray:Array = new Array();
		public var sArray:Array = new Array();;
		public var sky:Array = new Array();
		public var earth:Array = new Array();
		public var floats = new Array();
		
		//public var points:Array = new Array(
		//new Point(150, 50), new Point(200, 50), 
		//new Point(300, 50), new Point(400, 50),
		//new Point(400, 100), new Point(500, 100), 
		//new Point(600, 100), new Point(700, 100), 
		//new Point(700, 100), new Point(900, 100), 
		//new Point(1000, 100), new Point(1000, 200), 
		//new Point(900, 200), new Point(800, 200), 
		//new Point(700, 200), new Point(600, 200), 
		//new Point(600, 300), new Point(500, 300), 
		//new Point(400, 300), new Point(400, 400), 
		//new Point(400, 500), new Point(400, 600), 
		//new Point(400, 650), new Point(300, 650), 
		//new Point(300, 600), new Point(300, 500), 
		//new Point(300, 400), new Point(300, 300),
		//new Point(200, 300), new Point(150, 300), 
		//new Point(150, 200), new Point(150, 100))//,new Point(150, 50));
		
		public var points:Array = new Array(
		new Point(350, 290), new Point(290, 200), 
		new Point(300, 130), new Point(360, 80),
		new Point(450, 90), new Point(500, 120),
		new Point(530, 180), new Point(500, 280),

		new Point(590, 240), new Point(680, 240), 
		new Point(740, 290), new Point(760, 350),
		new Point(730, 400), new Point(680, 420), 
		new Point(600, 410), new Point(530, 380), 
		
		new Point(570, 430), new Point(640, 470), 
		new Point(700, 520), new Point(720, 570), 
		new Point(700, 640), new Point(630, 660), 
		new Point(550, 630), new Point(520, 520),
		
		new Point(480, 580), new Point(460, 640), 
		new Point(380, 660), new Point(300, 630),
		new Point(250, 570), new Point(270, 500),
		new Point(300, 450), new Point(360, 400),
		
		new Point(300, 400), new Point(230, 420), 
		new Point(140, 390), new Point(100, 320),
		new Point(110, 250), new Point(160, 210),
		new Point(240, 220), new Point(300, 260));
			
			
			
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		public var color1:uint;
		public var color2:uint;
			
		public var sColor:uint = Math.random() * 0xFFFFFF;
		public var dColor:uint = Math.random() * 0xFFFFFF;
		public var cColor:uint = Math.random() * 0xFFFFFF;
		
		public var canvas:Sprite;
		public var d:Sprite;
		public var jellyShape:Sprite = new Sprite();;

		public var shapeType:String = "Cubic";
		
		public var circle:MovieClip = new MovieClip();
		
		public var numberOfPoint:int = 40//points and dotsArray length;
		public var elasticity:Number = 4000;
		public var flow:Number = .5;
		
		public var circleW:int = 60;
		
		public var s:ParticleSystem = new ParticleSystem(new Vector3D(0, 0, 0), .2);
		public var magnet = s.makeParticle(25, new Vector3D(0, 0, 0));
		
		
				public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gloop);
			stage.addEventListener(MouseEvent.CLICK,mClick);
			
			createCanvas();
			drawDots();
			
			jellyPhysics()
			createCircles();
			
			//stage.color = Math.random()*0xFFFFFF;
			
		}
		public function jellyPhysics()
		{
			magnet.makeFixed();
			
			for(var i:uint = 0; i < numberOfPoint; i++)
			{
				sky[i] = s.makeParticle(0, new Vector3D(points[i].x, points[i].y-100, 0)); sky[i].makeFixed();
				floats[i]= s.makeParticle(flow, new Vector3D(points[i].x, points[i].y, 0));
				earth[i] = s.makeParticle(0, new Vector3D(points[i].x, points[i].y+100, 0)); earth[i].makeFixed();
				
				if(i>0)
				{
					s.makeSpring(floats[i], floats[i], 0.1 , .05, 0);
					s.makeSpring(sky[i], floats[i], .05 , .05, 0);
					s.makeSpring(earth[i], floats[i], .05 , .05, 0);
					
				    s.makeAttraction(magnet, floats[i], -elasticity , 0);
					
				}
				
			}
		}
		public function gloop(myEvent:Event):void
		{ 
			//trace(points.length+"  "+dotsArray.length+"  "+sArray.length)
			//sTypeText.text = String(shapeType);
			
			backgroundColorTransition();
			drawShape();
			s.tick(1);
			
			magnet.position.x = circle.x = mouseX ;
			magnet.position.y = circle.y = mouseY ;
			
			
			for(var i:uint=0; i< numberOfPoint; i++)
			{
				points[i] = new Point(floats[i].position.x, floats[i].position.y);
				
				dArray[i].x = floats[i].position.x;
				dArray[i].y = floats[i].position.y;
			}
			
			
		}
		public function createCanvas()
		{
			canvas = new Sprite()
			addChild(canvas); 
			
		}
		public function drawDots()
		{
			
			for(var s:uint = 0; s< points.length; s++)
			{
				d = new Sprite();
				d.buttonMode = true;
				d.graphics.clear();
				d.graphics.lineStyle(4,dColor,1);
				d.graphics.beginFill(dColor,1);
				
				d.graphics.drawCircle(0, 0, 10);
				
				d.graphics.endFill();
			
				canvas.addChildAt(d,0);
				dArray.push(d);
				
			}
		}
		
		function drawShape():void
		{
			
			jellyShape.graphics.clear();
			jellyShape.graphics.lineStyle(4,sColor,1);
			jellyShape.graphics.beginFill(sColor,.5);
			
			if(shapeType == "Cubic")
			{
				jellyShape.graphics.moveTo(points[0].x, points[0].y);
				for (var i:uint = 1; i < points.length-2; i ++)
				{
					var xCurve:Number = (points[i].x + points[i + 1].x) / 2;
					var yCurve:Number = (points[i].y + points[i + 1].y) / 2;
					jellyShape.graphics.curveTo(points[i].x, points[i].y, xCurve, yCurve);
				}
			
				//curve
				jellyShape.graphics.curveTo(points[i].x, points[i].y, points[i+1].x, points[i+1].y);
			}
			if(shapeType == "Linear")
			{
				jellyShape.graphics.moveTo(points[0].x,points[0].y);
				for (var a:uint = 1; a < points.length; a ++)
				{
					jellyShape.graphics.lineTo(points[a].x,points[a].y);
				}
			}
			
			jellyShape.graphics.endFill();
			canvas.addChildAt(jellyShape,1);
			sArray.push(jellyShape); 
			
			if(sArray.length > 1)
			{
				sArray.pop(); 
				//while (numChildren>0) removeChildAt(0);
				//sArray.splice(0);
			}
		
		}
		
		public function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
		
		public function createCircles()
		{
			circle.graphics.clear();
			circle.graphics.lineStyle(2,cColor,1);
			circle.graphics.beginFill(cColor,1);
			circle.graphics.drawCircle(0,0,60);
			circle.graphics.endFill();
			canvas.addChildAt(circle,0)
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
			sColor = Math.random() * 0xFFFFFF;
			cColor = Math.random() * 0xFFFFFF;
			
			if(shapeType == "Cubic")
			{
				shapeType = "Linear";
			}
			else if(shapeType == "Linear")
			{
				shapeType = "Cubic"
			}
			
			drawShape();
			createCircles()
		}
		}}