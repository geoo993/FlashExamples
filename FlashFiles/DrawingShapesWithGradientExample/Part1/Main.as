package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.text.*;



	public class Main extends MovieClip
	{


		public var seconds:Number = 0;
		public var current:Number = .25;
		public var xPos:Number = 0;
		public var yPos:Number = 0;
		public var xMove:Number = 0;
		public var indexNum:Number = 0;

		public var lightningColor = Math.random() * 0xFFFFFF;
		public var shapeColor1:uint = Math.random() * 0xFFFFFF;
		public var shapeColor2:uint = Math.random() * 0xFFFFFF;
		public var shapeColor3:uint = Math.random() * 0xFFFFFF;

		public var xx1:Number = 0;
		public var yy1:Number = 0;
		public var xx2:Number = 0;
		public var yy2:Number = 0;
		public var xx3:Number = 0;
		public var yy3:Number = 0;
		public var xx4:Number = 0;
		public var yy4:Number = 0;
		public var xx5:Number = 0;
		public var yy5:Number = 0;

		public var radius2:Number = 0;
		public var widthNm:Number = 0;
		public var heightNm:Number = 0;
		public var curve:Number = 0;


		public var gradWidth:Number = 20;
		public var gradHeight:Number = 40;
		public var gradRotation:Number = Math.PI;
		public var gradRotation2:Number = Math.PI / 2;// 45° 
		public var gradRotation3:Number = Math.PI / 2;// 90°

		public var gradienType:String = GradientType.LINEAR;
		public var gradienType2:String = GradientType.RADIAL;
		//public var colors:Array = [shapeColor1,shapeColor2,shapeColor3];
		public var alphas:Array = [1,1,1];
		public var ratios:Array = [0,128,255];
		public var gradientBoxMatrix:Matrix = new Matrix  ;
		public var sprMethod:String = SpreadMethod.PAD;


		public var transparency:Number = 0;
		public var myArray:Array = new Array  ;
		public var myArray2:Array = new Array  ;

		public var shapeState:Number = 0;
		public var shapesState:Boolean = false;
		
		public var shapesSpawn:Boolean = false;

		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseD);
		}

		public function gL(myEvent:Event):void
		{



			//trace(Math.random()*current-Math.random()*current)
			seconds +=  1;
			if ((seconds > 10))
			{
				shapesState = true;
				shapeState = Math.round(Math.random() * 2);

				seconds = 0;
			}
			//xPos = Math.random() * 1000;
//			yPos = 800;
			xPos = stage.mouseX;
			yPos = stage.mouseY;
			
			
			xx1 = Math.random() * 1000;
			yy1 = randomRange(500,800);
			xx2 = Math.random() * 400;
			yy2 = randomRange(500,1000);
			xx3 = Math.random() * 300;
			yy3 = randomRange(500,1000);
			xx4 = Math.random() * 400;
			yy4 = randomRange(500,1000);
			transparency = Math.random() * 1;
			radius2 = randomRange(20,70);
			widthNm = randomRange(20,80);
			heightNm = randomRange(20,80);
			curve = Math.random() * 20;


			if ((shapesState == true))
			{
				//indexNum +=  1;
				//drawLine(xx1,yy1,xx2,yy2,xx3,yy3,xx4,yy4);
				drawShapes(xPos,yPos,radius2,widthNm,heightNm,curve,curve);
				shapeColor1 = Math.random() * 0xFFFFFF;
				shapeColor2 = Math.random() * 0xFFFFFF;
				shapeColor3 = Math.random() * 0xFFFFFF;
				lightningColor = Math.random() * 0xFFFFFF;


				shapesState = false;
			}

			for (var i:uint = 0; i < myArray.length; i++)
			{

				myArray[i].y -=  3;
				//myArray[i].x -=  Math.random()*current-Math.random()*current;

				if (myArray[i].y < -300)
				{
					destroyLine(myArray[i]);
				}
			}


			for (var a:uint = 0; a < myArray2.length; a++)
			{
				myArray2[a].y -=  3;

				if (myArray2[a].y < -500)
				{
					myArray2.splice(a,1);
				}

			}

		}
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}

		function drawLine(x1:Number,y1:Number,x2:Number,y2:Number,x3:Number,y3:Number,x4:Number,y4:Number)
		{
			var myLine:MovieClip = new MovieClip  ;

			myLine.graphics.lineStyle(2,lightningColor,1,true);
			myLine.graphics.beginFill(shapeColor1,transparency);
			myLine.graphics.moveTo(x1,y1);
			myLine.graphics.lineTo(x2,y2);
			myLine.graphics.lineTo(x3,y3);
			myLine.graphics.lineTo(x4,y4);
			myLine.graphics.lineTo(x1,y1);
			myLine.graphics.endFill();

			stage.addChild(myLine);
			myArray2.push(myLine);
		}
		function drawShapes(x1:Number,y1:Number,radius:Number,widthN:Number,heightN:Number,ellipseWidth:Number,ellipseHeight:Number)
		{
			var myShape:MovieClip = new MovieClip  ;
			var colors:Array = [shapeColor1,shapeColor2,shapeColor3];
			myShape.graphics.lineStyle(2,lightningColor,1,true);

			gradientBoxMatrix.createGradientBox(gradWidth,gradHeight,gradRotation2,x1,y1);
			myShape.graphics.beginGradientFill(gradienType,colors,alphas,ratios,gradientBoxMatrix,sprMethod);
			//myShape.graphics.beginFill(shapeColor1,transparency);

			if ((shapeState == 0))
			{
				myShape.graphics.drawCircle(x1,y1,radius);
			}
			if ((shapeState == 1))
			{
				myShape.graphics.drawRoundRect(x1,y1,widthN,heightN,ellipseWidth,ellipseHeight);
			}
			if ((shapeState == 2))
			{
				myShape.graphics.drawRect(x1,y1,widthN,heightN);
			}
			myShape.graphics.endFill();

			stage.addChild(myShape);
			myArray.push(myShape);



			//for (var i:uint = 0; i < myArray.length; i++)
			//{

			////myArray[i].x -= randomRange(-2, 2);
			//if (myArray.length > indexNum)
			//{
			//destroyLine(myArray[i]);
			//}
			//
			//}
		}
		public function destroyLine(newLine:MovieClip):void
		{
			var thisLine:MovieClip;

			for (var i:uint = 0; i < myArray.length; i++)
			{
				thisLine = myArray[i];

				if ((thisLine == newLine))
				{
					myArray.splice(i,1);

					newLine.parent.removeChild(newLine);
				}
			}
		}


		function kDown(event:KeyboardEvent):void
		{
			if (event.keyCode == 68)
			{
				drawLine(xx1,yy1,xx2,yy2,xx3,yy3,xx4,yy4);
			}

			if (event.keyCode == 32)
			{
				shapesState = true;

			}
		}
		public function mouseD(event:MouseEvent):void
		{
			//shapeState = Math.round(Math.random() * 2);


		}

	}

}