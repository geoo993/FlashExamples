package 
{

	import flash.display.MovieClip;
	import flash.events.Event;

	public class Loser extends MovieClip
	{
		var refM:MovieClip;
		var lossingState:Boolean = false;
		
		public function Loser()
		{
			this.addEventListener(Event.ENTER_FRAME,gLoop);
			refM = MovieClip(this.parent);
		}
		function gLoop(myEvent:Event):void
		{
          if(lossingState == true)
		  {
			  this.x = 150;
			  refM.winner.winningState = false;
		  }
		  if(lossingState == false)
		  {
			  this.x = 2000;
		  }
		}

	}

}