package  {
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	public class BackOutline extends MovieClip {
		
		public var refM:MovieClip;
		
		public var myColorTransform = new ColorTransform  ;
		
		public var starts:Boolean = false;
		
		public function BackOutline() 
		{
			this.addEventListener(Event.ENTER_FRAME,gameL);
			refM = MovieClip (this.parent);
			refM.outlineArray.push(this);
			
		}
		public function gameL(myEvent:Event):void
		{
			if(starts == false)
			{
				refM.hitOut = true;
				starts = true;
			}
			
			if(refM.hitOut == true)
			{    
				this.alpha = 0;
				//myColorTransform.color = Math.random() * 0xFFFFFF;
				//refM.box1.transform.colorTransform = myColorTransform;
				//refM.box2.transform.colorTransform = myColorTransform;
				//refM.box3.transform.colorTransform = myColorTransform;
				
				//trace(refM.box3.transform.colorTransform.color.toString(16))
				//refM.hitOut = false;
			}
			for (var s:uint = 0; s < refM.playerArray.length; s++)
			{
				if(refM.playerArray[s].hitTestObject(this))
				{
					refM.createNewPlayer()
				}
			}
			for (var i:uint = 0; i < refM.myShapesArray.length; i++)
			{
				if(refM.myShapesArray[i].hitTestObject(this))
				{   
					refM.hitOut = true;
					refM.destroyShapes(refM.myShapesArray[i]);
					refM.shapesState = false;
					refM.targetMove = "findTarget";
				}
			}
		}
	}
	
}
