package  
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	public class ColorTriangle extends MovieClip 
	{
		public var speed:Number;
		
		public var Color1:uint = Math.random() * 0xFFFFFF;
		public var Color2:uint = Math.random() * 0xFFFFFF;
		public var Color3:uint = Math.random() * 0xFFFFFF;
		public var Color4:uint = Math.random() * 0xFFFFFF;
		public var Color5:uint = Math.random() * 0xFFFFFF;
		
		public function ColorTriangle() {
		
			speed = .01+.02*Math.random();
			this.alpha = .4;
			SetRandomColor();
			
			this.addEventListener(Event.ENTER_FRAME, FadeTriangleOut);
		}
		public function FadeTriangleOut(e:Event) 
		{
				
			this.alpha-= .5*speed;
			this.scaleX-= .1*speed;
			this.scaleY-= .1*speed;

			if (this.alpha<0) {
				this.removeEventListener(Event.ENTER_FRAME, FadeTriangleOut);
				parent.removeChild(this);
			}
		}
		public function SetRandomColor() 
		{
			var colorArray:Array = new Array(Color1, Color2, Color3, Color4, Color5); 
			var randomColorID:Number = Math.floor(Math.random()*colorArray.length); 
			  
			var mytriangleColor:ColorTransform = this.transform.colorTransform; 
			mytriangleColor.color = colorArray[randomColorID]; 
			  
			this.transform.colorTransform = mytriangleColor; 
		}
	}
	
}
