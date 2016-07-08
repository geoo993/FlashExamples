package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;


	public class Main extends MovieClip
	{
		public var gradRotation1:Number = Math.PI;
		public var gradRotation2:Number = Math.PI/2;// 45° 
		public var gradRotation3:Number = Math.PI/4;// 90°
		public var gradRotation4:Number = -Math.PI/2;// 90°
		public var gradRotation5:Number = -Math.PI/4;;
		public var gradientRotationArray:Array = new Array(gradRotation1,gradRotation2,gradRotation3,gradRotation4,gradRotation5) 

		public var gradienType1:String = GradientType.LINEAR;
		public var gradienType2:String = GradientType.RADIAL;
		public var gradientTypeArray:Array = new Array(gradienType1,gradienType2); 

		public var gradientMatrix:Matrix = new Matrix  ;
		
		public var sprMethodPad:String = SpreadMethod.PAD;
        public var sprMethodRepeat:String = SpreadMethod.REPEAT;
		public var sprMethodReflect:String = SpreadMethod.REFLECT;
		public var sprMethodArray:Array = new Array(sprMethodPad,sprMethodRepeat,sprMethodReflect)
		
		public var InterpolationMethodRGB1:String = InterpolationMethod.LINEAR_RGB;
		public var InterpolationMethodRGB2:String = InterpolationMethod.RGB;
		public var InterpolationMethodArray:Array = new Array(InterpolationMethodRGB1,InterpolationMethodRGB2)
		
		public var myShape:MovieClip = new MovieClip();
		public var myShapeArray:Array = new Array();
		
		var gType:String = gradienType1;

		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gloop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, kDown);
			stage.addEventListener(MouseEvent.CLICK,handleClick);
			
			drawShapeWithGradient(0,0,stage.stageWidth,stage.stageHeight-30, gType);
		}
		
		public function gloop(myEvent:Event):void
		{  
			typeText.text = gType;
		}
		function drawShapeWithGradient(x1:Number,y1:Number,widthh:int,heightt:int,gradientType:String )
		{
			var oulineThickness:Number = randomRange(1,5);
			var outlineAplha:Number = randomRange(0,1);
			var outlineColor = Math.random() * 0xFFFFFF;
			var shapeColor1:uint = Math.random() * 0xFFFFFF;
			var shapeColor2:uint = Math.random() * 0xFFFFFF;
			var shapeColor3:uint = Math.random() * 0xFFFFFF;
			
			var alphas:Array = [randomRange(0,1),randomRange(0,1),randomRange(0,1)];
			var ratios:Array = [randomRange(0,255),randomRange(0,255),randomRange(0,255)];
			var colors:Array = [shapeColor1,shapeColor2,shapeColor3];
			//var gType:String = gradientTypeArray[int(randomRange(0,gradientTypeArray.length-1))];
			var gRotation:Number = gradientRotationArray[int(randomRange(0,gradientRotationArray.length-1))];
			var gSpreadMethod:String = sprMethodArray[int(randomRange(0,sprMethodArray.length-1))];
			var gInterpolationM:String = InterpolationMethodArray[int(randomRange(0,InterpolationMethodArray.length-1))];
			gradientMatrix.createGradientBox(widthh,heightt,gRotation,x1,y1);
			
			myShape = new MovieClip  ;
			myShape.graphics.clear();
			myShape.graphics.lineStyle(oulineThickness,outlineColor,outlineAplha,true);

			myShape.graphics.beginGradientFill(gradientType,colors,alphas,ratios,gradientMatrix,gSpreadMethod,gInterpolationM);
			//myShape.graphics.beginFill(shapeColor1,1);

			myShape.graphics.drawRect(x1,y1,widthh,heightt);
			stage.addChild(myShape);
			myShapeArray.push(myShape);
			
			trace("gradientType: "+gType+"   color1: "+shapeColor1.toString(16)+"   color2: "+shapeColor2.toString(16)+"   color3: "+shapeColor3.toString(16)+"   alphas: "+alphas+"  ratios: "+ratios+"   spreadMethod: "+gSpreadMethod+"   rotation: "+gRotation+"   interpolationMethod: "+gInterpolationM)

		}
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.random() * ((maxNum - minNum) + 1) + minNum;
		}
		function kDown(event:KeyboardEvent):void
		{ 
			if (event.keyCode == 32)
			{
				myShapeArray.pop();
				myShape.parent.removeChild(myShape) 
				
				drawShapeWithGradient(0,0,stage.stageWidth,stage.stageHeight-30, gType);
			}
		}
		
		function handleClick(evt:MouseEvent):void 
		{
			if(evt.target == typeBut)
			{
				
				if (gType == gradienType1){
					
					gType = gradienType2;
					
				}else if (gType == gradienType2){
					gType = gradienType1;
				}
			}
			
		}
		

	}

}