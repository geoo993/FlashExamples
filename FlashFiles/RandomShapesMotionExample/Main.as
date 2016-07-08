package 
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import fl.motion.Color;
	import Circle;
	
	public class Main extends MovieClip
	{

		public var minSize:Number = 5;
		public var maxSize:Number = 20;
		public var radius:Number = 0;
		public var transparency:Number = Math.random() * 2;
		public var thickness:Number = Math.random() * 4;
		
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		
		public var cColor:uint = Math.random() * 0xFFFFFF;
		public var cOutColor:uint = Math.random() * 0xFFFFFF;
		public var color1:uint;
		public var color2:uint;
		
		public var circlesArray:Array = new Array()  ; 
		public var particleVect:Vector.<Circle> = new Vector.<Circle>;
		
		public var numberOfParticles:uint = 300;
		public var toggleAnimation:Boolean = false;
		
		public var shapeCreator:String = "idle";
		
		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			
		}
		
		//part1...............................
		function addParticles():void
		{
			for (var i:uint = 0; i < numberOfParticles; i++) 
			{
				particleVect.push(new Circle());
				
				particleVect[i].x = Math.random() * stage.stageWidth;
				particleVect[i].y = Math.random() * stage.stageHeight;
			
				particleVect[i].alpha = Math.random();
			
				var sizeScale:Number = Math.random(); 
				particleVect[i].scaleX = sizeScale;
				particleVect[i].scaleY = sizeScale;	
				
				addChild(particleVect[i]);
			} 
		
		} 
		function removeParticles():void
		{
			for (var e:uint = 0; e < numberOfParticles; e++) 
			{
				particleVect[e].ParticleDestructor();
				removeChild(particleVect[e]);		
			}
			while(particleVect.length > 0) 
			{
				particleVect.pop();
			}

		}
		//part2..............................
		function createCircles()
		{
			for (var i:uint = 0; i < numberOfParticles; i++) 
			{
				thickness =  Math.random() * 3;
				//cColor = Math.random() * 0xFFFFFF;
				cOutColor = Math.random() * 0xFFFFFF;
				transparency = Math.random() * 2;
				
				var glowAlpha:Number = Math.random() * 2;
				var glowBlurX:Number = 5;
				var glowBlurY:Number = 5;
				var glowStrength:Number = 2;
				var glowQuality:Number = 3;
				var glowColor:uint = Math.random() * 0xFFFFFF;
				var filterGlow:GlowFilter = new GlowFilter(glowColor,glowAlpha,glowBlurX,glowBlurY,glowStrength,glowQuality);
				
				var myShape:MovieClip = new Circle2() ;
				myShape.filters = [filterGlow];
				myShape.graphics.clear();
				//myShape.graphics.lineStyle(thickness,cOutColor,1,true);
				myShape.graphics.beginFill(cColor,transparency);
				myShape.graphics.drawCircle(0,0,randomRange(5,20));
				myShape.graphics.endFill();
				stage.addChild(myShape);
				circlesArray.push(myShape);
				
				myShape.x = Math.random() * stage.stageWidth;
				myShape.y = Math.random() * stage.stageHeight;
				myShape.alpha = Math.random()* 2;
			}
			if(circlesArray.length > numberOfParticles)
			{   
				removeCircles() 
			}
			
		}
		function removeCircles() 
		{
			for (var p:uint = 0; p < circlesArray.length; p++)
			{
				circlesArray[p].CircleDestructor();
				destroyer(circlesArray[p]);
			}
		}
		public function backgroundColorTransition()
		{
			if(colorTransSwitch == "goingUp")
			{
				colorTransNum += 1;
			}
			if(colorTransSwitch == "goingDown")
			{
				colorTransNum -= 1;
			}
			
			if(curVal <= 0)
			{
				colorTransSwitch = "goingUp";
				color2 = Math.random() * 0xFFFFFF;
			}
			if(curVal >= 1)
			{
				color1 = Math.random() * 0xFFFFFF;
				colorTransSwitch = "goingDown"
				
			}
			
			curVal = colorTransNum/255;
			stage.color = Color.interpolateColor(color1,color2,curVal);
			
			//trace(curVal+"  "+colorTransNum+"  "+colorTransSwitch)
		}
		public function gL(myEvent:Event):void
		{
			
			backgroundColorTransition();
			
			if(shapeCreator == "create")
			{
				createCircles() 
				shapeCreator = "idle";
			}
			if(shapeCreator == "remove")
			{
				removeCircles() 
			}
			
		}
	
		public function destroyer(myMc:MovieClip):void
		{
			var thisMc:MovieClip;

			for (var i:uint = 0; i < circlesArray.length; i++)
			{
				thisMc= circlesArray[i];

				if (thisMc == myMc)
				{
					circlesArray.splice(i,1);	
					myMc.parent.removeChild(myMc) 
				}
			}
		}

		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}

		function kDown(event:KeyboardEvent):void
		{  
			if (event.keyCode == 32)
			{
			
				if (toggleAnimation == false) 
				{
					//addParticles();
					shapeCreator = "create";
					cColor = Math.random() * 0xFFFFFF;
					toggleAnimation = true;
				}
				else 
				{
					//removeParticles();
					shapeCreator = "remove";
					toggleAnimation = false;
				}
				
			}
		}


	}

}