package  
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Loser extends MovieClip 
	{
		var losingState:Boolean = false;
		var refM:MovieClip;
		var lCounter:Number = 0;
		
		public function Loser() 
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			refM = MovieClip(this.parent);
		}
		function gL(event:Event):void
		{
			if (losingState == true)
			{
				this.x = 520;
				this.y = 600;
				refM.restartButton.restartState = true;
				refM.light1.x = 2000
				
				//lCounter += 1;
//				trace(lCounter)
//				
//				if (lCounter > 70)
//				{
//					lCounter = 0;
//					losingState = false;
//				}
			}
			if (losingState == false)
			{
				this.y = 2000;
			}
		}
	}
	
}
