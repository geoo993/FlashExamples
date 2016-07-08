package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.text.*;
	import com.greensock.*;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;


	public class Main extends MovieClip
	{
		
		
		public var lightningColor = Math.random() * 0xFFFFFF;
		public var shapeColor1:uint = Math.random() * 0xFFFFFF;
		public var shapeColor2:uint = Math.random() * 0xFFFFFF;
		public var shapeColor3:uint = Math.random() * 0xFFFFFF;
		
		public var recH:Number = 80;
		public var recW:Number = 80;
		public var cirW:Number = 60;
		
		public var xP:Number = 100;
		public var yP:Number = 100;
		public var controlRec:Boolean = false;
		public var up:Boolean = false;
		public var down:Boolean = false;
		public var left:Boolean = false;
		public var right:Boolean = false;

		public var removeNum:Number = 0;
		
		public var eggScaleX:Number = 90;
        public var eggScaleY:Number = 1;
		public var eggWidth:Number = 0;
        public var eggHeight:Number = 0;
		
		
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
		
		public var gradState:Number = 0;
		public var gradRotation:Number = 0;//0
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
		
		public var allArray:Array = new Array(myArray,myArray2)  ;
		public var myArray:Array = new Array  ;
		public var myArray2:Array = new Array  ;
		public var curveArray:Array = new Array;
		public var eggArray:Array = new Array ;
		
		public var recArray:Array = new Array  ;
		public var circlArray:Array = new Array  ;
		
		public var shapeState:Number = 0;
			
		public var eggStatee:Number = 0;
		public var indexNumm:Number = 1;

		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,onMyRelease);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseD);
			
		}

		public function gL(myEvent:Event):void
		{
		
				xx1 = Math.random() * 800;
				yy1 = Math.random() * 800;
				xx2 = Math.random() * 400;
				yy2 = Math.random() * 400;
				xx3 = Math.random() * 300;
				yy3 = Math.random() * 300;
				xx4 = Math.random() * 400;
				yy4 = Math.random() * 400;
				xx5 = Math.random() * 500;
				yy5 = Math.random() * 500;
	
			
			transparency = Math.random() * 1;
			radius2 = Math.random() * 70;

			widthNm = Math.random() * 100;
			heightNm = Math.random() * 100;
			curve = Math.random() * 20;

			for (var a:uint = 0; a < myArray2.length; a++)
			{
				myArray2[a].y +=  3;

				if (myArray2[a].y > 300)
				{
					destroy2(myArray2[a]);
				} 
			}
		
			
			for (var i:uint = 0; i < myArray.length; i++)
			{
				myArray[i].y -=  3;

				if (myArray[i].y < -300)
				{
					destroy1(myArray[i]);
				}
			}
			
			
			if (up == true)
			{
				yP -= 5;
			}

			if (down == true)
			{
				yP += 5;
			}
			if (left==true)
			{
				xP -= 5;
			}
			if (right==true)
			{
				
				xP += 5;
			}
			
			
		}
		 function circle(x1:Number,y1:Number,radius:Number)
		{
			var myCircle:MovieClip = new MovieClip  ;
			myCircle.graphics.lineStyle(2,lightningColor,1,true);
			myCircle.graphics.beginFill(shapeColor2,1); 
			myCircle.graphics.drawCircle(x1+20,y1+20,radius/2);
			
			myCircle.graphics.endFill();
			
			stage.addChild(myCircle);
			circlArray.push(myCircle)
			
			for (var n:uint = 0; n < circlArray.length; n++)
				{
					if (circlArray.length > 1)
					{
						destroyCircle(circlArray[n])
					}
				}
		}
		
		function drawCurve()
		{
			var myCurve:MovieClip = new MovieClip  ;
			myCurve.graphics.beginFill(shapeColor2,transparency); 

            myCurve.graphics.moveTo(250, 0);
            myCurve.graphics.cubicCurveTo(275, 0, 300, 25, 300, 50);
            myCurve.graphics.cubicCurveTo(300, 75, 275, 100, 250, 100);
            myCurve.graphics.cubicCurveTo(225, 100, 200, 75, 200, 50);
            myCurve.graphics.cubicCurveTo(200, 25, 225, 0, 250, 0);
			myCurve.graphics.endFill();
			
			stage.addChild(myCurve);
			curveArray.push(myCurve);
			
			
		}
		function drawLine(x1:Number,y1:Number,x2:Number,y2:Number,x3:Number,y3:Number,x4:Number,y4:Number)
		{
			var myLine:MovieClip = new MovieClip  ;

			myLine.graphics.lineStyle(2,lightningColor,1,true);
			myLine.graphics.beginFill(shapeColor1,transparency);
			myLine.graphics.moveTo(x1,y1);
			myLine.graphics.lineTo(x2, y2);
			myLine.graphics.lineTo(x3, y3);
			myLine.graphics.lineTo(x4, y4);
			myLine.graphics.lineTo(x1, y1);
			myLine.graphics.endFill();

			stage.addChild(myLine);
			myArray2.push(myLine);
			

		}
		function drawShapes(x1:Number,y1:Number,radius:Number,widthN:Number,heightN:Number,ellipseWidth:Number,ellipseHeight:Number)
		{
			var myShape:MovieClip = new MovieClip  ;
			var colors:Array = [shapeColor1,shapeColor2,shapeColor3];
			myShape.graphics.lineStyle(2,lightningColor,1,true);

			if ((gradState == 0))
			{
				gradRotation = 0;
			}
			if ((gradState == 1))
			{
				gradRotation = gradRotation2 
			}
			if ((gradState == 2))
			{
				gradRotation = gradRotation3;
			}
			
			gradientBoxMatrix.createGradientBox(gradWidth,gradHeight,gradRotation,x1,y1);
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

			/*for (var i:uint = 0; i < myArray.length; i++)
			{
				if (myArray.length > removeNum)
				{
					destroy1(myArray[i]);
				}

			}*/
		}
		 public function drawEgg(eggSize:Number, xPos:Number, yPos:Number,eWidth:Number,eHeight:Number):void  
		{
            
            var myEgg:MovieClip = new MovieClip();
            
            myEgg.graphics.beginFill(0xFFFFFF);
            myEgg.graphics.lineStyle(1);
            myEgg.graphics.drawEllipse(xPos, yPos, eWidth, eHeight);
			
				if(eggSize == 0)
				{  
					eWidth = 60;
					eHeight = 70;
					
					eggWidth = eWidth;
					eggHeight = eHeight;
				}
				if(eggSize == 1)
				{
					eWidth = 120;
					eHeight = 150;
					
					eggWidth = eWidth;
					eggHeight = eHeight;
				}
				if(eggSize == 2)
				{
					eWidth = 150;
					eHeight = 200;
					
					eggWidth = eWidth;
					eggHeight = eHeight;
				}
            
            myEgg.graphics.endFill();
    
            stage.addChild(myEgg);
			eggArray.push(myEgg)
			
			for (var d:uint = 0; d < eggArray.length; d++)
			{
				if (eggArray.length > indexNumm)
				{
					destroyEgg(eggArray[d]);
				}
				
			}
			
			
			
        }
		public function destroyEgg(newEgg:MovieClip):void
		{
			var thisEgg:MovieClip;

			for (var i:uint = 0; i < eggArray.length; i++)
			{
				thisEgg = eggArray[i];

				if (thisEgg == newEgg)
				{
					eggArray.splice(i,1);
					newEgg.parent.removeChild(newEgg);
				}
			}
		}
		public function destroy1(newLine:MovieClip):void
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
        public function destroy2(newLine2:MovieClip):void
		{
			var thisLine2:MovieClip;

			for (var i:uint = 0; i < myArray2.length; i++)
			{
				thisLine2 = myArray2[i];

				if ((thisLine2 == newLine2))
				{
					myArray2.splice(i,1);
					newLine2.parent.removeChild(newLine2);
				}
			}
		}
	      
		public function destroyRec(newRec:MovieClip):void
		{
			var thisRec:MovieClip;

			for (var i:uint = 0; i < recArray.length; i++)
			{
				thisRec = recArray[i];

				if ((thisRec == newRec))
				{
					recArray.splice(i,1);
					newRec.parent.removeChild(newRec);
				}
			}
		}
		 public function destroyCircle(newCir:MovieClip):void
		{
			var thisCir:MovieClip;

			for (var i:uint = 0; i < circlArray.length; i++)
			{
				thisCir = circlArray[i];

				if ((thisCir == newCir))
				{
					circlArray.splice(i,1);
					newCir.parent.removeChild(newCir);
				}
			}
		}
		function kDown(event:KeyboardEvent):void
		{
			if(event.keyCode == 68)
			{
				drawLine(xx5,yy5,xx2,yy2,xx3,yy3,xx4,yy4);
			}
			if (event.keyCode == 70)
			{
				controlRec = ! controlRec;
				
			}
            
			if (event.keyCode == 32)
			{

				removeNum +=  1;
				drawEgg(Math.round(Math.random() * 2),xx5,yy5,eggWidth,eggHeight);
				drawShapes(stage.mouseX,stage.mouseY,radius2,widthNm,heightNm,curve,curve);
				
				shapeColor1 = Math.random() * 0xFFFFFF;
				shapeColor2 = Math.random() * 0xFFFFFF;
				shapeColor3 = Math.random() * 0xFFFFFF;
				lightningColor = Math.random() * 0xFFFFFF;
			} 
			
			
			if (event.keyCode == 39)
			{
				right = true;
			}
			if (event.keyCode == 37)
			{
				left = true;
			}
			if (event.keyCode == 38)
			{
				up = true;
			}
            if (event.keyCode == 40)
			{
				//rect(100,100,newW,newH)
				down = true;
			}

			
		}
		
		function onMyRelease(event:KeyboardEvent):void
		{
			if (event.keyCode == 39)
			{
				right = false;
			}
			if (event.keyCode == 37)
			{
				left = false;
			}
			if (event.keyCode == 38)
			{
				up = false;
			}
            if (event.keyCode == 40)
			{
				down = false;
			}
		}
		public function mouseD(event:MouseEvent):void
		{
			shapeState = Math.round(Math.random() * 2);
            gradState = Math.round(Math.random() * 2);
			eggStatee = Math.round(Math.random() * 2);
			//indexNumm += 1;
			
		}
		


	}

}