package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;	import flash.geom.*;
	import fl.motion.Color;
	
		public class Main extends MovieClip
	{
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		public var color1:uint;
		public var color2:uint;
		
		public var curveColorTransform = new ColorTransform  ;
		public var curveColor:uint = Math.random() * 0xFFFFFF;
		public var curveColor2:uint = Math.random() * 0xFFFFFF;
		
		public var dragProps:Object;
		public var endDotX:Number;
		public var endDotY:Number;
		public var cWidth:Number = 10;
		
		public var g:Sprite = new Sprite();
		
		public var canvas:Sprite = new Sprite();
		public var pointsArray:Array = new Array();;
		
		public var numberOfDots:uint = 2;
		public var dotsArray:Array = new Array();
		public var curveArray:Array = new Array();
		public var dotsState:Boolean = false;
		
				public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gloop);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,handlePress);
			stage.addEventListener(MouseEvent.CLICK,handleClick);
			
			createCanvas();
			
		}
		public function gloop(myEvent:Event):void
		{
			backgroundColorTransition();
			
			if(dotsState == false)
			{
				if(pointsArray.length <numberOfDots)
				{
					dots();
				}
				else
				{
					dotsState = true; 
					draw();
				}
			}
			//trace(pointsArray.length+"   "+dotsState)
			
			trace(curveArray.length)
		}
		
		public function createCanvas()
		{
			addChild(canvas); 
		}
		
		public function dots()
		{
			var d:Sprite = Sprite(addChild(new Anchor));
			d.buttonMode = true;
			with(d.graphics) beginFill(0x507399), drawCircle(0,0,cWidth); 
			d.x = randomRange(100,stage.stageWidth);
			d.y = randomRange(100,stage.stageHeight);
			pointsArray.push(d)
			
		}
		function draw():void 
		{
			g.graphics.clear();
			var prevMidpt:Point = null;
			
			for (var i:uint = 1;i < pointsArray.length;i++) 
			{
				var point1:Sprite = pointsArray[i-1];
				var point2:Sprite = pointsArray[i];
				
				g.graphics.lineStyle(0,0xBBBBBB,0.6);
				//g.beginFill(0xffeecc);
				g.graphics.moveTo(point1.x,point1.y);
				g.graphics.lineTo(point2.x,point2.y);
				
				g.graphics.lineStyle(0,0xBBBBBB,0.5);
				var midpt:Point = new Point(point1.x+(point2.x-point1.x)/2,point1.y+(point2.y-point1.y)/2);
				var a:Number = Math.atan2(point2.y-point1.y,point2.x-point1.x);
				g.graphics.moveTo(midpt.x+Math.cos(a+Math.PI/2)*8,midpt.y+Math.sin(a+Math.PI/2)*8);
				g.graphics.lineTo(midpt.x-Math.cos(a+Math.PI/2)*8,midpt.y-Math.sin(a+Math.PI/2)*8);
				
				g.graphics.lineStyle(4,curveColor,1);
				if (prevMidpt) 
				{
					g.graphics.moveTo(prevMidpt.x,prevMidpt.y);
					g.graphics.curveTo(point1.x,point1.y,midpt.x,midpt.y);
				} 
				else
				{
					g.graphics.moveTo(point1.x,point1.y);
					g.graphics.lineTo(midpt.x,midpt.y);
				}
				prevMidpt = midpt;
			}
			
			endDotX = point2.x;
			endDotY = point2.y;
			g.graphics.lineTo(endDotX,endDotY);
			//g.endFill();
			
			canvas.addChild(g);
			curveArray.push(g);
			
		}
		function handlePress(eventt:MouseEvent):void 
		{
			/*for (var i:uint =1; i< pointsArray.length;i++) 
			{
				if(eventt.target == pointsArray[i])
				{
					
				}
			}*/
			
			if (eventt.target is Anchor) 
			{
				dragProps = {target:eventt.target};
				stage.addEventListener(MouseEvent.MOUSE_MOVE,doDrag);
				stage.addEventListener(MouseEvent.MOUSE_UP,endDrag);
			}
		}
		
		function doDrag(eventt:MouseEvent):void 
		{
			dragProps.target.x = mouseX;
			dragProps.target.y = mouseY;
			draw();
		}
		
		function endDrag(eventt:MouseEvent):void 
		{
			dragProps = null;
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,doDrag);
			stage.removeEventListener(MouseEvent.MOUSE_UP,endDrag);
		}
		
		
		function handleClick(eventt:MouseEvent):void 
		{
			
			/*for (var i:uint = 1; i< pointsArray.length;i++) 
			{
				if(eventt.target == pointsArray[i])
				{
					return; 
				}
			}*/
			if (eventt.target is Anchor) 
			{ 
				return; 
			}
			
			var anchor:Anchor = new Anchor();
			with(anchor.graphics) beginFill(0x507399), drawCircle(0,0,cWidth); 
			anchor.buttonMode = true;
			anchor.x = mouseX;
			anchor.y = mouseY;
			pointsArray.push(anchor);
			addChild(anchor);
			draw();
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
				curveColor2 = Math.random() * 0xFFFFFF
				
			}
			if(curVal >= 1)
			{
				color1 = Math.random() * 0xFFFFFF;
				curveColor = Math.random() * 0xFFFFFF
				colorTransSwitch = "goingDown";
			}
			
			curVal = colorTransNum/255;
			stage.color = Color.interpolateColor(color1,color2,curVal);
			
			for (var i:uint=0 ; i<curveArray.length;i++)
			{
				curveColorTransform.color = Color.interpolateColor(curveColor,curveColor2,curVal);
				curveArray[i].transform.colorTransform = curveColorTransform;
			}
		}
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
			}}