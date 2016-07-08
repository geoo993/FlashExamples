package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class MainCar extends MovieClip
	{

		var refM:MovieClip;
		var carSpeed:Number = 0;

		public function MainCar()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			refM = MovieClip(this.parent);
		}

		function gL(event:Event):void
		{

			if (refM.light1.Statee == true)
			{
				carSpeed = 5;
				this.y -=  carSpeed;
			}

			if (this.y == 20)
			{
				this.y +=  carSpeed;
			}

			if (this.hitTestObject(refM.getheresign))
			{
				refM.getheresign.alpha = 0;
				refM.restartButton.restartState = true;
				refM.timerbox.count = 0;
				
				refM.winner.winnerState = true;
				refM.winner2.winnerState2 = true;
				
			}
		}

	}

}