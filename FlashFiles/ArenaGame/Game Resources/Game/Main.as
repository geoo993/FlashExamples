package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;


	public class Main extends MovieClip
	{
		public var count:int = 0;

		var gameState:String = "menu";
		var startTimer:Number = 3;
		var counterr:Number = 0;

		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gameLoop);
			stage.addEventListener(MouseEvent.CLICK, mouseClick);
			stop();

		}

		function gameLoop(myEvent:Event):void
		{
			if (this.currentFrame == 1)
			{
				if (gameState == "countDown")
				{
					startButton.y = 700;
					titlee.y = 1000;
					
					text1.x = 245;
					text1.y = 280;

					text2.x = 160;
					text2.y = 220;

					text2.text = "GAME STARTS IN";


					counterr +=  1;
					if (counterr == 23)
					{
						startTimer -=  1;
						counterr = 0;
					}

					if (startTimer < 1)
					{
						startTimer = 0;
					}
					
					text1.text = startTimer.toString();
					
					if (startTimer == 0)
					{
						this.gotoAndStop("Game");
					}

				}
			}
		}
		public function mouseClick(event: MouseEvent):void
		{

			if (event.target.name == "startButton")
			{
				gameState = "countDown";
			}
		}

	}

}