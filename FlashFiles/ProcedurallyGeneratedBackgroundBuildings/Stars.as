package  
{
	
	import flash.display.*;
	import flash.events.*;
	
	
	public class Stars extends Sprite 
	{
		
		public var xSpeed:Number;
		
		public function Stars():void 
		{
			
		}
		public function StarsCreator():void
		{
			this.x = Math.random() * stage.stageWidth;
			this.y = Math.random() * stage.stageHeight/1.1;
				
			var flakeScale:Number = Math.random() *3;	
			this.scaleX = flakeScale;
			this.scaleY = flakeScale;	
				
			this.rotationZ = randomRange(0,360)
			
			this.addEventListener(Event.ENTER_FRAME, updateStars);
			xSpeed = (Math.random() * 1.5) - .5;  
		}
		public function StarsDestructor():void
		{
			this.removeEventListener(Event.ENTER_FRAME, updateStars);
		} 
		function updateStars(e:Event):void
		{
			
			this.x += xSpeed;
			
			if (this.x > (stage.stageWidth + this.width))
			{				
				this.x = 0 - (this.width / 2);
				
				this.y = Math.random() *stage.stageHeight/1.2;
				xSpeed = (Math.random() * 1.5) - .5; 
			} 
			
			if (this.x < 0  - this.width)
			{				
				this.x = stage.stageWidth + (this.width) ;
				
				this.y = Math.random() *stage.stageHeight/1.2;
				xSpeed = (Math.random() * 1.5) - .5; 
			} 
		} 
		function randomRange(minNum:int,maxNum:int)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
	}
	
}
