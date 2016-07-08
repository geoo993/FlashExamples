package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;


	public class Motobike extends MovieClip
	{
		var refM:MovieClip;

		var slowDown:Boolean = false;
		var leeft:Boolean = false;
		var riight:Boolean = false;

		var speeed:Number = 0;
		var speedMax:Number = 3;
		var speedAcceleration:Number = 0.15;

		var velocityX:Number = 0;
		var velocityY:Number = 0;

		var motobikeState:Boolean = false;
		
		var xPos:Number = 0;
		var yPos:Number = 0;


		public function Motobike()
		{
			this.addEventListener(Event.ENTER_FRAME,gameLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyUp);
			refM = MovieClip(this.parent);

		}
		function gameLoop(myEvent:Event):void
		{

			//y position
			if (this.y < 0)
			{
				this.y = 620;
			}
			if (this.y > 620)
			{
				this.y = 0;
			}

			if (motobikeState == false)
			{

				xPos = stage.stageWidth - 75;
				this.x = xPos;

				yPos = stage.stageHeight - 30;
				this.y = yPos;

				this.rotation = 0;
				motobikeState = true;
				refM.panel.gameTimer = 12;
			}

			if (motobikeState == true)
			{
				//moving speed
				
				if (speeed < speedMax)
				{
					speeed +=  speedAcceleration;

					if (speeed > speedMax)
					{
						speeed = speedMax;
					}
				}

				velocityX = Math.sin(this.rotation * Math.PI / 180) * speeed;
				velocityY = Math.cos(this.rotation * Math.PI / 180) *  -  speeed;

				this.x +=  velocityX;
				this.y +=  velocityY;

				//slowdown movement
				if (slowDown)
				{
					speeed -=  0.040;
					speedAcceleration = 0;
				}

				//rotation
				if (leeft)
				{
					this.rotation -=  3;
				}
				if (riight)
				{
					this.rotation +=  3;
				}
			}
			if (this.hitTestObject(refM.winnerss))
			{
				refM.exitpoint.gotoAndStop(1); 
				refM.winner.winningState = true;
				refM.playagainbut.x = 340;
				refM.playagainbut.y = 30;
				speeed -= 0.15;
				if (speeed < 0)
				{
					speeed = 0;
				}
				refM.panel.counter = 0;
				refM.panel.arrow1.alpha = 0;
				refM.panel.arrow2.alpha = 0;
				refM.panel.arrow3.alpha = 0;
				
				
			}

		}

		function KeyDown(event:KeyboardEvent):void
		{

			//trace("Key Code Pressed: " + event.keyCode);

			if (event.keyCode == 32)
			{
				slowDown = true;
			}

			if (event.keyCode == 39)
			{
				riight = true;
			}
			if (event.keyCode == 37)
			{
				leeft = true;
			}

		}
		function KeyUp(event:KeyboardEvent):void
		{
			if (event.keyCode == 32)
			{
				slowDown = false;
				speedAcceleration = 0.06;
			}

			if (event.keyCode == 39)
			{
				riight = false;
			}
			if (event.keyCode == 37)
			{
				leeft = false;
			}
		}
	}

}