package
{
	import flash.display.*;
	import flash.events.*;
	
	public class Circle extends MovieClip
	{
		
		public var xSpeed:Number;
		public var ySpeed:Number;
		public var alphaDecay:Number;
		public var fadeBack:Boolean = false;
		
		public function Circle()
		{
			this.addEventListener(Event.ENTER_FRAME, updateParticle);
			
			xSpeed = (Math.random() * 10) - 5;
			ySpeed = (Math.random() * 10) - 5;			
			alphaDecay = Math.random() / 100;
					
		}
		
		public function ParticleDestructor():void
		{
			this.removeEventListener(Event.ENTER_FRAME, updateParticle);
		}
				
		public function updateParticle(e:Event):void
		{
			
			this.x += xSpeed;
			this.y += ySpeed;
			
			if (fadeBack == false) 
			{
				this.alpha -= alphaDecay;
			
				if (this.alpha <= 0) 
				{
					this.x = Math.random() * stage.stageWidth;
					this.y = Math.random() * stage.stageHeight;
					
					this.xSpeed = (Math.random() * 10) - 5;
					this.ySpeed = (Math.random() * 10) - 5;
					
					fadeBack = true;
				}
			}
			if (fadeBack == true) 
			{
				this.alpha += 0.15;
				
				if (this.alpha >= 1) 
				{
					fadeBack = false;
				}
			}
			
		} 
		
	} 

} 