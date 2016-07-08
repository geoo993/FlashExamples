package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Winner extends MovieClip 
	{
		var winnerState:Boolean = false;
		
		public function Winner() 
		{
			this.addEventListener(Event.ENTER_FRAME,gLoop);
		}
		function gLoop(event:Event):void
		{
			if (winnerState == true)
			{
				this.x = 520;
				this.y = 572;
			}

			if (winnerState == false)
			{
				this.y = 2000;
			}
		}
	}
	
}
