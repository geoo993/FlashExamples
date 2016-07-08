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
		
		public var color1 = 0x000000;
		public var color2 = 0x0000FF;
		public var myBackColorTransform = new ColorTransform()  ;
		
		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
		}
		
		public function backgroundColorTransition()
		{
			
			if(colorTransSwitch == "goingUp")
			{
				colorTransNum += 2;
			}
			if(colorTransSwitch == "goingDown")
			{
				colorTransNum -= 2;
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
			var betweenColor = Color.interpolateColor(color1,color2,curVal);
			
			stage.color = betweenColor;
			
		}
		public function gL(myEvent:Event):void
		{
			trace(curVal+"  "+colorTransNum+"  "+colorTransSwitch+"  "+color1.toString(16)+"   "+color2.toString(16))
			
			backgroundColorTransition()
		}
	
	}

}