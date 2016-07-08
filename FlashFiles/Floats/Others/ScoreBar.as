package  {
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	public class ScoreBar extends MovieClip {
		
		public var refM:MovieClip;
		
		public var myBlur:Number = 20;
		public var myAlpha:Number = 1;
		public var myStrength:Number = 5;
		public var myQuality:Number = 3;
		
		public var onOffGlow:Boolean = false;
		public var now:int = 0;
		public var then:int = 0;
		
		
		public function ScoreBar() 
		{
			this.addEventListener(Event.ENTER_FRAME,gameL);
			refM = MovieClip (this.parent);
		}

		public function gameL(myEvent:Event):void
		{
			//trace(this.width)
			
			/*if(this.width > 1200)
			{
				refM.backColorState = false;
			}*/
			
			refM.scoreBarColor = refM.playerColor;
			refM.scoreBarColorTransform.color = refM.scoreBarColor;
			this.transform.colorTransform = refM.scoreBarColorTransform;
			
			now = this.width;
		
			if(now > then)
			{
				onOffGlow = true
			}
			else if(now < then)
			{
				onOffGlow = true
			}
			else
			{
				onOffGlow = false
			}
			then = now;
			
			if(onOffGlow == false)
			{
				myAlpha = 0.5;
				myBlur = 5;
				myStrength = 1
				myQuality = 1
				makeObjectGlow(this,refM.scoreBarColor,myAlpha,myBlur,myStrength,myQuality)	
			}
			if(onOffGlow == true)
			{
				//myColor = Math.random() * 0xFFFFFF;
				myAlpha = 1;
				myBlur = 8;
				myStrength = 2;
				myQuality = 2;
				makeObjectGlow(this,refM.scoreBarColor,myAlpha,myBlur,myStrength,myQuality)	
			}
			
		}

		public function makeObjectGlow(mc:MovieClip, colour:Number,alphaa:Number,blurXY:Number,strengt:Number,quali:Number):void 
		{
			TweenMax.to(mc, 1, {glowFilter: {color: colour, alpha: alphaa, blurX: blurXY, blurY: blurXY, strength: strengt,quality:quali}});	
		}
	}
	
}
