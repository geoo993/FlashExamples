package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Winner extends MovieClip 
	{
		var refM:MovieClip;
		var winningState:Boolean = false;
		
		public function Winner() 
		{
			this.addEventListener(Event.ENTER_FRAME,gLoop);
			refM = MovieClip(this.parent);
		}
		function gLoop(myEvent:Event):void
		{
			if(winningState == true)
			{
				this.x = 150;
				refM.loser.lossingState = false;
			}
			if(winningState == false)
			{
				this.x = 3000;
			}
		}
	}
	
}
