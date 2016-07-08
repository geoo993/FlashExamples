package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Loser2 extends MovieClip 
	{
		var losingState2:Boolean = false;
		var refM:MovieClip;
		
		
		public function Loser2() 
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			refM = MovieClip(this.parent);
		}
		function gL(event:Event):void
		{
			if (losingState2 == true)
			{
				this.x = 120;
				this.y = 600;
			}
			if (losingState2 == false)
			{
				this.y = 2000;
			}
		}
	}
	
}
