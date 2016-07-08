package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Panel extends MovieClip 
	{
		
		var refM:MovieClip;
		var counter:Number = 0;
		var gameTimer:Number = 12;
		
		public function Panel() 
		{
			this.addEventListener(Event.ENTER_FRAME,gLoop);
			refM = MovieClip(this.parent);
		}
		function gLoop(myEvent:Event):void
		{
			counter += 1
			
			if (counter == 24)
			{
				gameTimer -= 1;
				counter = 0;
			}
			
			if (gameTimer < 1)
			{
				gameTimer = 0;
			
			}
			
			if (gameTimer == 0)
			{
				refM.playagainbut.hitState = true;
				refM.motobike.motobikeState = false;
			}
			refM.panel.timerbox.text = gameTimer.toString();
		}
	}
	
}
