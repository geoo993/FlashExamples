package 
{

	import flash.display.MovieClip;
	import flash.events.Event;


	public class HitBoxes extends MovieClip
	{
		var refM:MovieClip;

		public function HitBoxes()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			refM = MovieClip(this.parent);
		}
		function gL(myEvent:Event):void
		{

			if (this.hitTestObject(refM.motobike.hitboxes2a))
			{
				refM.playagainbut.hitState = true;
				refM.motobike.motobikeState = false;

			}
			if (this.hitTestObject(refM.motobike.hitboxes2b))
			{
				refM.playagainbut.hitState = true;
				refM.motobike.motobikeState = false;

			}

		}
	}

}