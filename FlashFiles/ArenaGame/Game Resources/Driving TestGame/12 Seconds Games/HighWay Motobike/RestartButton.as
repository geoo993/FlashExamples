package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;


	public class RestartButton extends MovieClip
	{
		var refM:MovieClip;
		var hitState:Boolean = false;
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

			if (hitState == true)
			{
				refM.loser.lossingState = true;
				refM.exitpoint.gotoAndStop(1);
				refM.motobike.speeed = 0;
				refM.motobike.speedMax = 0;
				refM.motobike.speedAcceleration = 0;
				refM.panel.counter = 0;
				refM.panel.arrow1.alpha = 0;
				refM.panel.arrow2.alpha = 0;
				refM.panel.arrow3.alpha = 0;
				this.x = 340;
				this.y = 30;
			}

			if (hitState == false)
			{
				this.y = 2000;

				refM.panel.arrow1.alpha = 1;
				refM.panel.arrow2.alpha = 1;
				refM.panel.arrow3.alpha = 1;
			}

		}

		function MouseDown(event:MouseEvent):void
		{
			if (refM.winner.winningState == true)
			{
				deathCount = 0;
			}
			else
			{
				deathCount +=  1;

			}
			hitState = false;
			refM.loser.lossingState = false;
			refM.winner.winningState = false;
			refM.motobike.rotation = 0;
			refM.motobike.motobikeState = false;
			refM.panel.counter +=  1;
			refM.panel.gameTimer = 12;
			refM.motobike.speeed = 0;
			refM.motobike.speedMax = 3;
			refM.motobike.speedAcceleration = 0.15;
			refM.car8.y = 615;
			refM.car7.y = 530;
			refM.car6.y = 580;
			refM.car5.y = 627;
			refM.car4.y = 362;
			refM.car3.y = 513;
			refM.car2.y = 494;
			refM.car1.y = 457;
			refM.exitpoint.play();

		}

	}

}