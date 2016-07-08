package  {
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	
	public class Scanner extends MovieClip {
		
		public var refM:MovieClip;
		
		public var shapesColorTransform = new ColorTransform  ;
		public var scanColorTransform = new ColorTransform  ;
		
		public var scanDirection:Number = 0;
		
		public var posState:Boolean = false;
		public var position:String = "idle";
		
		public function Scanner() {
		
			this.addEventListener(Event.ENTER_FRAME,gameL);
			refM = MovieClip (this.parent);
		}

		public function gameL(myEvent:Event):void
		{
	
			if(posState == false)
			{
				scanDirection = Math.round(Math.random() * 2);
				position = "pos";
				posState = true;
			}
			
			if(posState == true)
			{
				if(scanDirection == 0)
				{
					if(position == "pos")
					{
						this.x = -30;
						this.y = 1;
						this.rotation = 0;
						position = "move";
					}
					if(position == "move")
					{
						this.x += 2;
					}
				}
				if(scanDirection == 1)
				{
					
					if(position == "pos")
					{
						this.x = 1230;
						this.y = 1;
						this.rotation = 0;
						position = "move";
					}
					if(position == "move")
					{
						this.x -= 2;
					}
				}
				if(scanDirection == 2)
				{
					if(position == "pos")
					{
						this.x = -10;
						this.y = -30;
						this.rotation = -90;
						position = "move";
					}
					if(position == "move")
					{
						this.y += 2;
					}
	
				}
			}
			
			if (this.alpha >= .4)
			{
				TweenNano.to(this,2,{alpha:0});
			}
			if (this.alpha <= 0)
			{
				TweenNano.to(this,2,{alpha:.5});
				scanColorTransform.color = Math.random() * 0xFFFFFF;
				this.transform.colorTransform = scanColorTransform;
			}
			
			if(this.x > 1240 || this.x < -40 || this.y >740)
			{
				posState = false;
			}
			
			for (var i:uint = 0; i < refM.myShapesArray.length; i++)
			{
			
				if(refM.myShapesArray[i].hitTestObject(this))
				{   
					refM.shapesColor = Math.random() * 0xFFFFFF;
					refM.newShapeColorTransform.color = refM.shapesColor ;
					refM.myShapesArray[i].transform.colorTransform = refM.newShapeColorTransform;
				}
			}
			for (var e:uint = 0; e < refM.playerArray.length; e++)
			{
			
				if(refM.playerArray[e].hitTestObject(this))
				{
					if(this.alpha> .15)
					{
						refM.playerColorChange();
					}
				}
			}
			
		}
		
	}
	
}
