package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;

	public class Main extends MovieClip
	{
		public var centerBoardCircle:MovieClip = new MovieClip();
		public var chartPartOne:Shape = new Shape();
	
		public var chartOnedegree:Number = 0; 
		public var degreeChange:Number = 1; 
		
		public var chartOneR:Number = 100; 
	
		public var c1BorderColor:uint = Math.random() * 0xFFFFFF;
		public var chartsOutlineColor:uint = Math.random() * 0xFFFFFF;
		public var cColor:uint = Math.random() * 0xFFFFFF;
		
		public var cColorTransform = new ColorTransform  ;
		public var targetColorTransform = new ColorTransform  ;
		
		public var chartArray:Array = new Array ;
		public var chartNum:Number = 0;
		public var myNum:Number = 0;
		public var now:Number = 0;
		public var then:Number = 0;
		public var chart:Boolean = false;
		public var upDown:Boolean = false;
		
		public var pieChartCount:Number = 0;
		
		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			
			chartArray.push(chartPartOne)
			
		}
		
	
		function drawCharts()
		{
			centerBoardCircle.x = 200;
			centerBoardCircle.y = 200;
			addChild(centerBoardCircle);
			
		}
		function updateChartOne(t1:Number) 
		{	
			centerBoardCircle.addChild(chartPartOne); 
			chartPartOne.graphics.clear();
			chartPartOne.graphics.lineStyle(2,c1BorderColor);
			chartPartOne.graphics.beginFill(cColor,0.7);
			chartPartOne.graphics.moveTo(0,0);
			
			for (var i:uint = 0; i <= t1; i++) 
			{
				chartPartOne.graphics.lineTo(chartOneR*Math.cos(i*Math.PI/180), -chartOneR*Math.sin(i*Math.PI/180));
			}
			
			//chartPartOne.graphics.lineTo(0,0);
			chartPartOne.graphics.endFill();
		
			if(chart == true)
			{
				now = chartNum;
				if(now > then)
				{
					upDown = true;
				}
				else if(now < then)
				{
					upDown = false
				}
				then = now;
			}
			
			if(upDown == false)
			{
				myNum -= 1
				if(myNum <= chartNum)
				{
					myNum = chartNum;
				}
			}
			if(upDown == true)
			{
				myNum += 1
				
				if(myNum >= chartNum)
				{
					myNum = chartNum;
				}
			}
		}
		
		public function gL(myEvent:Event):void
		{
			pieChartCount += 1;
			if(pieChartCount > 500)
			{
				chart = false;
				pieChartCount = 0;
			}
			
			drawCharts();
			updateChartOne(chartOnedegree);
			
			chartOnedegree = myNum;
			if(chart == false)
			{
				cColor = Math.random() * 0xFFFFFF;
				c1BorderColor = Math.random() * 0xFFFFFF;
				chartNum = randomRange(0,360);
				chart = true;
			}
			
		}
		
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
		function kDown(event:KeyboardEvent):void
		{  
			if (event.keyCode == 32)
			{
				chart = false;
			
			}
		
		}

	}

}