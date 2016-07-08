package 
{
	import flash.events.*;
	import flash.display.*;
	import flash.geom.*;

	public class MyShape extends MovieClip
	{

		public var rotationRads:Number;
		public var refM:MovieClip;
		
		public function MyShape(temp:MovieClip)
		{
			refM = temp;
			this.addEventListener(Event.ENTER_FRAME,gameLoop);

			this.rotation +=  Math.random() * 180;

			if (Math.random() * 2 > 1)
			{
				this.rotation *=  -1;
			}
			rotationRads = this.rotation * Math.PI / 180; 
			
		}

		function gameLoop(myEvent:Event):void
		{
			this.x +=  Math.cos(rotationRads)/1.5 * Math.random() * 1;
			this.y -= refM.maxSpeed/2;
		}



	}

}