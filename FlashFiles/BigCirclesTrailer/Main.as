package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import fl.motion.Color;


	public class Main extends MovieClip
	{
		public var colorTransSwitch:String = "idle";
		public var colorTransNum:Number = 0;
		public var curVal:Number= 0;
		public var color1 = Math.random() * 0xFFFFFF;
		public var color2 = Math.random() * 0xFFFFFF;
		
		public var xPosition:Number= 0;
		public var yPosition:Number= 0;
		public var scaleFactor:Number=0;
		
		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			
		}
		public function gL(myEvent:Event):void
		{   
			startListening();
			backgroundColorTransition();
		
		}
		function duplicateCircle(e:MouseEvent) 
		{
	
			var circle:ColorfulCircle = new ColorfulCircle();
			
			xPosition = stage.mouseX;
			yPosition = stage.mouseY;
			
			circle.x= xPosition;
			circle.y= yPosition;
		
			circle.scaleX= scaleFactor;
			circle.scaleY= scaleFactor;
		
			this.addChild(circle);
		}
		function startListening() {
	
			stage.addEventListener(MouseEvent.MOUSE_MOVE, duplicateCircle);
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
			
		}

	}

}