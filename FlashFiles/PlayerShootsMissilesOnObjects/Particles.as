package 
{
	import flash.events.*;
	import flash.display.*;
	import flash.geom.*;

	public class Particles extends MovieClip
	{
		
		public var partiColor:uint = Math.random() * 0xFFFFFF;
		public var partiColorTransform = new ColorTransform()  ;
		
		public var partiRotation:Number;
		public var particleSpeed:Number = 5;
		public var refM:MovieClip;
		
		public function Particles(temp:MovieClip)
		{
			refM = temp;
			this.addEventListener(Event.ENTER_FRAME,gameL);

			this.rotation +=  Math.random() * 180;

			if (Math.random() * 2 > 1)
			{
				this.rotation *=  -1;
			}
			partiRotation = this.rotation * Math.PI / 180; 
			
			partiColor = Math.random() * 0xFFFFFF;
			partiColorTransform.color = partiColor;
			this.transform.colorTransform = partiColorTransform;
		}

		function gameL(myEvent:Event):void
		{
			
			this.x +=  Math.cos(partiRotation) * Math.random() * particleSpeed;
			this.y +=  Math.sin(partiRotation) * Math.random() * particleSpeed;
	
			this.alpha -=  0.05;
			if (this.alpha < 0)
			{
				refM.destroyParticles(this);
				this.removeEventListener(Event.ENTER_FRAME, gameL);
			}
		}



	}

}