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
					startButton.y = 1000;
					titlee.y = 1000;
					
					up.x = 250;
					down.x = 250;
					left.x = 200;
					right.x = 310;

					text1.x = 192;
					text1.y = 200;

					text2.x = 110;
					text2.y = 100;

					text2.text = "GAME STARTS IN";


					counter +=  1;
					if (counter == 23)
					{
						startTimer -=  1;
						counter = 0;
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