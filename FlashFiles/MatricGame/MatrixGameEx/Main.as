package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;	import flash.geom.*;	import flash.text.*;	import flash.globalization.*;	import com.greensock.*;	import com.greensock.easing.*;	public class Main extends MovieClip	{		public var pausee:Boolean = false;		public var sentColourState:Boolean = false;		public var bullettsState:Boolean = false;		public var menuBoxes:String = "paused";		public var sentArray:Array = new Array  ;		public var bulletsArray:Array = new Array  ;		public var sparkArray:Array = new Array  ;		public var turretsArray:Array = new Array  ;		public var baseArray:Array = new Array  ;		public var frontBoxArray:Array = new Array  ;		public var ammoArray:Array = new Array  ;		public var turretOneArray:Array = new Array  ;		public var turretTwoArray:Array = new Array  ;		public var turretThreeArray:Array = new Array  ;		public var turretFourArray:Array = new Array  ;
		public var spLineArray:Array = new Array();
				public var hitGlow:GlowFilter = new GlowFilter(glowColor2,1,glowBlurX,glowBlurY,glowStrength,glowQuality);	
		public var spLines:MovieClip = new sparkLine();		public var tempp:MovieClip;		public var tempp2:MovieClip;		public var sentSpeed:Number = .1;		public var sent2Speed:Number = 1.5;		public var sent2HealthCount:Number = 10;		public var maxSpeed:Number = 5;		public var minSize:Number = 2;		public var maxSize:Number = 10;		public var minFragments:Number = 15;		public var maxFragments:Number = 30;		public var fragmentRange:Number = 80;		public var totalFragments:Number = randRange(minFragments,maxFragments);		public var lightningOffset:Number = 15;		public var lightningFrequency:Number = 15;		public var lightningWidth:Number = 4;		public var lightningColor = "0x5C98EF";		public var lightningColor2 = "0xFFD801";		public var lightningColor3 = "0xffff00";		public var lightningAlpha:Number = .8;		public var lightningAlpha2:Number = .01;		public var lightningBranches:Number = 3;		public var sparkNumber:Number = 5;		public var sparkDistance:Number = 10;		public var sparkSize:Number = 100;		public var glowColor:Number = lightningColor;		public var glowColor2:Number = lightningColor2;
		public var glowAlpha:Number = 0.6;
		public var glowBlurX:Number = 5;
		public var glowBlurY:Number = 5;
		public var glowStrength:Number = 2;
		public var glowQuality:Number = 3;
		
		public var filterGlow:GlowFilter = new GlowFilter(glowColor,glowAlpha,glowBlurX,glowBlurY,glowStrength,glowQuality);		public var rotationRadss:Number;		public var rotationDirection:Number;		public var rotationDirection2:Number;		public var rotationDirection3:Number;		public var trueRotation:Number;		public var rotationSpeedMax:Number = 20;		public var xPos:Number;		public var yPos:Number;		public var speedX:Number;		public var speedY:Number;		public var angleRads:Number = 0;		public var angleDegrees:Number = 0;		public var t1healthNum:Number = 100;		public var t2healthNum:Number = 100;		public var t3healthNum:Number = 100;		public var t4healthNum:Number = 100;		public var gameCount:Number = 0;		public var gameTimerM:Number = 0;		public var gameTimerS:Number = 0;		public var myColorTransform = new ColorTransform  ;		public var myColorTransform2 = new ColorTransform  ;		public var myColorTransform3 = new ColorTransform  ;		public var myColorTransform4 = new ColorTransform  ;		public var myColorTransform5 = new ColorTransform  ;		public var myColor1:uint = 0x333333;		public var myColor2:uint = Math.random() * 0xFFFFFF;		public var turretState:Boolean = false;		public var myFormat:TextFormat = new TextFormat  ;		public var myFormat2:TextFormat = new TextFormat  ;		public var baseLine:MovieClip = new myLine2  ;		public var spark11:Spark1 = new Spark1  ;		public var spark22:Spark2 = new Spark2  ;		public var spark33:Spark3 = new Spark3  ;		public var sparkX:Number = 0;		public var sparkY:Number = 0;		public var sparkCount:Number = 0;		public var sparkStages:String = "spawn";		public var shootingState:String = "Fire";		public var sparkStatee:Boolean = true;		public var sparkNum:Number = 0;		public var pointsNum:Number = 0;		public var bonusNum:Number = 0;		public var killsNum:Number = 0;		public var GameState:Boolean = false;		public var obState:Boolean = false;		public var obCount:Number = 0;		public var tOneColourState:Boolean = false;		public var tThreeColourState:Boolean = false;		public var tFourColourState:Boolean = false;		public var bColourState:Boolean = false;		public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gL);			stage.addEventListener(MouseEvent.CLICK,mouseClick);			stage.addEventListener(KeyboardEvent.KEY_DOWN, kDown);			startBox.sBut.inLayer.buttonMode = true;			tempp = target_mc;			tempp2 = electTarget;			turretOneArray.push(baseArray[1]);			turretThreeArray.push(baseArray[2]);			turretFourArray.push(baseArray[0]);
			
			createSparkLine(0,738,500,738);		}		public function gL(myEvent:Event):void		{
						if (bColourState == false)			{				myColor1 = Math.random() * 0xFFFFFF;				myColor2 = Math.random() * 0xFFFFFF;				myColorTransform.color = myColor2;				bckBox.transform.colorTransform = myColorTransform;				startBox.bStartBox.transform.colorTransform = myColorTransform;				bColourState = true;			}			if (obState == false)			{				obText.visible = false;				myColorTransform5.color = Math.random() * 0xffffff;				obText.transform.colorTransform = myColorTransform5;			}			if (obState == true)			{				obText.visible = true;				obCount +=  1;				obText.alpha -=  .005;				if (obCount > 100)				{					obState = false;				}			}			if (menuBoxes == "start")			{				startBox.visible = false;				pausee = false;				obState = true;				menuBoxes = "null";			}			if (menuBoxes == "paused")			{
				spLines.visible = false;				if (startBox.sBut.inLayer.alpha >= .5)				{					TweenNano.to(startBox.sBut.inLayer,1,{alpha:0});				}				if (startBox.sBut.inLayer.alpha == 0)				{					TweenNano.to(startBox.sBut.inLayer,1,{alpha:.6});					myColorTransform4.color = Math.random() * 0xffffff;					startBox.sBut.inLayer.transform.colorTransform = myColorTransform4;				}				pausee = true;			}			if (pausee == false)			{				if (GameState == false)				{					baseHealth();					bckBox.alpha = .5;					gFrontBox.visible = false;					myColorTransform.color = myColor2;					gFrontBox.gBox.transform.colorTransform = myColorTransform;					myFormat.color = myColor1;					myFormat.size = 15;					var scoreNum:Number = pointsNum + bonusNum;					scoreText.text = "Score: " + scoreNum.toString();					gFrontBox.endScore.text = "Score: " + scoreNum.toString();					killsText.text = "Kills: " + killsNum.toString();					gFrontBox.endKills.text = "Kills: " + killsNum.toString();					scoreText.setTextFormat(myFormat2);					killsText.setTextFormat(myFormat2);					myFormat2.color = myColor1;					myFormat2.size = 15;					if (gameTimerM >=1)					{						mText.visible = true;					}					else					{						mText.visible = false;					}					gameCount +=  1;					if (gameCount >= 23)					{						gameTimerS +=  1;						gameCount = 0;					}					if (gameTimerS < 10)					{						sText.text = "0";					}					else					{						sText.text = "";					}					sText.appendText(String(gameTimerS));					sText.setTextFormat(myFormat);					if (gameTimerS >= 60)					{						gameTimerM +=  1;						gameTimerS = 0;					}					if (gameTimerM < 10)					{						mText.text = "0";					}					else					{						mText.text = "";					}					mText.appendText(String(gameTimerM));					mText.setTextFormat(myFormat);					electTarget.alpha = .1;					addChild(baseLine);					addSparkles(electTarget.x,electTarget.y,sparkNumber,sparkDistance,sparkSize);					baseWeaponLine(0,740,500,740);					if (sparkStatee == true)					{						sparkStages = "spawn";						
						spLines.visible = false;
												if (sparkStages == "spawn")						{							sparkNum = Math.round(Math.random() * 500);							if (sparkNum == 225 || sparkNum == 125 || sparkNum == 405)							{								sparkX = Math.random() * 500;								sparkY = Math.random() * 400;								electTarget.x = sparkX;								electTarget.y = sparkY;								sparkStatee = false;							}							else							{								sparkStages = "far";							}						}					}					if (sparkStatee == false)					{						if (electTarget.hitTestObject(mouseTarg))						{							sparkStages = "attach";						}						else						{							sparkStages = "move";						}						if (sparkStages == "move")						{							sparkX = 0;							sparkY = 2;							electTarget.y +=  sparkY;							shootingState = "Fire";						}						if (sparkStages == "attach")						{							spLines.visible = true;							spLines.width -=  2;							electTarget.x = stage.mouseX;							electTarget.y = stage.mouseY;							sparkCount +=  1;							if (sparkCount > 250)							{								sparkStatee = true;								sparkCount = 0;
																spLines.visible = false;								spLines.width = 500;							}						}					}					if (sparkStages == "far")					{						sparkX = 50000;						sparkY = 50000;						electTarget.x = sparkX;						electTarget.y = sparkY;					}					if (electTarget.y >= 735)					{						sparkStatee = true;					}					if (stage.mouseY < 740)					{						turretsRotation();						shootingState = "Fire";					}					else					{						shootingState = "OffDatge";						if (sparkStages == "attach")						{							sparkStatee = true;						}					}					if ((shootingState == "OffDatge"))					{						mouseTarg.x = 50000;						mouseTarg.y = 50000;					}					if ((shootingState == "Fire"))					{						mouseTarg.x = stage.mouseX;						mouseTarg.y = stage.mouseY;						if (sparkStages == "attach")						{							mouseTarg.visible = false;						}						else						{							mouseTarg.visible = true;						}					}					if (tOneColourState == true)					{						for (var i:uint = 0; i < turretOneArray.length; i += 1)						{							if (turretOneArray[i].alpha >= .5)							{								TweenNano.to(turretOneArray[i],.8,{alpha:0});							}							if (turretOneArray[i].alpha == 0)							{								TweenNano.to(turretOneArray[i],.8,{alpha:.6});							}						}					}					if (tThreeColourState == true)					{						for (var u:uint = 0; u < turretThreeArray.length; u += 1)						{							if (turretThreeArray[u].alpha >= .5)							{								TweenNano.to(turretThreeArray[u],.8,{alpha:0});							}							if (turretThreeArray[u].alpha == 0)							{								TweenNano.to(turretThreeArray[u],.8,{alpha:.6});							}						}					}					if (tFourColourState == true)					{						for (var w:uint = 0; w < turretFourArray.length; w += 1)						{							if (turretFourArray[w].alpha >= .5)							{								TweenNano.to(turretFourArray[w],.8,{alpha:0});							}							if (turretFourArray[w].alpha == 0)							{								TweenNano.to(turretFourArray[w],.8,{alpha:.6});							}						}					}				}			}			if (GameState == true)			{				gFrontBox.visible = true;				mouseTarg.visible = false;				baseLine.graphics.clear();				addSparkles(50000,50000,sparkNumber,sparkDistance,sparkSize);			}
			trace(spLineArray.length+"   "+sparkStatee+"   "+menuBoxes)
					}		public function baseHealth()		{			if (basse.width <= 1)			{				GameState = true;			}			if (basse.width >= 500)			{				basse.width = 500;			}		}		public function baseWeaponLine(xStart2:Number,yStart2:Number,xEnd2:Number,yEnd2:Number)		{			baseLine.graphics.lineStyle(2,lightningColor2,lightningAlpha2,true);			baseLine.graphics.moveTo(xStart2,yStart2);			baseLine.graphics.lineTo(xEnd2,yEnd2);		}		public function createSparkLine(xStart:Number,yStart:Number,xEnd:Number,yEnd:Number)
		{
			//var spColor:uint = Math.random() * 0xFFFFFF;
			var spBranches:Number = 3;//or1
			var	spWidth:Number = 1;//or2
			var	spFrequency:Number = 1;//or10
			var	spOffset:Number = 5;//or1
			var	spAlpha:Number = 75;//or75
			
			
			spLines.filters = [filterGlow];
			spLines.graphics.clear();
			spLines.graphics.lineStyle(spWidth,lightningColor,spAlpha,true);
			
			var distanceX:Number = xStart - xEnd;
			var distanceY:Number = yStart - yEnd;
			var distanceTotal:Number = Math.sqrt(((distanceX * distanceX) + distanceY * distanceY));
			var numberOfSteps:Number = distanceTotal / spFrequency;
			var angle:Number = Math.atan2((yStart - yEnd),xStart - xEnd);
			var stepInPixels:Number = distanceTotal / numberOfSteps;
			
			for (var j:uint = 0; j < spBranches; j += 1)
			{
				spLines.graphics.moveTo(xStart,yStart);
				
				for (var i:uint = 0; i < numberOfSteps; i ++)
				{
					var currentStepPosition:Number = stepInPixels * i;
					var randomOffset:Number = Math.random() * (spOffset - spOffset / 2);
					var xStepPosition:Number = xStart - Math.cos(angle) * currentStepPosition + Math.cos((angle + 1.55)) * randomOffset;
					var yStepPosition:Number = yStart - Math.sin(angle) * currentStepPosition + Math.sin((angle + 1.55)) * randomOffset;
					spLines.graphics.lineTo(xStepPosition,yStepPosition);
				}

				spLines.graphics.lineTo(xEnd,yEnd);
			
			}
			
			stage.addChild(spLines);
			spLineArray.push(spLines);
		
			spLines.mySparkline();
			
			if(spLineArray.length>0)
			{
				spLineArray.pop();
			}
		}
		
		function electricWeapon(xStart:Number,yStart:Number,xEnd:Number,yEnd:Number)
		{
			/*Lazer.filters = [filter_glow];
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
			addChild(Lazer);*/

		}		public function randRange(min:Number,max:Number):Number		{			var randomNum:Number = Math.floor(Math.random() * ((max - min) + 1)) + min;			return randomNum;		}		public function explosion(temp:MovieClip)		{			for (var i:Number = 0; i < totalFragments; i++)			{				var fire:Fire = new Fire(this);				this.addChild(fire);				fire.x = target_mc.x;				fire.y = target_mc.y;				fire.gotoAndStop(randRange(1,3));				var newSize:Number = randRange(minSize,maxSize);				fire.width = newSize;				fire.height = newSize;				fire.alpha = randRange(50,100);			}		}		function explosion2(temp:MovieClip)		{			for (var e:Number = 0; e < totalFragments; e++)			{				var sparkL:Spark = new Spark(this);				this.addChild(sparkL);				sparkL.x = electTarget.x;				sparkL.y = electTarget.y;				sparkL.gotoAndStop(randRange(1, 3));				var newSize2:Number = randRange(minSize,maxSize);				sparkL.width = newSize2;				sparkL.height = newSize2;				sparkL.alpha = randRange(50,100);			}		}		function addSparkles(_targetX:Number,_targetY:Number,_sparkNumber:Number,_distance:Number,_sparkSize:Number)		{			if (sparkStages == "spawn" || sparkStages == "attach" || sparkStages == "move")			{				addChild(spark11);				addChild(spark22);				addChild(spark33);				sparkArray.push(spark11);				sparkArray.push(spark22);				sparkArray.push(spark33);			}			if (sparkStages == "far")			{				for (var d:uint = 0; d < sparkArray.length; d++)				{					sparkArray.splice(d, 1);				}			}			for (var i = 0; i < _sparkNumber; i++)			{				spark11.x = (_targetX + Math.random() * (_distance - _distance / 2)) - 5;				spark11.y = (_targetY + Math.random() * (_distance - _distance / 2)) - 5;				spark22.x = (_targetX + Math.random() * (_distance - _distance / 2)) - 5;				spark22.y = (_targetY + Math.random() * (_distance - _distance / 2)) - 5;				spark33.x = (_targetX + Math.random() * (_distance - _distance / 2)) - 5;				spark33.y = (_targetY + Math.random() * (_distance - _distance / 2)) - 5;				var tempRandomSize = Math.random() * _sparkSize / 20;				spark11.scaleX = tempRandomSize;				spark11.scaleY = tempRandomSize;				var tempRandomSize2 = Math.random() * _sparkSize / 20;				spark22.scaleX = tempRandomSize2;				spark22.scaleY = tempRandomSize2;				var tempRandomSize3 = Math.random() * _sparkSize / 20;				spark33.scaleX = tempRandomSize3;				spark33.scaleY = tempRandomSize3;				spark11.rotation = Math.random() * 359;				spark22.rotation = Math.random() * 359;				spark33.rotation = Math.random() * 359;				spark11.alpha = lightningAlpha;				spark22.alpha = lightningAlpha;				spark33.alpha = lightningAlpha;			}		}		public function Destroy(tempp:MovieClip):void		{			this.removeChild(tempp);			tempp = null;		}		public function DestroyExplo(temppp:MovieClip):void		{			this.removeChild(temppp);			temppp = null;		}		public function turretsRotation():void		{			for (var i:uint = 0; i < turretsArray.length; i +=  1)			{				rotationDirection = Math.round((270 - Math.atan2(stage.mouseX - turretsArray[i].x,stage.mouseY - turretsArray[i].y) * 180 / Math.PI));				turretsArray[i].rotation = rotationDirection;			}		}		public function mouseClick(event:MouseEvent):void		{			if (event.target == startBox.sBut.inLayer)			{				menuBoxes = "start";			}		}		function kDown(event:KeyboardEvent):void		{			if (event.keyCode == 80)			{				pausee = ! pausee;			}			if (event.keyCode == 32)			{				bColourState = false;			}		}	}}