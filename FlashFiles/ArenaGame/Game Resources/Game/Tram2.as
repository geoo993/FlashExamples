package 
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Tram2 extends MovieClip
	{

		var refM:MovieClip;
		var tram2Speed:Number = 15;

		public function Tram2()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			refM = MovieClip(this.parent);
			this.stop();
		}

		function gL(event:Event):void
		{

			this.x -=  tram2Speed;

			if (this.x < 0 - 360)
			{
				this.x = 1000;
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