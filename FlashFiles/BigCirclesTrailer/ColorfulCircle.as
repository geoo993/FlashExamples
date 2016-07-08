package {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;

	public class ColorfulCircle extends MovieClip {

		public var speed:Number;
		
		public var circlesColorTransform = new ColorTransform  ;
		public var circlesColor:uint = Math.random() * 0xFFFFFF;
		
		public var Color1:uint = Math.random() * 0xFFFFFF;
		public var Color2:uint = Math.random() * 0xFFFFFF;
		public var Color3:uint = Math.random() * 0xFFFFFF;
		public var Color4:uint = Math.random() * 0xFFFFFF;
		public var Color5:uint = Math.random() * 0xFFFFFF;

		public function ColorfulCircle() {
			speed=.01+.02*Math.random();
			this.alpha = .4;
			SetRandomColor();
			
			this.addEventListener(Event.ENTER_FRAME, FadeCircleOut);
		}

		public function FadeCircleOut(e:Event) {
				
			
			this.alpha-=.5*speed;
			this.scaleX+=2*speed;
			this.scaleY+=2*speed;

			if (this.alpha<0) {
				this.removeEventListener(Event.ENTER_FRAME, FadeCircleOut);
				parent.removeChild(this);
			}
		}

		public function SetRandomColor() {
			var colorArray:Array = new Array(Color1, Color2, Color3, Color4, Color5); 
			var randomColorID:Number = Math.floor(Math.random()*colorArray.length); 
			  
			var myColor:ColorTransform = this.transform.colorTransform; 
			myColor.color = colorArray[randomColorID]; 
			  
			this.transform.colorTransform = myColor; 
			
			
			/*circlesColor = Math.random() * 0xFFFFFF;
			circlesColorTransform.color = circlesColor;
			this.transform.colorTransform = circlesColorTransform;*/
		}
		
	}
}