package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;


	public class Light extends MovieClip
	{
		var refM:MovieClip;

		var Statee:Boolean = false;
		var carPos:Boolean = false;

		var xPos:Number = 0;
		var yPos:Number = 0;


		public function Light()
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN,MouseDown);
			this.addEventListener(Event.ENTER_FRAME,gLoop);
			this.stop();
			refM = MovieClip(this.parent);

		}

		function gLoop(event:Event):void
		{


			if (carPos == false)
			{
				refM.maincar1.rotation = 0;

				xPos = stage.stageWidth - 365;
				refM.maincar1.x = xPos;

				yPos = stage.stageHeight - 80;
				refM.maincar1.y = yPos;

				refM.getheresign.alpha = 1;
				refM.timerbox.gameTimer = 0;
				Statee = false;

			}

				if (Statee == false)
				{
					this.gotoAndPlay(1);
				}

				if (Statee == true)
				{
					this.gotoAndPlay(2);
				}

		}

		function MouseDown(event:MouseEvent):void
		{
			Statee = ! Statee;
			this.play();
			carPos = true;

		}

	}

}