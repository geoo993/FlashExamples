package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;


	public class Main extends MovieClip
	{
		public var count:int = 0;

		var gameState:String = "countdown";
		var startTimer:Number = 4;
		var counter:Number = 0;

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
					startGame.y = 2000;
					titlee.y = 2000;
					
					right1.x = 307;
					left1.x = 257;
					space1.x = 46;
					
					text1.x = 50;
					text1.y = 124;

					text2.x = 120;
					text2.y = 220;

					text1.text = "GAME STARTS IN";


					counter +=  1;
					if ((counter == 23))
					{
						startTimer -=  1;
						counter = 0;
					}

					if ((startTimer < 1))
					{
						startTimer = 0;
					}
					text2.text = startTimer.toString();

					if ((startTimer == 0))
					{
						this.gotoAndStop("Game");
					}
				}
			}

		}
		public function mouseClick(event: MouseEvent):void
		{
			if (event.target.name == "startGame")
			{
				gameState = "countDown";
			}

		}

	}


}