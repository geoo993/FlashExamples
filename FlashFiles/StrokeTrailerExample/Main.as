package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;	import flash.geom.*;
	import fl.motion.Color;
	//import com.patrickmatte.PointData2;
	import com.cartogrammar.drawing.CubicBezier;
	import traer.physics.ParticleSystem;
	import traer.physics.Particle;
	import traer.physics.Spring;	public class Main extends MovieClip
	{
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		public var color1:uint;
		public var color2:uint;
		
		public var s:ParticleSystem = new ParticleSystem(new Vector3D(0, 0, 0), .2);
		public var hover;
		public var swarm:Array = new Array();
		//public var points:Array = new Array(new PointData2(100,100));
		public var points:Array = new Array();
		
		public var innerStroke:Sprite = new Sprite();
		public var weightedStroke:Sprite = new Sprite();
		public var strayStrokes:Array = new Array();
		public var strayStrokePoints:Array = new Array();
		
		public var strokeColorTransform = new ColorTransform  ;
		public var strokeColor2:uint = Math.random() * 0xFFFFFF;
		public var strokeColor:uint = Math.random() * 0xFFFFFF;
		public var strokeStretcherColor:uint = Math.random() * 0xFFFFFF;
				public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gloop);
			
			hover = s.makeParticle(1, new Vector3D(0, 0, 0)); hover.makeFixed();
			for(var i:uint = 0; i < 4; i++)
			{
				swarm[i] = s.makeParticle(.8, new Vector3D(0, 0, 0));
				s.makeSpring(hover, swarm[i], 1-(((i+1)*0.95)) , .01, 0);
				strayStrokes.push(new Sprite());
				strayStrokePoints[i]=new Array();
				//strayStrokePoints[i].push(new PointData2(100,100));
				strayStrokePoints[i].push(new Point(100,100));
				addChild(strayStrokes[i]);
			}
			addChild(innerStroke);
			//addChild(weightedStroke);
		}		public function gloop(myEvent:Event):void		{
			trace(swarm.length+"   "+points.length)
			
			s.tick(1);
			hover.position.x = stage.mouseX;
			hover.position.y = stage.mouseY;
			
			if(swarm[0].position.x > 0 && swarm[0].position.y > 0 )
			{
				//points.push(new PointData2(swarm[0].position.x,swarm[0].position.y,swarm[0].velocity.x+4,swarm[0].velocity.y+4));
				points.push(new Point(swarm[0].position.x,swarm[0].position.y));
			}
			//for(var i in swarm)
			for (var i:uint = 0; i < swarm.length; i ++)
			{
				if(swarm[i].position.x > 0 && swarm[i].position.y > 0 )
				{
					//strayStrokePoints[i].push(new PointData2(swarm[i].position.x,swarm[i].position.y,swarm[i].velocity.x,swarm[i].velocity.y));
					strayStrokePoints[i].push(new Point(swarm[i].position.x,swarm[i].position.y));
				}
			}
			
			drawStroke();
			truncateStroke();
			backgroundColorTransition();		}		function truncateStroke()
		{
			if(points.length > 20)
			{
				points.shift();
			}
			//for(var i in swarm)
			for (var i:uint = 0; i < swarm.length; i ++)
			{
				if(strayStrokePoints[i].length > 20)
				{
					strayStrokePoints[i].shift();
				}
			}
		}
		function drawStroke()
		{
			if(points.length > 2)
			{
				//weightedStroke.graphics.clear();
				//weightedStroke.graphics.beginFill(strokeStretcherColor);
				var i = 0;
				//var strokePath:Array = new Array();
				//
				//for(i = 0; i < points.length; i++)
				//{
				//	//strokePath.push(new Point(points[i].x + Math.abs(points[i].velocityY),points[i].y + Math.abs(points[i].velocityX)));
				//	strokePath.push(new Point(points[i].x,points[i].y));
				//}
				//for(i = points.length-1; i >- 1; i--)
				//{
				//	//strokePath.push(new Point(points[i].x - Math.abs(points[i].velocityY),points[i].y - Math.abs(points[i].velocityX)));
				//	strokePath.push(new Point(points[i].x,points[i].y));
				//}
				//CubicBezier.curveThroughPoints(weightedStroke.graphics,strokePath,.5,.75);
				//weightedStroke.graphics.endFill();
				
				//for (s in swarm)
				for (i = 0; i < swarm.length; i ++)
				{
					strayStrokes[i].graphics.clear();
					strayStrokes[i].graphics.lineStyle(i+randomRange(10,15),strokeColor,1,true);
					//strayStrokes[i].graphics.lineStyle(i+10,0);
					CubicBezier.curveThroughPoints(strayStrokes[i].graphics,strayStrokePoints[i],.5,.75);
				}
			}
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
				strokeColor2 = Math.random() * 0xFFFFFF;
			}
			if(curVal >= 1)
			{
				color1 = Math.random() * 0xFFFFFF;
				strokeColor = Math.random() * 0xFFFFFF;
				colorTransSwitch = "goingDown"
			}
			
			curVal = colorTransNum/255;
			stage.color = Color.interpolateColor(color1,color2,curVal);
			
			for (var i:uint = 0; i < strayStrokes.length; i ++)
				{
					strokeColorTransform.color = Color.interpolateColor(strokeColor,strokeColor2,curVal);
					strayStrokes[i].transform.colorTransform = strokeColorTransform;
				}
				
		}
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
		}}