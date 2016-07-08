package 
{

	import flash.display.MovieClip;
	import flash.events.Event;


	public class Loser extends MovieClip
	{

		var losingState:String = "idle";
		var refM:MovieClip;

		public function Loser()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			refM = MovieClip(this.parent);
		}
		function gL(event:Event):void
		{

			if (losingState == "onScreen")
			{
				this.x = 200;
				this.y = 120;
				refM.winner.winnerState = false;
			}

			if (losingState == "offScreen")
			{
				this.y = 2000;
			}
		}
	}

}