package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;	import flash.geom.*;
	import fl.motion.Color;
	import flash.text.*;
	import com.greensock.*;
	import com.greensock.easing.*;
		public class Main extends MovieClip
	{
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		public var color1:uint;
		public var color2:uint;
		public var lColor:uint = Math.random()*0xffffff
		public var graphColor:uint = Math.random()*0xffffff
		
		public var canvas:Sprite = new Sprite();
		public var xAxis:Sprite = new Sprite();
		public var yAxis:Sprite = new Sprite();
		//public var line:Sprite = new Sprite();
		
		public var getXaxisPointsArray:Array = new Array();
		public var getYaxisPointsArray:Array = new Array(new Point(0,500),new Point(0,0));
		public var pointsArray:Array = new Array();
		
		public var dotsState:Boolean = false;
		
		public var numberOfPoints:int = 25;
		
		public var indexDots:Number = 0;
		public var maxMoney:Number = 1000000;
		
		public var generatedNum:Number = 0;
		public var xNum:Number;
		public var xNumArray:Array = new Array;
		
		public var counter:Number = 0;
				public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gloop);
			stage.addEventListener(MouseEvent.CLICK,mClick);
			
			stage.color = Math.random()*0xFFFFFF;
			createCanvas();
			
			createGridTwo()
			getXaxisPoints();
			draw() 
			
			addText("WEEKS", 450, 530)
			addText("£", -20, 242) 
			
			addText(""+maxMoney, -20, -20) 
		}
		public function createCanvas()
		{
			addChild(canvas); 
			canvas.x = 50;
			canvas.y = 50;
		}
		public function gloop(myEvent:Event):void
		{
			if(indexDots<numberOfPoints-1)
			{
				counter++
			}
			if(counter > 100)
			{
				operateGraph();
				counter = 0;
			}
			
		}
		
		
		
		public function createGridTwo() 
		{
			
			for (var i:int = 0; i < numberOfPoints; i++) 
			{ 
				
				pointsArray[i] = new Sprite();
				pointsArray[i].graphics.clear();
				pointsArray[i].graphics.beginFill(0x000000,.5);
				pointsArray[i].graphics.drawCircle(0,0,5);
				pointsArray[i].graphics.endFill();
				pointsArray[i].x = (i % numberOfPoints) * 38;
				pointsArray[i].y = 500;
				
				canvas.addChild(pointsArray[i]);
				
				addText("w"+i, pointsArray[i].x-10, 510)
			}
		
		}
		private function addText(str:String, x:int, y:int):void
        {
            var tf:TextField = new TextField();
            tf.text = str; tf.x = x; tf.y = y; tf.autoSize = "left";
            tf.setTextFormat(new TextFormat("Comic Sans MS",8,graphColor,null,true));
            canvas.addChild(tf);
        }
		public function getXaxisPoints() 
		{
			for (var i:uint = 0;i < pointsArray.length;i++) 
			{
				getXaxisPointsArray.push(new Point(pointsArray[i].x,pointsArray[i].y));
			}					
		}
		function draw():void 
		{
			xAxis.graphics.clear();
			
			//xAxis
			for (var i:uint = 1;i < getXaxisPointsArray.length;i++) 
			{
				var xPoint1 = getXaxisPointsArray[i-1] ;
				var xPoint2 = getXaxisPointsArray[i] ;
				
				xAxis.graphics.lineStyle(2,graphColor,1);
				xAxis.graphics.moveTo(xPoint1.x,xPoint1.y);
				xAxis.graphics.lineTo(xPoint2.x,xPoint2.y);
				
				var midpt:Point = new Point(xPoint1.x+(xPoint2.x-xPoint1.x),xPoint1.y+(xPoint2.y-xPoint1.y)/2);
				var a:Number = Math.atan2(xPoint2.y-xPoint1.y,xPoint2.x-xPoint1.x);
				xAxis.graphics.moveTo(midpt.x+Math.cos(a+Math.PI/2)*4,midpt.y+Math.sin(a+Math.PI/2)*4);
				xAxis.graphics.lineTo(midpt.x-Math.cos(a+Math.PI/2)*4,midpt.y-Math.sin(a+Math.PI/2)*4);
			}
			
			
			//yAxis
			yAxis.graphics.clear();
			for (var j:uint = 1;j < getYaxisPointsArray.length;j++) 
			{
				var yPoint1 = getYaxisPointsArray[j-1] ;
				var yPoint2 = getYaxisPointsArray[j] ;
				
				yAxis.graphics.lineStyle(2,graphColor,1);
				yAxis.graphics.moveTo(yPoint1.x,yPoint1.y);
				yAxis.graphics.lineTo(yPoint2.x,yPoint2.y);
				
				var midpt2:Point = new Point(yPoint1.x+(yPoint2.x-yPoint1.x)/2,yPoint1.y+(yPoint2.y-yPoint1.y));
				var b:Number = Math.atan2(yPoint2.y-yPoint1.y,yPoint2.x-yPoint1.x);
				yAxis.graphics.moveTo(midpt2.x+Math.cos(b+Math.PI/2)*4,midpt2.y+Math.sin(b+Math.PI/2)*4);
				yAxis.graphics.lineTo(midpt2.x-Math.cos(b+Math.PI/2)*4,midpt2.y-Math.sin(b+Math.PI/2)*4);
				
			}
			canvas.addChild(xAxis);
			canvas.addChild(yAxis);
		}
		
		public function operateGraph()
		{
			if(indexDots>=numberOfPoints-1)
			{
				indexDots = numberOfPoints-1;
			}
			
			xNum = roundToNearest(randomRange(100,maxMoney),100)
			xNumArray.push(xNum)
			generatedNum = percentageNumber(percentageValue(xNum,0,maxMoney),500)
			
			indexDots++;
			//pointsArray[indexDots].y -= generatedNum;
			//drawLine()
			
			TweenNano.to(pointsArray[indexDots], 1, {y:500-generatedNum,ease:Sine.easeOut,onComplete:drawLine});
			
			//trace(xNum)
			trace(indexDots+" "+generatedNum+"   "+xNumArray)
		}
		public function drawLine()
		{
			var line:Sprite = new Sprite();
			var p:Sprite = pointsArray[indexDots-1];
			var p2:Sprite = pointsArray[indexDots];
			line.graphics.clear()
			line.graphics.lineStyle(4,lColor,1);
			line.graphics.moveTo(p.x,p.y);
			line.graphics.lineTo(p2.x,p2.y);
			canvas.addChild(line);
			
			addText(""+xNum, p2.x-30, p2.y-20) 
		}
		function mClick(eventt:MouseEvent):void 
		{
			//operateGraph()
			stage.color = Math.random()*0xFFFFFF;
		}
		function roundToNearest(value:Number,roundTo:Number):Number
		{
			return Math.round(value/roundTo)*roundTo;
		}
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
		public function percentageValue(value:Number, min:Number, max:Number):Number 
		{
			var myPercent:Number;
			var difference:Number = max - min;
			myPercent = ((value - min) / difference);
			return Math.round(100*myPercent);
		}
		public function percentageNumber(value:Number, percentage:Number):Number 
		{
			var myNum:Number;
			myNum =  (value*percentage)/100;
			return Math.round(myNum);
		}	}}