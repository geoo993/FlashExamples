package  {
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	public class cTwo extends MovieClip {
		
		public var refM:MovieClip;
		
		public function cTwo() 
		{
			refM = MovieClip (this.parent);
			refM.myArray.push(this)
		}
		
	}
	
}
