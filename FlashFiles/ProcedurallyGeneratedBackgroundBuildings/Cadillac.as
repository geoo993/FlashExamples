package  
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	public class Cadillac extends Sprite 
	{
		public var stageW:int = 1200;
		public var stageH:int = 600;
		public var speed:Number = Math.random()*5;
		public var wSpeed:Number = 5;
		
		public var myColorTransform = new ColorTransform  ;
		
		public function Cadillac():void 
		{
			this.addEventListener(Event.ENTER_FRAME, updateCar);
			
			this.x = this.width;
			this.y = stageH + 65;
			
			myColorTransform.color = Math.random()*0xFFFFFF;
			this.bodyy.transform.colorTransform = myColorTransform;
			
			
		}
		
		function updateCar(e:Event):void
		{
			this.bodyy.alpha = .8
			this.x += speed;
			this.rWheel.rotation += wSpeed;
			this.lWheel.rotation += wSpeed;
		} 
		function randomRange(minNum:int,maxNum:int)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
	}
	
}
