﻿package 
		public var spLineArray:Array = new Array();
		
		public var spLines:MovieClip = new sparkLine();
		public var glowAlpha:Number = 0.6;
		public var glowBlurX:Number = 5;
		public var glowBlurY:Number = 5;
		public var glowStrength:Number = 2;
		public var glowQuality:Number = 3;
		
		public var filterGlow:GlowFilter = new GlowFilter(glowColor,glowAlpha,glowBlurX,glowBlurY,glowStrength,glowQuality);
			
			createSparkLine(0,738,500,738);
			
				spLines.visible = false;
						spLines.visible = false;
						
								
			trace(spLineArray.length+"   "+sparkStatee+"   "+menuBoxes)
			
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

		}