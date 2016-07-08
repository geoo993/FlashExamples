package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;


	public class RestartButton extends MovieClip
	{
		var refM:MovieClip;
		var restartState:Boolean = false;
		var deathCount:Number = 0;


		public function RestartButton()
		{
			this.addEventListener(Event.ENTER_FRAME,gLoop);
			this.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
			refM = MovieClip(this.parent);

		}
		function gLoop(event:Event):void
		{
			refM.deaths.text = deathCount.toString();

			if (restartState == true)
			{
				this.x = 525;
				this.y = 60;
			}

			if (restartState == false)
			{
				this.y = 1000;
			}
		}

		function MouseDown(event:MouseEvent):void
		{
			if(refM.winner.winnerState == true)
			{
				deathCount = 0;
			}
			else
			deathCount += 1;
			restartState = false;
			refM.maincar1.y = 550;
			refM.maincar1.x = 285;
			refM.timerbox.gameTimer = 0;
			refM.timerbox.count += 1;
			refM.getheresign.alpha = 1;
			refM.winner.winnerState = false;
			refM.winner2.winnerState2 = false;
			refM.loser.losingState = false;
			refM.loser2.losingState2 = false;
			refM.light1.x = 77;
			refM.car5b.x = 225;
			refM.car6b.x = 545;
			refM.car4a.x = 100;
			refM.car1a.x = 415;
			refM.car1b.x = 235;
			refM.car4b.x = 760;
			refM.car5a.x = 280;
			refM.car6a.x = 595;
			refM.car2a.x = 190;
			refM.car3b.x = 520;
			refM.car3a.x = 15;
			refM.car2b.x = 410;
			
		}

	}

}