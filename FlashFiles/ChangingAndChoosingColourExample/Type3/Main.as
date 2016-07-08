package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.text.*;
	import fl.motion.Color;
	import com.greensock.*;
	import com.greensock.easing.*;

	public class Main extends MovieClip
	{
		
		public var sLength:Number = 20; 
		public var shapeType:Number = 0;
		public var transparency:Number = 1;
		
		public var sOutColor:uint = Math.random() * 0xFFFFFF;
		public var sColor:uint = Math.random() * 0xFFFFFF;
		
		public var color1:uint;
		public var color2:uint;
		
		public var textColor:uint = Math.random() * 0xffffff;
		public var TextColor:uint = Math.random() * 0xffffff;
		public var TextsColor:uint = Math.random() * 0xffffff;
		public var TextsOutlineColor:uint = Math.random() * 0xffffff;
		
		public var bgColor:uint = Math.random() * 0xffffff;
		public var bgColorTransform = new ColorTransform  ;
		public var sColorTransform = new ColorTransform  ;
		
		public var numberOfshapes:uint = 5;
		public var numberOfText:uint = 10;
		public var TextOne:String;
		public var TextXpos:Number = 0;
		public var TextYpos:Number = 0;
		public var selectedSprite:MovieClip;
		
        public var currentIndex:uint;
		
		public var Angle:Number =  0;
		
		public var TextOneText:TextField = new TextField();
		public var TextOneFormat:TextFormat = new TextFormat  ;
	
		public var titleText:TextField = new TextField();
		public var titleTextFormat:TextFormat = new TextFormat  ;
		
		public var interText:TextField = new TextField();
		public var interTextFormat:TextFormat = new TextFormat  ;
		
		public var myColor:Boolean = false;
		public var toggleAnimation = false;
		
		public var TextArray:Array = new Array() ;
		public var interTextArray:Array = new Array() ;
		public var shapeArray:Array = new Array();
		
		public var colorTransSwitch:String = "idle";
		public var colorTransNum:Number = 0;
		public var curVal:Number= 0;
		
		public var container:MovieClip =  new MovieClip();;
		
		public var now:Number = 0;
		public var then:Number = 0;
			
		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,kUp);
			stage.addEventListener(MouseEvent.MOUSE_OVER,mOver);
			stage.addEventListener(MouseEvent.MOUSE_OUT,mOut);
			
		}             
		function TitleText()
		{
			
			titleText.text = "Changing Background Color with interpolation";
			titleText.textColor = textColor;
			titleText.width = 500;
			titleText.height = 40;
			titleText.selectable = false;
		
			titleText.setTextFormat(titleTextFormat);
			titleTextFormat.italic = true; 
			titleTextFormat.size = 20;
			titleTextFormat.font = "Comic Sans MS";
			titleTextFormat.align = TextFormatAlign.LEFT;
			
			addChild(titleText);
			titleText.x = 400;
			titleText.y = 80;
			
			TextArray.push(titleText);
			
			if(TextArray.length > 0)
			{
				TextArray.pop();
			}
		}
		function InterPoleText()
		{
			
			interText.text = "Transitioning........" //"Interpoling......";
			interText.textColor = textColor;
			interText.width = 300;
			interText.height = 40;
			interText.selectable = false;
		
			interText.setTextFormat(interTextFormat);
			interTextFormat.italic = true; 
			interTextFormat.size = 20;
			interTextFormat.font = "Comic Sans MS";
			interTextFormat.align = TextFormatAlign.CENTER;
			
			addChild(interText);
			interText.x = 460;
			interText.y = 600;
			
			interTextArray.push(interText);
			
			if(interTextArray.length > 0)
			{
				interTextArray.pop();
			}
		}
		public function drawShapes()
		{
			addChild(container);
			container.x = stage.stageWidth/2;
			container.y = stage.stageHeight/2;
			
			for (var i:uint = 0; i < numberOfshapes; i++) 
			{   
				//sColor = Math.random() * 0xFFFFFF;
				var myShape:MovieClip = new Shapess();
				myShape.graphics.clear();
				//myShape.graphics.lineStyle(2,sOutColor,1,true);
				myShape.graphics.beginFill(sColor,transparency);
				
				if(shapeType == 0)
				{
					myShape.graphics.moveTo(0,0);
					myShape.graphics.lineTo(0,-sLength);
					myShape.graphics.lineTo(sLength,-sLength);
					myShape.graphics.lineTo(sLength,sLength);
					myShape.graphics.lineTo(-sLength,sLength);
					myShape.graphics.lineTo(-sLength,-sLength);
					myShape.graphics.lineTo(0,-sLength);
					//myShape.graphics.drawRect(0,0,sLength,sLength);
				}
				if(shapeType == 1)
				{
					myShape.graphics.moveTo(0,0);
					for (var c:uint = 0; c <= 360; c++) 
					{
						myShape.graphics.lineTo(sLength*Math.cos(c*Math.PI/180), -sLength*Math.sin(c*Math.PI/180));
					}
					myShape.graphics.lineTo(0,0);
				}
				myShape.graphics.endFill();
				
				/*TextOne =  ""+i;
				var TextOneText:TextField = new TextField(); 
				TextOneText.text = TextOne.toString();
				TextOneText.textColor = TextsColor;
				TextOneText.width = 20;
				TextOneText.height = 14;
				TextOneText.border = true;
				TextOneText.selectable = false;
				
				var TextOneFormat:TextFormat = new TextFormat  ;
				TextOneText.setTextFormat(TextOneFormat);
				TextOneFormat.size = 2;
				TextOneFormat.font = "Comic Sans MS";
			
				TextOneText.x = (-TextOneText.width/2);
				TextOneText.y = (-TextOneText.height/2);
				
				myShape.addChild(TextOneText);*/
				container.addChild(myShape);
				shapeArray.push(myShape);
			
				var pos:Point = Point.polar(200, (i / numberOfshapes) * Math.PI * 2);
				myShape.x = pos.x;
				myShape.y = pos.y;
				
				
				if(shapeArray.length > numberOfshapes)
				{
					destroyShape(myShape);
				} 
			}
			addListeners();
		}
		public function removeShapes()
		{
			for (var i:uint = 0; i < shapeArray.length; i++)
			{
				 destroyShape(shapeArray[i]);
			}
		}
		public function addListeners():void
		{
			for (var i:uint = 0; i < shapeArray.length; i++)
			{
				shapeArray[i].buttonMode = true;
				shapeArray[i].addEventListener(MouseEvent.CLICK,clickEvent);
			}
		}
		public function removeListeners():void
		{
			for (var i:uint = 0; i < shapeArray.length; i++)
			{
				shapeArray[i].buttonMode = false;
				shapeArray[i].removeEventListener(MouseEvent.CLICK,clickEvent);
			}
		}

		public function clickEvent(e:MouseEvent):void
		{
			selectedSprite = e.currentTarget as MovieClip;
			currentIndex = shapeArray.indexOf(e.currentTarget);
			
			colorTransSwitch = "startCount";
			//trace(selectedSprite.transform.colorTransform.color.toString(16))
			//trace(sColor.toString(16))
			removeListeners();
			
		}
		public function shapesColor()
		{    
			
			if(myColor == false)
			{  
				for (var i:uint = 0; i < shapeArray.length; i++)
				{
					textColor =  Math.random() * 0xFFFFFF;
					sColor = Math.random() * 0xFFFFFF;
					sColorTransform.color = sColor;
					shapeArray[i].transform.colorTransform = sColorTransform;
				}  
				myColor = true;
			}
			
			var getColorCode = "0x"+shapeArray[currentIndex].transform.colorTransform.color.toString(16);
			
			if(colorTransSwitch == "startCount")
			{   
				colorTransNum = 0;
				curVal = 0;
				colorTransSwitch = "counting";
			}
			
			if(colorTransSwitch == "counting")
			{   
				interText.visible = true
				colorTransNum += 2;
				if(curVal >= 1)
				{
					
					colorTransNum = 255;
					colorTransSwitch = "idle";
				}
			}
			else
			{
				interText.visible = false
			}
			
			now = colorTransNum;
			if(now > then)
			{
				color2 = getColorCode;
			}
			else if(now < then)
			{
			}
			else
			{
				color1 = getColorCode;
			}
			then = now;
			
			curVal = colorTransNum/255;
			var transitionColor = Color.interpolateColor(color1,color2,curVal);
			
			//bgColorTransform.color = getColorCode;
			stage.color = transitionColor;
			bgColorTransform.color = transitionColor;
			bg.transform.colorTransform = bgColorTransform;
			
			//trace(shapeArray[currentIndex].name+"    "+shapeArray[currentIndex].transform.colorTransform.color.toString(16))
			//trace(getColorCode+"   "+colorTransNum)
			//trace(colorTransSwitch+"  "+colorTransNum+"  "+curVal.toFixed(2));
		}
		public function gL(myEvent:Event):void
		{
			
			if(toggleAnimation == false)
			{
				shapeType = randomRange(0,1);
				drawShapes(); 
				shapesColor();
			}
			if(toggleAnimation == true)
			{
				removeShapes();
				colorTransSwitch = "startCount";
			}
			TitleText();
			InterPoleText();
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
		public function destroyShape(newShape:MovieClip):void
		{
			var thisShape:MovieClip;

			for (var i:uint = 0; i < shapeArray.length; i++)
			{
				thisShape = shapeArray[i];

				if ((thisShape == newShape))
				{
					shapeArray.splice(i,1);
					newShape.parent.removeChild(newShape) 
					newShape = null;
				}
			}
		}
		public function mOver(event:MouseEvent):void
		{
			for (var i:uint = 0; i < shapeArray.length; i++)
			{
				if (event.target == shapeArray[i])
				{
					TweenNano.to(shapeArray[i], 1, {scaleX:2,scaleY:2});
				}
			}
		}
		public function mOut(event:MouseEvent):void
		{
			for (var i:uint = 0; i < shapeArray.length; i++)
			{
				if (event.target == shapeArray[i])
				{
					TweenNano.to(shapeArray[i], 1, {scaleX:1,scaleY:1});
				}
			}
		}
		
		function kDown(event:KeyboardEvent):void
		{  
			if (event.keyCode == 32)
			{
				toggleAnimation = !toggleAnimation;
				myColor = false;
			}
		}
		function kUp(event:KeyboardEvent):void
		{
			if (event.keyCode == 32)
			{
				
			}
		}	

	}

}