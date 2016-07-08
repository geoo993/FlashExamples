package {	import flash.display.*;	import flash.events.*;	import flash.geom.*;	import flash.filters.*;	public class Main extends MovieClip	{		
		public var player:MovieClip = new myPlayer()  ;		
		public var xPoss:Number = 0;
		public var yPoss:Number = 0;
		public var speeed:Number = 5;
		public var up:Boolean = false;
		public var down:Boolean = false;
		public var left:Boolean = false;
		public var right:Boolean = false;		public var rotationDirection:Number = 0;
		
		public var startPointX:Number = 0;
		public var startPointY:Number = 0;
		public var endPointX:Number = 0;
		public var endPointY:Number = 0;
		public var lightingType:Number = 0;
		
		public var lightningBranches:Number = 0;
		public var lightningWidth:Number = 0;
		public var lightningFrequency:Number = 0;
		public var lightningOffset:Number = 0;
		public var lightningAlpha:Number = 0;
				
		public var lightningColor = "0x5C98EF";

		public var glowColor:Number = lightningColor;
		public var glowAlpha:Number = 0.6;
		public var glowBlurX:Number = 5;
		public var glowBlurY:Number = 5;
		public var glowStrength:Number = 2;
		public var glowQuality:Number = 3;
		
		public var filter_glow:GlowFilter = new GlowFilter(glowColor,glowAlpha,glowBlurX,glowBlurY,glowStrength,glowQuality);
		public var Lazer:MovieClip = new myLine()  ;
			public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,kUp);
			
			lightingType = randomRange(0,5);
			xPoss = stage.stageWidth/2;
			yPoss = stage.stageHeight/2;
			player.x = xPoss;
			player.y = yPoss;
					}		public function gL(myEvent:Event):void		{       
			
			startPointX = player.x;
			startPointY = player.y;
			endPointX = stage.mouseX;
			endPointY = stage.mouseY;
			electricWeapon(startPointX,startPointY,endPointX,endPointY);
			
			if(lightingType == 0)
			{	
				//lazer
				lightningBranches = 1;
				lightningWidth = 2;
				lightningFrequency = 10;
				lightningOffset = 1;
				lightningAlpha = 75;
			}
			if(lightingType == 1)
			{	
				//pulse1
				lightningBranches = 3;
				lightningWidth = 2;
				lightningFrequency = 2;
				lightningOffset = 10;
				lightningAlpha = 75;
			}
			if(lightingType == 2)
			{	
				//pulse2
				lightningBranches = 3;
				lightningWidth = 1;
				lightningFrequency = 1;
				lightningOffset = 5;
				lightningAlpha = 75;
			}
			if(lightingType == 3)
			{	
				//lighting1
				lightningBranches = 3;
				lightningWidth = 1;
				lightningFrequency = 12;
				lightningOffset = 12;
				lightningAlpha = 75;
			}
			if(lightingType == 4)
			{	
				//lighting2
				lightningBranches = 1;
				lightningWidth = 1;
				lightningFrequency = 15;
				lightningOffset = 15;
				lightningAlpha = 75;
			}
			if(lightingType == 5)
			{	
				//lighting3
				lightningBranches = 10;
				lightningWidth = 2;
				lightningFrequency = 25;
				lightningOffset = 25;
				lightningAlpha = 50;
			}
			
			addChild(player)
			rotationDirection = Math.round(180 - ((Math.atan2(stage.mouseX - player.x, stage.mouseY - player.y)) * 180/Math.PI))
			player.rotation = rotationDirection;	
			
			if(up == true)
			{
				player.y -= speeed;
			}
			if(down == true)
			{
				player.y += speeed;
			}
			if(left == true)
			{
				player.x -= speeed;
			}
			if(right == true)
			{
				player.x += speeed;
			}					}
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
			addChild(Lazer);

		}
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
		
		function kDown(event:KeyboardEvent):void
		{  
			if (event.keyCode == 32)
			{
				lightingType = randomRange(0,5);
				lightningColor = Math.random() * 0xffffff;
			}
			
			if (event.keyCode == 38)
			{
				up = true;
			}
			if (event.keyCode == 40)
			{
				down = true;
			}
			
			if (event.keyCode == 37)
			{
				left = true
			}
			if (event.keyCode == 39)
			{
				right = true;
			}
		}
		function kUp(event:KeyboardEvent):void
		{
			if (event.keyCode == 38)
			{
				up = false;
			}
			if (event.keyCode == 40)
			{
				down = false;
			}
			if (event.keyCode == 37)
			{
				left = false;
			}
			if (event.keyCode == 39)
			{
				right = false;
			}
		}			}}
