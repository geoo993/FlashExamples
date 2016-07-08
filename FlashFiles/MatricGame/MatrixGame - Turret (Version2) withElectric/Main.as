package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.globalization.*;


	public class Main extends MovieClip
	{
		public var sentArray:Array = new Array  ;
		public var bulletsArray:Array = new Array  ;
		
		public var turretsArray:Array = new Array  ;
		public var baseArray:Array = new Array  ;
		public var frontBoxArray:Array = new Array  ;
		public var ammoArray:Array = new Array  ;
		public var hitArray:Array = new Array () ;

		public var turretOneArray:Array = new Array  ;
		public var turretTwoArray:Array = new Array  ;
		public var turretThreeArray:Array = new Array  ;
		public var turretFourArray:Array = new Array  ;
		
		public var hitGlow:GlowFilter = new GlowFilter(glow_color2,1,glow_blurX,glow_blurY,glow_strength,glow_quality);
		public var filter_glow:GlowFilter = new GlowFilter(glow_color,glow_alpha,glow_blurX,glow_blurY,glow_strength,glow_quality);

		public var tempp:MovieClip;
		public var tempp2:MovieClip;

		public var maxSpeed:Number = 5;
		public var minSize:Number = 2;
		public var maxSize:Number = 10;
		public var minFragments:Number = 15;
		public var maxFragments:Number = 30;
		public var fragmentRange:Number = 80;


		public var totalFragments:Number = randRange(minFragments,maxFragments);

		public var lightningOffset:Number = 15;
		public var lightningFrequency:Number = 15;
		public var lightningWidth:Number = 1;
		public var lightningColor = "0x5C98EF";
		public var lightningColor2 = "0xFFD801";
		public var lightningColor3 = "0xffff00";
		public var lightningAlpha:Number = .75;
		public var lightningAlpha2:Number = .01;
		public var lightningBranches:Number = 3;
		public var sparkNumber:Number = 5;
		public var sparkDistance:Number = 10;
		public var sparkSize:Number = 100;

		public var glow_color:Number = lightningColor;
		public var glow_color2:Number = lightningColor2;
		public var glow_alpha:Number = 0.6;
		public var glow_blurX:Number = 5;
		public var glow_blurY:Number = 5;
		public var glow_strength:Number = 2;
		public var glow_quality:Number = 3;

		public var rotationRadss:Number;
		public var rotationDirection:Number;
		public var rotationDirection2:Number;
		public var rotationDirection3:Number;
		public var trueRotation:Number;

		public var rotationSpeedMax:Number = 20;

		public var xPos:Number;
		public var yPos:Number;

		public var speedX:Number;
		public var speedY:Number;

		public var angleRads:Number = 0;
		public var angleDegrees:Number = 0;

		public var t1healthNum:Number = 100;
		public var t2healthNum:Number = 100;
		public var t3healthNum:Number = 100;
		public var t4healthNum:Number = 100;

		public var myColorTransform = new ColorTransform  ;
		public var myColor1:uint = 0xF70D1A;

		public var turretState:Boolean = false;
		public var shootType:Boolean = false;
		public var hitState:Boolean = false;

		public var myFormat:TextFormat = new TextFormat  ;

		public var Lazer:MovieClip = new myLine  ;
		public var baseLine:MovieClip = new myLine2  ;

		public var spark11:Spark1 = new Spark1  ;
		public var spark22:Spark2 = new Spark2  ;
		public var spark33:Spark3 = new Spark3  ;

		public var shootingState:String = "Fire";


		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onMyPress);
			stage.addEventListener(MouseEvent.CLICK,mouseClick);
			stage.addEventListener(MouseEvent.MOUSE_OVER,mOver);
			stage.addEventListener(MouseEvent.MOUSE_OUT,mOut);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,mDown);
			stage.addEventListener(MouseEvent.MOUSE_UP,mUp);

			tempp = target_mc;
			tempp2 = electTarget;

			turretOneArray.push(baseArray[1]);
			//turretTwoArray.push(baseArray[3]);
			turretThreeArray.push(baseArray[2]);
			turretFourArray.push(baseArray[0]);
			

		}

		public function gL(myEvent:Event):void
		{
			electTarget.alpha = 0;

			if (stage.mouseY < 840)
			{
				turretsRotation();
				if (shootType == false)
				{
					shootingState = "Fire";
				}
				if (shootType == true)
				{
					shootingState = "Lazer";
				}
			}
			else
			{
				shootingState = "OffDatge";
			}

			if ((shootingState == "OffDatge"))
			{
				baseLine.graphics.clear();
				Lazer.graphics.clear();
				electTarget.x = 1000;
				electTarget.y = 1000;
				mouseTarg.x = 10000;
				mouseTarg.y = 10000;
				addSparkles(10000,10000,sparkNumber,sparkDistance,sparkSize);

			}
			if ((shootingState == "Lazer"))
			{
				baseLine.graphics.clear();
				addChild(Lazer);
				electTarget.x = stage.mouseX;
				electTarget.y = stage.mouseY;
				mouseTarg.x = 10000;
				mouseTarg.y = 10000;
				addSparkles(stage.mouseX,stage.mouseY,sparkNumber,sparkDistance,sparkSize);
				electricWeapon(0,840,500,840);
			}
			if ((shootingState == "Fire"))
			{
				Lazer.graphics.clear();
				addChild(baseLine);
				electTarget.x = 10000;
				electTarget.y = 10000;
				mouseTarg.x = stage.mouseX;
				mouseTarg.y = stage.mouseY;
				baseWeapon(0,840,500,840);
				addSparkles(10000,10000,sparkNumber,sparkDistance,sparkSize);

			}

		}
		function electricWeapon(xStart:Number,yStart:Number,xEnd:Number,yEnd:Number)
		{

			Lazer.filters = [filter_glow];
			Lazer.graphics.clear();
			Lazer.graphics.lineStyle(lightningWidth,lightningColor,lightningAlpha,true);

			var distanceX:Number = xStart - xEnd;
			var distanceY:Number = yStart - yEnd;
			var distanceTotal:Number = Math.sqrt(((distanceX * distanceX) + distanceY * distanceY));

			var numberOfSteps:Number = distanceTotal / lightningFrequency;

			var angle:Number = Math.atan2((yStart - yEnd),xStart - xEnd);

			var stepInPixels:Number = distanceTotal / numberOfSteps;

			for (var j = 0; j < lightningBranches; j++)
			{
				Lazer.graphics.moveTo(xStart,yStart);

				for (var i = 1; i < (numberOfSteps + 1); i++)
				{

					var currentStepPosition:Number = stepInPixels * i;
					var randomOffset:Number = Math.random() * (lightningOffset - lightningOffset / 2);
					var xStepPosition:Number = xStart - Math.cos(angle) * currentStepPosition + Math.cos((angle + 1.55)) * randomOffset;
					var yStepPosition:Number = yStart - Math.sin(angle) * currentStepPosition + Math.sin((angle + 1.55)) * randomOffset;

					Lazer.graphics.lineTo(xStepPosition,yStepPosition);
				}

				Lazer.graphics.lineTo(xEnd,yEnd);

			}


		}
		function baseWeapon(xStart2:Number,yStart2:Number,xEnd2:Number,yEnd2:Number)
		{
			baseLine.graphics.lineStyle(2,lightningColor2,lightningAlpha2,true);
			baseLine.graphics.moveTo(xStart2,yStart2);
			baseLine.graphics.lineTo(xEnd2,yEnd2);
			
		}
		function addSparkles(_targetX:Number,_targetY:Number,_sparkNumber:Number,_distance:Number,_sparkSize:Number)
		{
			for (var i = 0; i < _sparkNumber; i++)
			{
				addChild(spark11);
				addChild(spark22);
				addChild(spark33);

				spark11.x = (_targetX + Math.random() * (_distance - _distance / 2)) - 5;
				spark11.y = (_targetY + Math.random() * (_distance - _distance / 2)) - 10;
				spark22.x = (_targetX + Math.random() * (_distance - _distance / 2)) - 5;
				spark22.y = (_targetY + Math.random() * (_distance - _distance / 2)) - 10;
				spark33.x = (_targetX + Math.random() * (_distance - _distance / 2)) - 5;
				spark33.y = (_targetY + Math.random() * (_distance - _distance / 2)) - 10;

				var tempRandomSize = Math.random() * _sparkSize / 20;
				spark11.scaleX = tempRandomSize;
				spark11.scaleY = tempRandomSize;

				var tempRandomSize2 = Math.random() * _sparkSize / 20;
				spark22.scaleX = tempRandomSize2;
				spark22.scaleY = tempRandomSize2;

				var tempRandomSize3 = Math.random() * _sparkSize / 20;
				spark33.scaleX = tempRandomSize3;
				spark33.scaleY = tempRandomSize3;

				spark11.rotation = Math.random() * 359;
				spark22.rotation = Math.random() * 359;
				spark33.rotation = Math.random() * 359;

				spark11.alpha = lightningAlpha;
				spark22.alpha = lightningAlpha;
				spark33.alpha = lightningAlpha;

			}

		}


		public function randRange(min:Number,max:Number):Number
		{
			var randomNum:Number = Math.floor(Math.random() * ((max - min) + 1)) + min;
			return randomNum;
		}
		public function explosion(temp:MovieClip)
		{

			for (var i:Number = 0; i < totalFragments; i++)
			{

				var fire:Fire = new Fire(this);
				this.addChild(fire);

				fire.x = target_mc.x;
				fire.y = target_mc.y;

				fire.gotoAndStop(randRange(1,3));
				var newSize:Number = randRange(minSize,maxSize);
				fire.width = newSize;
				fire.height = newSize;

				fire.alpha = randRange(50,100);
			}
		}
		function explosion2(temp:MovieClip)
		{
			for (var e:Number = 0; e < totalFragments; e++)
			{
				var sparkL:Spark = new Spark(this);
				this.addChild(sparkL);

				sparkL.x = electTarget.x;
				sparkL.y = electTarget.y;

				sparkL.gotoAndStop(randRange(1, 3));
				var newSize2:Number = randRange(minSize,maxSize);
				sparkL.width = newSize2;
				sparkL.height = newSize2;

				sparkL.alpha = randRange(50,100);

			}
		}
		public function Destroy(tempp:MovieClip):void
		{
			this.removeChild(tempp);
			tempp = null;
		}
		public function DestroyExplo(temppp:MovieClip):void
		{
			this.removeChild(temppp);
			temppp = null;
		}

		public function turretsRotation():void
		{

			for (var i:uint = 0; i < turretsArray.length; i +=  1)
			{
				rotationDirection = Math.round((270 - Math.atan2(stage.mouseX - turretsArray[i].x,stage.mouseY - turretsArray[i].y) * 180 / Math.PI));

				turretsArray[i].rotation = rotationDirection;
			}
		}

		public function mouseClick(event:MouseEvent):void
		{

			explosion2(tempp2);

		}
		public function mOver(event:MouseEvent):void
		{
			//if(event.target == mouseTarg)
//			{
//				trace("yeee")
//			}
		}
		public function mOut(event:MouseEvent):void
		{

		}
		public function mDown(event:MouseEvent):void
		{

		}

		public function mUp(event:MouseEvent):void
		{
			//if (event.target == thing1)
			//{
			//}

		}
		function onMyPress(event:KeyboardEvent):void
		{
			if (event.keyCode == 32)
			{
				shootType = ! shootType;
			}

		}


	}

}