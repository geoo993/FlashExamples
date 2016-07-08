package  {
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	public class BackGround extends MovieClip {
		
		public var refM:MovieClip;
	
		public var backTransitionCount:Number = 0;
		public var backGroundTimer:Number = 0;
		
		public function BackGround() 
		{
			this.addEventListener(Event.ENTER_FRAME,gameL);
			refM = MovieClip (this.parent);
			
		}
		public function gameL(myEvent:Event):void
		{
		
			if(refM.backColorState == false)
			{
				backTransitionCount++
				if (this.alpha >= .9)
				{
					TweenNano.to(this,2.5,{alpha:0});
				}
				if (this.alpha == 0)
				{
					TweenNano.to(this,2.5,{alpha:1});
					refM.backgrounColor = Math.random() * 0xFFFFFF;
					refM.backgroundColorTransform.color = refM.backgrounColor
					this.transform.colorTransform = refM.backgroundColorTransform;
				}
				
				if(backTransitionCount > 80)
				{
					refM.backColorState = true;
				}
			}
			if(refM.backColorState == true)
			{
				backTransitionCount = 0;
			}
			
			
			/*backGroundTimer++
			
			if(backGroundTimer >500)
			{
				refM.backColorState = false;
				backGroundTimer = 0;
			}*/
			
		}
	}
	
}
