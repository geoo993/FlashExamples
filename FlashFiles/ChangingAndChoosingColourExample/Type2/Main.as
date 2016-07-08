package 
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.text.*;
	import fl.motion.Color;
	import fl.events.SliderEvent;

	public class Main extends MovieClip
	{
		public var TextSizeNumber = 15;
		public var TextWidth:Number = 50;
		public var TextHeight:Number = 24; 
		public var shapeType:Number = 0;
		
		public var radius:Number = 40;
		
		public var redRec:MovieClip = new MovieClip();
		public var rLine:MovieClip = new MovieClip();
		public var rShape:MovieClip = new MovieClip();
		public var redX:Number = 150;
		public var redY:Number = 450;
		
		public var greenRec:MovieClip = new MovieClip();
		public var gLine:MovieClip = new MovieClip();
		public var gShape:MovieClip = new MovieClip();
		public var greenX:Number = 300;
		public var greenY:Number = 450;
		
		public var blueRec:MovieClip = new MovieClip();
		public var bLine:MovieClip = new MovieClip();
		public var bShape:MovieClip = new MovieClip();
		public var blueX:Number = 450;
		public var blueY:Number = 450;
		
		public var LinesX:Number = 175;
		public var LinesY:Number = 300;
		public var transparency:Number = 1;
		
		public var rOutColor:uint = rColor;
		public var gOutColor:uint = gColor;
		public var bOutColor:uint = bColor;
		
		public var r:uint;
		public var g:uint;
		public var b:uint;
		public var rColor:uint = 0xFF0000;
		public var gColor:uint = 0x00FF00;
		public var bColor:uint = 0x0000FF;
		
		public var TextColor:uint = Math.random() * 0xffffff;
		public var textBackColor:uint = 0xffffff;
		
		public var bgColor:uint = Math.random() * 0xffffff;
		public var bgColorTransform = new ColorTransform  
	
		public var TextOne:TextField = new TextField();
		public var TextOneFormat:TextFormat = new TextFormat  ;
		
		public var TextTwo:TextField = new TextField();
		public var TextTwoFormat:TextFormat = new TextFormat  ;
		
		public var TextThree:TextField = new TextField();
		public var TextThreeFormat:TextFormat = new TextFormat  ;
		
		public var TextOneArray:Array = new Array() ;
		public var TextTwoArray:Array = new Array() ;
		public var TextThreeArray:Array = new Array() ;
		
		public var redArray:Array = new Array();
		public var redLineArray:Array = new Array();
		
		public var blueArray:Array = new Array();
		public var blueLineArray:Array = new Array();
		
		public var greenArray:Array = new Array();
		public var greenLineArray:Array = new Array();
		
		public var redClick:Boolean = false;
		public var greenClick:Boolean = false;
		public var blueClick:Boolean = false;
		
		public var left:Boolean = false;
		public var right:Boolean = false;
		
		public var redColourNum:Number = 0;
		public var greenColourNum:Number = 0;
		public var blueColourNum:Number = 0;
		public var colorSpeed:Number = 1;
		
		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, kDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, kUp);
			stage.addEventListener(MouseEvent.CLICK,mClick);
			
			redRec.buttonMode = true;
			greenRec.buttonMode = true;
			blueRec.buttonMode = true;
			//sliderRed.addEventListener(SliderEvent.CHANGE,sliderChange);
			//sliderGreen.addEventListener(SliderEvent.CHANGE,sliderChange);
			//sliderBlue.addEventListener(SliderEvent.CHANGE,sliderChange);
			
			//hexColorCode(0xFFFF00);
		}   
		public function gL(myEvent:Event):void
		{
			sliderRed.visible = false;
			sliderGreen.visible = false;
			sliderBlue.visible = false;
			
			RedText();
			GreenText();
			BlueText();
			drawCharts();
			
			drawRedShape((percentageValue(r,0,255)*360/100),r);
			drawGreenShape((percentageValue(g,0,255)*360/100),g);
			drawBlueShape((percentageValue(b,0,255)*360/100),b);
			
			backGroundColor();
			colourChange();
		}
		
		function extractRed(c:uint):uint 
		{
			return (( c >> 16 ) & 0xFF);
		}
		function extractGreen(c:uint):uint 
		{
			return ( (c >> 8) & 0xFF );
		}
		function extractBlue(c:uint):uint 
		{
			return ( c & 0xFF );
		}
		function combineRGB(r:uint,g:uint,b:uint):uint 
		{
			return ( ( r<< 16 ) | ( g << 8 ) | b );
		}
		function displayInHex(c:uint):String 
		{	
			var r:String=extractRed(c).toString(16).toUpperCase();
			
			var g:String = extractGreen(c).toString(16).toUpperCase();
			
			var b:String = extractBlue(c).toString(16).toUpperCase();
			
			var hs:String = "";
			
			var zero:String = "0";
			
			if(r.length == 1)
			{
				r = zero.concat(r);
			}
			
			if(g.length == 1)
			{
				g = zero.concat(g);
			}
			
			if(b.length == 1)
			{
				b = zero.concat(b);
			}
			
			hs = r + g + b;
			
			return hs;
		}
		public function colourChange()
		{
			if(right == true)
			{
				if(redClick == true)
				{
					redColourNum += colorSpeed;
				}
				if(greenClick == true)
				{
					greenColourNum += colorSpeed;
				}
				if(blueClick == true)
				{
					blueColourNum += colorSpeed;
				}

			}
			if(left == true)
			{
				if(redClick == true)
				{
					redColourNum -= colorSpeed;
				}
				if(greenClick == true)
				{
					greenColourNum -= colorSpeed;
				}
				if(blueClick == true)
				{
					blueColourNum -= colorSpeed;
				}
			}
			
			r = redColourNum;
			if(redColourNum<=1)
			{
				redColourNum = 1;
			}
			
			if(redColourNum>=255)
			{
				redColourNum = 255
			}
			
			g = greenColourNum;
			if(greenColourNum<=1)
			{
				greenColourNum = 1;
			}
			if(greenColourNum>=255)
			{
				greenColourNum = 255
			}
			
			b = blueColourNum;
			if(blueColourNum<=1)
			{
				blueColourNum = 1;
			}
			if(blueColourNum>=255)
			{
				blueColourNum = 255
			}
			
			var c:uint = combineRGB(r,g,b);
			var ct:ColorTransform = new ColorTransform();
			ct.color = c;
			colorClip.transform.colorTransform = ct;
			
			redBox.text = String(r);
			greenBox.text = String(g);
			blueBox.text = String(b);
			hexBox.text = "#"+displayInHex(c);
			
		}
		/*function sliderChange(e:SliderEvent):void 
		{
			r = sliderRed.value;
			
			g = sliderGreen.value;
			
			b = sliderBlue.value;
			
			var c:uint = combineRGB(r,g,b);
			
			var ct:ColorTransform = new ColorTransform();
		
			ct.color = c;
			
			colorClip.transform.colorTransform = ct;
			
			redBox.text=String(r);
			
			greenBox.text=String(g);
			
			blueBox.text=String(b);
			
			hexBox.text="#"+displayInHex(c);
			
		}*/
		function hexColorCode(c:uint):void 
		{
			var ct:ColorTransform=new ColorTransform();
			
			var r:uint;
			
			var g:uint;
			
			var b:uint;
			
			ct.color = c;
			
			colorClip.transform.colorTransform = ct;
			
			r = extractRed(c);
			
			g = extractGreen(c);
			
			b = extractBlue(c);
			
			redBox.text = String(r);
			
			greenBox.text = String(g);
			
			blueBox.text = String(b);
			
			sliderRed.value = r;
			
			sliderGreen.value = g;
			
			sliderBlue.value = b;
			
			hexBox.text="#"+displayInHex(c);
			
		}

		public function backGroundColor()
		{
			bgColorTransform.color = combineRGB(r,g,b);
			bg.transform.colorTransform = bgColorTransform;
			
			bg.alpha = .5;
		}
		
		function RedText()
		{
			TextOne.text = r.toString();
			TextOne.textColor = rColor;
			TextOne.width = TextWidth;
			TextOne.height = TextHeight;
			TextOne.selectable = false;
		
			TextOne.setTextFormat(TextOneFormat);
			TextOneFormat.size = TextSizeNumber;
			TextOneFormat.font = "Chalkboard";
			TextOneFormat.align = TextFormatAlign.CENTER;
			
			addChild(TextOne);
			TextOne.x = redX-(TextWidth/2);
			TextOne.y = redY-(TextHeight/2);
			
			TextOneArray.push(TextOne);
			
			if(TextOneArray.length > 0)
			{
				TextOneArray.pop();
			}
		}
		function GreenText()
		{
			TextTwo.text = g.toString();
			TextTwo.textColor = gColor;
			TextTwo.width = TextWidth;
			TextTwo.height = TextHeight;
			TextTwo.selectable = false;
		
			TextTwo.setTextFormat(TextTwoFormat);
			TextTwoFormat.size = TextSizeNumber;
			TextTwoFormat.font = "Chalkboard";
			TextTwoFormat.align = TextFormatAlign.CENTER;
			
			addChild(TextTwo);
			TextTwo.x = greenX-(TextWidth/2);
			TextTwo.y = greenY-(TextHeight/2);
			
			TextTwoArray.push(TextTwo);
			
			if(TextTwoArray.length > 0)
			{
				TextTwoArray.pop();
			}
		}
		function BlueText()
		{
			
			TextThree.text = b.toString();
			TextThree.textColor = bColor;
			TextThree.width = TextWidth;
			TextThree.height = TextHeight;
			TextThree.selectable = false;
		
			TextThree.setTextFormat(TextThreeFormat);
			TextThreeFormat.size = TextSizeNumber;
			TextThreeFormat.font = "Chalkboard";
			TextThreeFormat.align = TextFormatAlign.CENTER;
			
			addChild(TextThree);
			TextThree.x = blueX-(TextWidth/2);
			TextThree.y = blueY-(TextHeight/2);
			
			TextThreeArray.push(TextThree);
			
			if(TextThreeArray.length > 0)
			{
				TextThreeArray.pop();
			}
		}
		
		function drawCharts()
		{
			rLine.addChild(redRec);
			redRec.y = 0
			addChild(rLine);
			rLine.x = LinesX;
			rLine.y = LinesY;
			stage.addChild(rShape);
			rShape.x = redX;
			rShape.y = redY;
			
	
			gLine.addChild(greenRec);
			greenRec.y = 0
			addChild(gLine);
			gLine.x = LinesX;
			gLine.y = LinesY+30;
			stage.addChild(gShape);
			gShape.x = greenX;
			gShape.y = greenY;
			
			
			bLine.addChild(blueRec);
			blueRec.y = 0
			addChild(bLine);
			bLine.x = LinesX;
			bLine.y = LinesY+60;
			stage.addChild(bShape);
			bShape.x = blueX;
			bShape.y = blueY;
		}
	
		public function drawRedShape(redOutlineNum:Number,redLineWidth:Number) 
		{
			redRec.graphics.clear();
			redRec.graphics.beginFill(rColor,1);
			redRec.graphics.drawRect(0,-5,-10,10);
			redRec.graphics.endFill();
			
			rLine.graphics.clear();
			rLine.graphics.lineStyle(5,rOutColor,1,true);
			rLine.graphics.moveTo(0,0);
			rLine.graphics.lineTo(redLineWidth,0);
			redLineArray.push(rLine);
			if(redLineArray.length >0)
			{
				redLineArray.pop();
			}
			
			//var rShape:MovieClip = new MovieClip();
			rShape.graphics.clear();
			rShape.graphics.lineStyle(2,rOutColor,1,true);
			rShape.graphics.moveTo(radius,0);
			for (var c:uint = 0; c <= redOutlineNum; c++) 
			{
				rShape.graphics.lineTo(radius*Math.cos(c*Math.PI/180), -radius*Math.sin(c*Math.PI/180));
			}
			redArray.push(rShape);
			if(redArray.length >0)
			{
				redArray.pop();
			}
			
		}
		public function drawGreenShape(greenOutlineNum:Number,greenLineWidth:Number) 
		{
			greenRec.graphics.clear();
			greenRec.graphics.beginFill(gColor,1);
			greenRec.graphics.drawRect(0,-5,-10,10);
			greenRec.graphics.endFill();
			
			gLine.graphics.clear();
			gLine.graphics.lineStyle(5,gOutColor,1,true);
			gLine.graphics.moveTo(0,0);
			gLine.graphics.lineTo(greenLineWidth,0);
			greenLineArray.push(gLine);
			if(greenLineArray.length >0)
			{
				greenLineArray.pop();
			}
			
			//var gShape:MovieClip = new MovieClip();
			gShape.graphics.clear();
			gShape.graphics.lineStyle(2,gOutColor,1,true);
			//gShape.graphics.beginFill(gColor,transparency);
			gShape.graphics.moveTo(radius,0);
			for (var c:uint = 0; c <= greenOutlineNum; c++) 
			{
				gShape.graphics.lineTo(radius*Math.cos(c*Math.PI/180), -radius*Math.sin(c*Math.PI/180));
			}
			greenArray.push(gShape);
			if(greenArray.length >0)
			{
				greenArray.pop();
			}
		}
		public function drawBlueShape(blueOutlineNum:Number,blueLineWidth:Number) 
		{
			blueRec.graphics.clear();
			blueRec.graphics.beginFill(bColor,1);
			blueRec.graphics.drawRect(0,-5,-10,10);
			blueRec.graphics.endFill();
			
			bLine.graphics.clear();
			bLine.graphics.lineStyle(5,bOutColor,1,true);
			bLine.graphics.moveTo(0,0);
			bLine.graphics.lineTo(blueLineWidth,0);
			blueLineArray.push(bLine);
			if(blueLineArray.length >0)
			{
				blueLineArray.pop();
			}
			
			//var bShape:MovieClip = new MovieClip();
			bShape.graphics.clear();
			bShape.graphics.lineStyle(2,bOutColor,1,true);
			bShape.graphics.moveTo(radius,0);
			for (var c:uint = 0; c <= blueOutlineNum; c++) 
			{
				bShape.graphics.lineTo(radius*Math.cos(c*Math.PI/180), -radius*Math.sin(c*Math.PI/180));
			}
			blueArray.push(bShape);
			
			if(blueArray.length >0)
			{
				blueArray.pop();
			}
		}
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
		function roundToDecimal(num:Number, decimals:int)
		{
			var m:int = Math.pow(10, decimals);
			return Math.round(num * m) / m;
		}
		public function percentageValue(value:Number, min:Number, max:Number):Number 
		{
			var myPercent:Number;
			var difference:Number = max - min;
			myPercent = ((value - min) / difference);
			return 100*myPercent;
		}
		function kDown(event:KeyboardEvent):void
		{
			if(event.keyCode == 32)
			{
				r = randomRange(0,255);
				g = randomRange(0,255);
				b = randomRange(0,255);
			}
			if(event.keyCode == 39)
			{
				right = true;
			}
			if(event.keyCode == 37)
			{
				left = true;
			}
		}
		function kUp(event:KeyboardEvent):void
		{
			if(event.keyCode == 39)
			{
				
				right = false;
			}
			if(event.keyCode == 37)
			{
				left = false;
			}
		}
		public function mClick(event:MouseEvent):void
		{
			if(event.target == redRec)
			{
				redClick = true;
				greenClick = false;
				blueClick = false;
			}
			if(event.target == greenRec)
			{
				redClick = false;
				greenClick = true;
				blueClick = false;
			}
			if(event.target == blueRec)
			{
				redClick = false;
				greenClick = false;
				blueClick = true;
			}
		}
		

	}

}