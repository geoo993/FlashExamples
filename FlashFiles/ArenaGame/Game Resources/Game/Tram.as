package 
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Tram extends MovieClip
	{

		var refM:MovieClip;
		var tramSpeed:Number = 15;

		public function Tram()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			refM = MovieClip(this.parent);
			this.stop();
		}

		function gL(event:Event):void
		{

			this.x +=  tramSpeed;
			
			refM.tramsign.text = "KEEP    CLEAR";

			if (this.x > 650 + 360)
			{
				this.x = -350;
			}
			
			if (this.hitTestObject(refM.maincar1))
			{
				refM.light1.carPos = false;
				refM.loser.losingState = true;
				refM.loser2.losingState2 = true;

			}

		}

	}

}