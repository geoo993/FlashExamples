package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.text.*;

	public class Main extends MovieClip
	{
		public var centerBoardCircle:Sprite = new Sprite();
		public var chartPartOne:Shape = new Shape();
		public var chartPartTwo:Shape = new Shape();
		public var chartPartThree:Shape = new Shape();
		public var square1:Shape = new Shape();
		public var square2:Shape = new Shape();
		public var square3:Shape = new Shape();
	
		public var chartOnedegree:Number = 0; 
		public var chartTwodegree:Number = 0; 
		public var chartThreedegree:Number = 0; 
		public var degreeChange:Number = 1; 
		
		public var chartOneR:Number = 110; 
		public var chartTwoR:Number = 110; 
		public var chartThreeR:Number = 110; 
		public var circleX:Number = 400; 
		public var circleY:Number = 300;
		
		public var transparency:Number = .8;
        
		public var c1BorderColor:uint = Math.random() * 0xFFFFFF;
		public var c2BorderColor:uint = Math.random() * 0xFFFFFF;
		public var c3BorderColor:uint = Math.random() * 0xFFFFFF;
		public var chartsOutlineColor:uint = Math.random() * 0xFFFFFF;
		public var cColor1:uint = Math.random() * 0xFFFFFF;
		public var cColor2:uint = Math.random() * 0xFFFFFF;
		public var cColor3:uint = Math.random() * 0xFFFFFF;
		
		public var TextColor:uint = Math.random() * 0xffffff;
		public var TextsColor:uint = Math.random() * 0xffffff;
		public var TextsOutlineColor:uint = Math.random() * 0xffffff;
		public var BackGroundColor:uint = Math.random() * 0xffffff;
		
		public var cColorTransform = new ColorTransform  ;
		public var targetColorTransform = new ColorTransform  ;
		
		public var TextOne:Number = 0;
		public var TextTwo:Number = 0;
		public var TextThree:Number = 0;
		public var TextXpos:Number = 0;
		public var TextYpos:Number = 0;
		
		public var TextOneText:TextField = new TextField();
		public var TextOneFormat:TextFormat = new TextFormat  ;
		public var TextTwoText:TextField = new TextField();
		public var TextTwoFormat:TextFormat = new TextFormat  ;
		public var TextThreeText:TextField = new TextField();
		public var TextThreeFormat:TextFormat = new TextFormat  ;
		public var myTextFormat:TextFormat = new TextFormat  ;
		
		public var chartArray:Array = new Array ;
		public var TextFieldsArray:Array = new Array() ;
		public var TextsArray:Array = new Array() ;
		public var s1Array:Array = new Array();
		public var s2Array:Array = new Array();
		public var s3Array:Array = new Array();
		
		public var chartNum1:Number = 0;
		public var myNum1:Number = 0;
		public var now1:Number = 0;
		public var then1:Number = 0;
		public var chart1:Boolean = false;
		public var upDown1:Boolean = false;
		
		public var chartNum2:Number = 0;
		public var myNum2:Number = 0;
		public var now2:Number = 0;
		public var then2:Number = 0;
		public var chart2:Boolean = false;
		public var upDown2:Boolean = false;
		
		public var chartNum3:Number = 0;
		public var myNum3:Number = 0;
		public var now3:Number = 0;
		public var then3:Number = 0;
		public var chart3:Boolean = false;
		public var upDown3:Boolean = false;
		
		public var recX:Number = 100; 
		public var recY:Number = 400;
		public var recWidth:Number = 100;
		
		public var pieChartCount:Number = 0;
		public var chartsCountSpeed:Number = 2;
		
		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			TextsArray.push(TextOneText)
			TextsArray.push(TextTwoText)
			TextsArray.push(TextThreeText)
			chartArray.push(chartPartOne)
			chartArray.push(chartPartTwo)
			chartArray.push(chartPartThree)
			
		}              
		public function recChart1(widthh:Number,heightt:Number)
		{
			square1.x = recX; 
			square1.y = recY;
			
			square1.graphics.clear();
			//square1.graphics.lineStyle(2,recOutColor,1,true);
			square1.graphics.beginFill(cColor1,transparency);
			square1.graphics.moveTo(0,0);
			square1.graphics.lineTo(widthh,0);
			square1.graphics.lineTo(widthh,-heightt);
			square1.graphics.lineTo(0,-heightt);
			square1.graphics.endFill();
			stage.addChild(square1);
			s1Array.push(square1);
			
			if(s1Array.length > 0)
			{
				s1Array.pop();
			}
		}
		public function recChart2(widthh:Number,heightt:Number)
		{
			square2.x = recX; 
			square2.y = square1.y-square1.height;
			
			square2.graphics.clear();
			//square2.graphics.lineStyle(2,recOutColor,1,true);
			square2.graphics.beginFill(cColor2,transparency);
			square2.graphics.moveTo(0,0);
			square2.graphics.lineTo(widthh,0);
			square2.graphics.lineTo(widthh,-heightt);
			square2.graphics.lineTo(0,-heightt);
			square2.graphics.endFill();
			stage.addChild(square2);
			s2Array.push(square2);
			
			if(s2Array.length > 0)
			{
				s2Array.pop();
			}
		}
		public function recChart3(widthh:Number,heightt:Number)
		{
			square3.x = recX; 
			square3.y = square2.y-square2.height;
			
			square3.graphics.clear();
			//square3.graphics.lineStyle(2,recOutColor,1,true);
			square3.graphics.beginFill(cColor3,transparency);
			square3.graphics.moveTo(0,0);
			square3.graphics.lineTo(widthh,0);
			square3.graphics.lineTo(widthh,-heightt);
			square3.graphics.lineTo(0,-heightt);
			square3.graphics.endFill();
			stage.addChild(square3);
			s3Array.push(square3);
			
			if(s3Array.length > 0)
			{
				s3Array.pop();
			}
		}
		function TextOnee()
		{
			TextOne =  percentageValue(chartOnedegree,0,360);
			
			addChild(TextOneText);
			TextOneText.text = (Math.round(TextOne)+" %").toString();
			TextOneText.border = true;
			TextOneText.textColor = TextsColor;
			TextOneText.borderColor = TextsColor;
			TextOneText.background = true;    
			TextOneText.backgroundColor = cColor1; 
			TextOneText.width = 100;
			TextOneText.height = 30;
			TextOneText.selectable = false;
			TextOneText.setTextFormat(TextOneFormat);
			TextOneFormat.italic = true; 
			TextOneFormat.size = 12;
			TextOneFormat.font = "Comic Sans MS";
			TextOneFormat.align = TextFormatAlign.RIGHT;
			
			TextOneText.x = 100;
			TextOneText.y = 100;
		}
		function TextTwoo()
		{
			TextTwo = percentageValue(chartTwodegree,0,360);
			
			addChild(TextTwoText);
			TextTwoText.text = (Math.round(TextTwo))+" %".toString();
			TextTwoText.border = true;
			TextTwoText.textColor = TextsColor;
			TextTwoText.borderColor = TextsColor;
			TextTwoText.background = true;    
			TextTwoText.backgroundColor = cColor2; 
			TextTwoText.width = 100;
			TextTwoText.height = 30;
			TextTwoText.selectable = false;
			TextTwoText.setTextFormat(TextTwoFormat);
			TextTwoFormat.italic = true; 
			TextTwoFormat.size = 12;
			TextTwoFormat.font = "Comic Sans MS";
			TextTwoFormat.align = TextFormatAlign.RIGHT;
			
			TextTwoText.x = 250;
			TextTwoText.y = 100;
		}
		function TextThreee()
		{
			TextThree = percentageValue(chartThreedegree,0,360);
			
			addChild(TextThreeText);
			TextThreeText.text = (Math.round(TextThree))+" %".toString();
			TextThreeText.border = true;
			TextThreeText.textColor = TextsColor;
			TextThreeText.borderColor = TextsColor;
			TextThreeText.background = true;    
			TextThreeText.backgroundColor = cColor3; 
			TextThreeText.width = 100;
			TextThreeText.height = 30;
			TextThreeText.selectable = false;
			TextThreeText.setTextFormat(TextThreeFormat);
			TextThreeFormat.italic = true; 
			TextThreeFormat.size = 12;
			TextThreeFormat.font = "Comic Sans MS";
			TextThreeFormat.align = TextFormatAlign.RIGHT;
			
			TextThreeText.x = 400;
			TextThreeText.y = 100;
		}
		function drawCharts()
		{
			centerBoardCircle.x = circleX;
			centerBoardCircle.y = circleY;
			addChild(centerBoardCircle);
			
			chartPartOne.graphics.lineStyle(1,c1BorderColor);
			chartPartOne.graphics.moveTo(0,0);
			chartPartOne.graphics.lineTo(chartOneR,0);
			centerBoardCircle.addChild(chartPartOne); 
			
			chartPartTwo.graphics.lineStyle(1,c2BorderColor);
			chartPartTwo.graphics.moveTo(0,0);
			chartPartTwo.graphics.lineTo(chartTwoR,0);
			centerBoardCircle.addChild(chartPartTwo); 
			
			chartPartThree.graphics.lineStyle(1,c3BorderColor);
			chartPartThree.graphics.moveTo(0,0);
			chartPartThree.graphics.lineTo(chartThreeR,0);
			centerBoardCircle.addChild(chartPartThree); 
			
		}
		function updateChartOne(t1:Number) 
		{	
			chartPartOne.graphics.clear();
			//chartPartOne.graphics.lineStyle(2,c1BorderColor);
			chartPartOne.graphics.beginFill(cColor1,transparency);
			chartPartOne.graphics.moveTo(0,0);
			
			for (var i:uint = 0; i <= t1; i++) 
			{
				chartPartOne.graphics.lineTo(chartOneR*Math.cos(i*Math.PI/180), -chartOneR*Math.sin(i*Math.PI/180));
			}
			
			chartPartOne.graphics.lineTo(0,0);
			chartPartOne.graphics.endFill();
			if (t1 > 360) 
			{
				t1 = t1 - 360;
			}
			if (t1 < 0) 
			{
				t1 = t1 + 360;
			}
			
			if(chart1 == true)
			{
				now1 = chartNum1;
				if(now1 > then1)
				{
					upDown1 = true;
				}
				else if(now1 < then1)
				{
					upDown1 = false
				}
				then1 = now1;
			}
			
			if(upDown1 == false)
			{
				myNum1 -= chartsCountSpeed;
				if(myNum1 <= chartNum1)
				{
					myNum1 = chartNum1;
				}
			}
			if(upDown1 == true)
			{
				myNum1 += chartsCountSpeed;
				
				if(myNum1 >= chartNum1)
				{
					myNum1 = chartNum1;
				}
			}
		}
		function updateChartTwo(t2:Number) 
		{	
			chartPartTwo.graphics.clear();
			//chartPartTwo.graphics.lineStyle(2,c2BorderColor);
			chartPartTwo.graphics.beginFill(cColor2,transparency);
			chartPartTwo.graphics.moveTo(0,0);
			
			for (var i:uint = 0; i <= t2; i++) 
			{
				chartPartTwo.graphics.lineTo(chartTwoR*Math.cos(-i*Math.PI/180), -chartTwoR*Math.sin(-i*Math.PI/180));
			}
			chartPartTwo.graphics.lineTo(0,0);
			chartPartTwo.graphics.endFill();
			if (t2 > 360) 
			{
				t2 = t2 - 360;
			}
			if (t2 < 0) 
			{
				t2 = t2 + 360;
			}
			
			if(chart2 == true)
			{
				now2 = chartNum2;
				if(now2 > then2)
				{
					upDown2 = true;
				}
				else if(now2 < then2)
				{
					upDown2 = false
				}
				then2 = now2;
			}
			
			if(upDown2 == false)
			{
				myNum2 -= chartsCountSpeed;
				if(myNum2 <= chartNum2)
				{
					myNum2 = chartNum2;
				}
			}
			if(upDown2 == true)
			{
				myNum2 += chartsCountSpeed;
				
				if(myNum2 >= chartNum2)
				{
					myNum2 = chartNum2;
				}
			}
		}
		function updateChartThree(t3:Number) 
		{	
			chartPartThree.graphics.clear();
			//chartPartThree.graphics.lineStyle(2,c3BorderColor);
			chartPartThree.graphics.beginFill(cColor3,transparency);
			chartPartThree.graphics.moveTo(0,0);
			
			for (var i:uint = 0; i <= t3; i++) 
			{
				chartPartThree.graphics.lineTo(chartThreeR*Math.cos(-i*Math.PI/180), -chartThreeR*Math.sin(-i*Math.PI/180));
			}
			
			chartPartThree.graphics.lineTo(0,0);
			chartPartThree.graphics.endFill();
			
			if (t3 > 360) 
			{
				t3 = t3 - 360;
			}
			if (t3 < 0) 
			{
				t3 = t3 + 360;
			}
			if(chart3 == true)
			{
				now3 = chartNum3;
				if(now3 > then3)
				{
					upDown3 = true;
				}
				else if(now3 < then3)
				{
					upDown3 = false
				}
				then3 = now3;
			}
			
			if(upDown3 == false)
			{
				myNum3 -= chartsCountSpeed;
				if(myNum3 <= chartNum3)
				{
					myNum3 = chartNum3;
				}
			}
			if(upDown3 == true)
			{
				myNum3 += chartsCountSpeed;
				
				if(myNum3 >= chartNum3)
				{
					myNum3 = chartNum3;
				}
			}
			chartPartThree.rotation = myNum2;
		}
		
		public function gL(myEvent:Event):void
		{
			pieChartCount += 1;
			if(pieChartCount > 500)
			{
				cColor1 = Math.random() * 0xFFFFFF;
				cColor2 = Math.random() * 0xFFFFFF;
				cColor3 = Math.random() * 0xFFFFFF;
				
				c1BorderColor = Math.random() * 0xFFFFFF;
				c2BorderColor = Math.random() * 0xFFFFFF;
				c3BorderColor = Math.random() * 0xFFFFFF;
				
				TextsColor = Math.random() * 0xFFFFFF;

				chart1 = false;
				chart2 = false;
				chart3 = false;
				pieChartCount = 0;
			}
			
			TextOnee();
			TextTwoo();
			TextThreee();
			drawCharts();
			
			updateChartOne(chartOnedegree);
			updateChartTwo(chartTwodegree);
			updateChartThree(chartThreedegree);
			
			recChart1(recWidth,percentageValue(chartOnedegree,0,360)*2);
			recChart2(recWidth,percentageValue(chartTwodegree,0,360)*2);
			recChart3(recWidth,percentageValue(chartThreedegree,0,360)*2);
			
			chartOnedegree = myNum1;
			chartTwodegree = myNum2;
			chartThreedegree = myNum3;
			
			
			if(chart1 == false)
			{
				chartNum1 = randomRange(0,360);
				chart1 = true
			}
			if(chart2 == false)
			{
				chartNum2 = randomRange(0,360-chartNum1);
				chart2 = true
			}
			if(chart3 == false)
			{
				chartNum3 = 360-(chartNum1+chartNum2);
				chart3 = true
			}
			
		}
		public function percentageValue(value:Number, min:Number, max:Number):Number 
		{
			var myPercent:Number;
			var difference:Number = max - min;
			myPercent = ((value - min) / difference);
			return 100*myPercent;
		}
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
		function kDown(event:KeyboardEvent):void
		{  
			if (event.keyCode == 32)
			{
				cColor1 = Math.random() * 0xFFFFFF;
				cColor2 = Math.random() * 0xFFFFFF;
				cColor3 = Math.random() * 0xFFFFFF;
				
				c1BorderColor = Math.random() * 0xFFFFFF;
				c2BorderColor = Math.random() * 0xFFFFFF;
				c3BorderColor = Math.random() * 0xFFFFFF;
				
				TextsColor = Math.random() * 0xFFFFFF;

				chart1 = false;
				chart2 = false;
				chart3 = false;
			
			}
			
		}

	}

}