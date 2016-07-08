﻿package 
{
	import flash.events.*;
	import flash.display.*;


	public class Fire extends MovieClip
	{

		public var rotationRads:Number;
		public var refM:MovieClip;

		public function Fire(temp:MovieClip)
		{
			refM = temp;

			this.addEventListener(Event.ENTER_FRAME,gameLoop);

			this.rotation +=  Math.random() * 360;

			if (Math.random() * 2 > 1)
			{
				this.rotation *=  -1;
			}
			
			rotationRads = this.rotation * Math.PI / 180;
		}

		function gameLoop(myEvent:Event):void
		{
			var boundyLeft:Number = refM.tempp.x - refM.fragmentRange;
			var boundyTop:Number = refM.tempp.y - refM.fragmentRange;
			var boundyRight:Number = refM.tempp.x + refM.fragmentRange;
			var boundyBottom:Number = refM.tempp.y + refM.fragmentRange;

			this.x +=  Math.cos(rotationRads) * refM.maxSpeed;
			this.y +=  Math.sin(rotationRads) * refM.maxSpeed;
			
			this.alpha -=  1;

			if (this.x < boundyLeft || this.x > boundyRight || this.y < boundyTop || this.y > boundyBottom)
			{
				this.removeEventListener(Event.ENTER_FRAME, gameLoop);
				refM.DestroyExplo(this);
				
			}

		}



	}

}