package 
{
	import flash.events.*;
	import flash.display.*;
	import flash.geom.*;


	public class Base extends MovieClip
	{
		public var refM:MovieClip;


		public var baseColorTransform = new ColorTransform  ;

		public function Base()
		{
			this.addEventListener(Event.ENTER_FRAME,gLoop);

			refM = MovieClip(this.parent);

		}

		function gLoop(myEvent:Event):void
		{
			this.alpha = .4;
			refM.base2.alpha = .4
			
		}



	}

}