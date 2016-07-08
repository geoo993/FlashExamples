package
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	public class Snowflake extends MovieClip
	{
		public var ySpeed:Number;
		public var xSpeed:Number;
		
		function Snowflake():void
		{
			this.addEventListener(Event.ENTER_FRAME, updateSnowflake);
			
			xSpeed = randomRange(-1, 1);;
			ySpeed = randomRange(3, 7);;
		
		} 
		
		public function SnowflakeDestructor():void
		{
			this.removeEventListener(Event.ENTER_FRAME, updateSnowflake);
		} 
		
		function updateSnowflake(e:Event):void
		{
			this.x += xSpeed;
			this.y += ySpeed;
			
			if (this.y > (stage.stageHeight + this.height))
			{				
				this.y = 0 - (this.height / 2);
				
				xSpeed = (Math.random() * 2) - 1; 
				ySpeed = (Math.random() * 4) + 3; 
				
			} 
		
		} 
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
		
	} 
	
} 