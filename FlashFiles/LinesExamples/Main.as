package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;	import flash.geom.*;
	import flash.text.*;
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
		public var dotsColor:uint = Math.random() * 0xFFFFFF;
		
		public var dragProps:Object;
		
		public var g:Sprite = new Sprite();
		
		public var canvas:Sprite = new Sprite();
		public var pointsArray:Array = new Array();;
		
		public var numberOfDots:uint = 2;
		public var dotsArray:Array = new Array();
		public var curveArray:Array = new Array();
		public var dotsState:Boolean = false;
		
		public var lineBranches:Number = 1;
		public var lineStroke:Number = 2;
		public var lineFrequency:Number = 1;
		public var lineOffset:Number = 2;
		public var lineAlpha:Number = 1;
		public var dotsAlpha:Number = 1;
				public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gloop);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,handlePress);
			stage.addEventListener(MouseEvent.CLICK,handleClick);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			
			createCanvas();
			stage.color = Math.random() * 0xFFFFFF;
			
		}
		public function gloop(myEvent:Event):void
		{
			trace(pointsArray.length)
			if(dotsState == false)
			{
				if(pointsArray.length <numberOfDots)
				{
					dots();
				}
				else
				{
					dotsState = true; 
				}
			}
			draw();
			stageAssets();
			linesColor();
		}
		
		public function createCanvas()
		{
			addChild(canvas); 
			
		}
		public function stageAssets()
		{
			lStrokeText.text = "Stoke:  "+lineStroke.toFixed(2);
			lStrokeB.alpha = 0;
			
			lFrequentText.text = "Frequency:  "+lineFrequency.toString();
			lFrequenB.alpha = 0;
			
			lBranchesText.text = "Branches:  "+lineBranches.toString();
			lBranchesB.alpha = 0;
			
			lOffSetText.text = "OffSet:  "+lineOffset.toString();
			lOffsetB.alpha = 0;
			
			lAlphaText.text = "Alpha:  "+lineAlpha.toFixed(1);
			lAlphaB.alpha = 0;
			
			dotText.text = "Dots Alpha:  "+dotsAlpha.toFixed(1);
			dotsB.alpha = 0;
			
			for (var i:uint=0 ; i < pointsArray.length;i++)
			{
				pointsArray[i].alpha = dotsAlpha;
			} 
		}
		public function dots()
		{
			var d:Sprite = Sprite(addChild(new Anchor));
			d.buttonMode = true;
			with(d.graphics) beginFill(dotsColor), drawCircle(0,0,10); 
			d.x = randomRange(100,stage.stageWidth-100);
			d.y = randomRange(100,stage.stageHeight-100);
			pointsArray.push(d)
			
		}
		function draw():void 
		{
			g.graphics.clear();
			for (var i:uint = 1;i < pointsArray.length;i++) 
			{
				var point1:Sprite = pointsArray[i-1];
				var point2:Sprite = pointsArray[i];
				
				g.graphics.lineStyle(lineStroke,0xFFFFFF,lineAlpha);
				/*g.graphics.moveTo(point1.x,point1.y);
				g.graphics.lineTo(point2.x,point2.y);*/
				
				var distanceX:Number = point1.x - point2.x;
				var distanceY:Number = point1.y - point2.y;
				var distanceTotal:Number = Math.sqrt(((distanceX * distanceX) + distanceY * distanceY));
				
				var numberOfSteps:Number = distanceTotal / lineFrequency;
				var angle:Number = Math.atan2((point1.y - point2.y),point1.x - point2.x);
				var stepInPixels:Number = distanceTotal / numberOfSteps;
	
				for (var j = 0; j < lineBranches; j++)
				{
					g.graphics.moveTo(point1.x,point1.y);
					
					for (var a:uint = 1; a < (numberOfSteps + 1); a++)
					{
						var currentStepPosition:Number = stepInPixels * a;
						var randomOffset:Number = Math.random() * (lineOffset - lineOffset / 2);
						var xStepPosition:Number = point1.x - Math.cos(angle) * currentStepPosition + Math.cos((angle + 1.55)) * randomOffset;
						var yStepPosition:Number = point1.y - Math.sin(angle) * currentStepPosition + Math.sin((angle + 1.55)) * randomOffset;
						g.graphics.lineTo(xStepPosition,yStepPosition);
					}
					g.graphics.lineTo(point2.x,point2.y);
				}
			}
			
			canvas.addChild(g);
			curveArray.push(g);
			
		}
		function handlePress(eventt:MouseEvent):void 
		{
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
			
			if (eventt.target is Anchor) 
			{ 
				return; 
			}
			if (eventt.target == lStrokeB) 
			{ 
				lineStroke += .2
				
				if(lineStroke > 5)
				{
					lineStroke = 0;
				}
				return; 
			}
			if (eventt.target == lFrequenB) 
			{ 
				lineFrequency += 1;
				
				if(lineFrequency > 30)
				{
					lineFrequency = 1;
				}
				return; 
			}
			if (eventt.target == lBranchesB) 
			{ 
				lineBranches += 1;
				
				if(lineBranches > 5)
				{
					lineBranches = 1;
				}
				return; 
			}
			if (eventt.target == lOffsetB) 
			{ 
				lineOffset += 2;
				
				if(lineOffset > 40)
				{
					lineOffset = 0;
				}
				return; 
			}
			if (eventt.target == lAlphaB) 
			{ 
				lineAlpha += .1;
				
				if(lineAlpha > 1)
				{
					lineAlpha = 0;
				}
				return; 
			}
			
			if (eventt.target == dotsB) 
			{ 
				dotsAlpha += .1;
				if(dotsAlpha >= 1)
				{
					dotsAlpha = 0;
				}
				
				return; 
			}
			
			var anchor:Anchor = new Anchor();
			with(anchor.graphics) beginFill(dotsColor), drawCircle(0,0,10); 
			anchor.buttonMode = true;
			anchor.x = mouseX;
			anchor.y = mouseY;
			pointsArray.push(anchor);
			addChild(anchor);
			draw();
		}
		public function linesColor()
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
				curveColor2 = Math.random() * 0xFFFFFF
			}
			if(curVal >= 1)
			{
				curveColor = Math.random() * 0xFFFFFF
				colorTransSwitch = "goingDown";
			}
			
			curVal = colorTransNum/255;
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
		public function kDown(event:KeyboardEvent):void
		{  
			if (event.keyCode == 32)
			{
				stage.color = Math.random() * 0xFFFFFF;
			}
		}
			}}