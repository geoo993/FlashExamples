package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Winner2 extends MovieClip 
	{
		var winnerState2:Boolean = false;
		
		public function Winner2() 
		{
			this.addEventListener(Event.ENTER_FRAME,gLoop);
		}
		function gLoop(event:Event):void
		{
			if (winnerState2 == true)
			{
				this.x = 120;
				this.y = 572;
			}

			if (winnerState2 == false)
			{
				this.y = 2000;
			}
		}
	}
	
}
