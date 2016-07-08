package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Winner extends MovieClip 
	{
		var winnerState:Boolean = false;
		var refM:MovieClip;
		
		public function Winner() 
		{
			this.addEventListener(Event.ENTER_FRAME,gLoop);
			refM = MovieClip(this.parent);
		}
		function gLoop(event:Event):void
		{
			if (winnerState == true)
			{
				this.x = 190;
				this.y = 120;
				refM.loser.losingState = false;
				
			}

			if (winnerState == false)
			{
				this.y = 2000;
				
			}
		}
	}
	
}
