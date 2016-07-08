package  {
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	
	public class Platform extends MovieClip {
		
		public var refM:MovieClip;
		
		public var xSpeed:Number = 0;
		public var ySpeed:Number = 0;
		
		public function Platform() 
		{
		
			this.addEventListener(Event.ENTER_FRAME,gameL);
			refM = MovieClip(this.parent);
			//refM.platformArray.push(this);
			
			this.xSpeed = randomRange(-1,1);
			this.ySpeed = 1;
		}
		public function PlatformDestructor()
		{
			this.removeEventListener(Event.ENTER_FRAME, gameL);
		} 
		public function gameL(myEvent:Event):void
		{
			
			if(this.x > stage.stageWidth-(this.width))
			{
				this.xSpeed *= -1;
			}
			if(this.x < 0)
			{
				this.xSpeed *= -1;
			}
			
			this.x += xSpeed;
			this.y += ySpeed;
			
		}
		public function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.random() * ((maxNum - minNum) + 1) + minNum;
		}
		
	}
	
}
