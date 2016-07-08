package
{
	import flash.display.*;
	import flash.events.*;
	
	public class Dots extends MovieClip
	{
		//public var xMovement:Number = randomRange(-8, 8);;
		//public var yMovement:Number = randomRange(-8, 8);;
		
		public var xMovement:Number = Math.random() * 10 - 5;
		public var yMovement:Number = Math.random() * 10 - 5;
		
		public var scalee:Number = .01;
		
		function Dots()
		{
			this.addEventListener(Event.ENTER_FRAME, updatePart);
		} 
		
		function updatePart(e:Event):void
		{
			this.x += xMovement;
			this.y += yMovement;
			
			this.scaleX -= scalee;
			this.scaleY -= scalee;
			
			this.alpha -= .005;
			
		} 
		public function partDestructor()
		{
			this.removeEventListener(Event.ENTER_FRAME, updatePart);
		} 
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
		
	} 
	
} 