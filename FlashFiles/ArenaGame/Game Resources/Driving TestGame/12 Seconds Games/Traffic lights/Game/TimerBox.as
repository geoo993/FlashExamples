package 
{

	import flash.display.MovieClip;
	import flash.events.Event;


	public class TimerBox extends MovieClip
	{
		var refM:MovieClip;

		var count:Number = 0;
		var gameTimer:Number = 12;


		public function TimerBox()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			refM = MovieClip(this.parent);
		}
		function gL(event:Event):void
		{

				count +=  1;

				if (count == 23)
				{
					gameTimer -=  1;
					count = 0;
				}

				if (gameTimer < 1)
				{
					gameTimer = 0;
				}
				if (gameTimer == 0)
				{
					gameTimer = 12;
					refM.light1.carPos = false;
				}
				refM.text2.text = gameTimer.toString();

		}
	}

}