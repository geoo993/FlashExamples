package 
{
	import flash.events.*;
	import flash.display.*;
	import flash.geom.*;

	public class MyShape2 extends MovieClip
	{

		public var shapesRotation:Number;
		public var myColorTransform = new ColorTransform  ;
		
		
		public var refM:MovieClip;
		
		public function MyShape2(temp:MovieClip)
		{
			refM = temp;
			this.addEventListener(Event.ENTER_FRAME,gameLoop);

			this.rotation +=  Math.random() * 180;

			if (Math.random() * 2 > 1)
			{
				this.rotation *=  -1;
			}
			shapesRotation = this.rotation * Math.PI / 180; 
			
			refM.ExShapesColor = Math.random() * 0xFFFFFF;
			refM.myExploColorTransform.color = refM.ExShapesColor;
			this.transform.colorTransform = refM.myExploColorTransform;
		}

		function gameLoop(myEvent:Event):void
		{
			
			/*var boundyLeft:Number = refM.temp.x - refM.fragmentRange;
			var boundyTop:Number = refM.temp.y - refM.fragmentRange;
			var boundyRight:Number = refM.temp.x + refM.fragmentRange;
			var boundyBottom:Number = refM.temp.y + refM.fragmentRange
		    if (this.x < boundyLeft || this.x > boundyRight || this.y < boundyTop || this.y > boundyBottom)
			{  
				refM.destroyExploShape(this);
				this.removeEventListener(Event.ENTER_FRAME, gameLoop);
			}*/
			
			this.x +=  Math.cos(shapesRotation) * Math.random() * refM.maxSpeed;
			this.y +=  Math.sin(shapesRotation) * Math.random() * refM.maxSpeed;
			
			this.alpha -=  0.01;

			if (this.alpha < 0)
			{
				refM.destroyExploShape(this);
				this.removeEventListener(Event.ENTER_FRAME, gameLoop);
			}
			

		}



	}

}