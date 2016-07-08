package 
{

	import flash.display.MovieClip;
	import flash.events.Event;


	public class Car3 extends MovieClip
	{
		var refM:MovieClip;

		public function Car3()
		{
			this.addEventListener(Event.ENTER_FRAME,gLoop);
			refM = MovieClip(this.parent);
		}
		function gLoop(event:Event):void
		{

			this.rotation -= 0.015;
			
			this.y -=  0.5;

			if (this.y < 460)
			{
				this.y +=  0.5;
				this.rotation = -2.5;
			}
			
			if (this.car3hitbox.hitTestObject(refM.motobike.hitboxes2a))
			{
				refM.playagainbut.hitState = true;
				refM.motobike.motobikeState = false;
			}
			if (this.car3hitbox.hitTestObject(refM.motobike.hitboxes2b))
			{
				refM.playagainbut.hitState = true;
				refM.motobike.motobikeState = false;
			}
			
			
		}
	}

}