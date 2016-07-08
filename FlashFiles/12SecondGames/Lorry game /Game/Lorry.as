package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;


	public class Lorry extends MovieClip
	{

		var speeed:Number = 0;
		var speedMax:Number = 8;
		var speedMaxReverse:Number = -4;
		var speedAcceleration:Number = .20;
		var speedDeceleration:Number = .90;
		
		var groundFriction:Number = .92;

		var steering:Number = 0;
		var steeringMax:Number = 2;
		var steeringAcceleration:Number = .15;
		var steeringFriction:Number = .95;

		var velocityX:Number = 0;
		var velocityY:Number = 0;

		var up:Boolean = false;
		var down:Boolean = false;
		var left:Boolean = false;
		var right:Boolean = false;

		var counter:Number = 0;
		var gameTimer:Number = 12;

		var lorryState:Boolean = false;
		var xPos:Number = 0;
		var yPos:Number = 0;
		

		var refM:MovieClip;


		public function Lorry()
		{
			this.addEventListener(Event.ENTER_FRAME,gLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onMyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP,onMyRelease);
			refM = MovieClip(this.parent);
			
		}

		function gLoop(myEvent:Event):void
		{
			
			
			refM.box1.text3.text = "TURN";
			
			counter += 1
			
			if (counter == 24)
			{
				gameTimer -= 1;
				counter = 0;
			}
			
			if (gameTimer < 1)
			{
				gameTimer = 0;
			
			}
			if (gameTimer == 0)
			{
				lorryState = false;
				gameTimer = 0;
			}
			refM.box1.text2.text = gameTimer.toString();
			
			if (lorryState == false)
			{

				xPos = stage.stageWidth - 470;
				this.x = xPos;

				yPos = stage.stageHeight - 60;
				this.y = yPos;
				
				this.rotation = 90;
				gameTimer = 12;
				
			}
			
			if (this.y < 190)
			{
				counter = 0;
				speeed += 0.02;
				steering = 0;
				speedMaxReverse = 0;
				refM.winner.winnerState = true;
				refM.playagain.restartState = true;
				refM.box1.text3.alpha = 0;
				refM.box1.text2.alpha = 0;
			}
			
			if (lorryState == true)
			{

				if (up)
				{
					
					if ((speeed < speedMax))
					{
						speeed +=  speedAcceleration;

						if ((speeed > speedMax))
						{

							speeed = speedMax;
						}
					}
				}

				if (down)
				{
					
					if ((speeed > speedMaxReverse))
					{

						speeed -=  speedAcceleration;

						if ((speeed < speedMaxReverse))
						{
							speeed = speedMaxReverse;
						}
					}
				}
				if (left)
				{
					steering -=  steeringAcceleration;

					if ((steering > steeringMax))
					{

						steering = steeringMax;
					}
				}


				if (right)
				{
					steering +=  steeringAcceleration;

					if ((steering <  -  steeringMax))
					{ 
						steering =  -  steeringMax;
					}
				}

				speeed *=  groundFriction;

				if ((speeed > 0) && speeed < 0.05)
				{
					speeed = 0;
				}

				velocityX = Math.sin(this.rotation * Math.PI / 180) * speeed;
				velocityY = Math.cos(this.rotation * Math.PI / 180) *  -  speeed;


				this.x +=  velocityX;
				this.y +=  velocityY;


				if (steering > 0)
				{
					if (steering < 0.05)
					{
						steering = 0;
					}
				}
				else if (steering < 0)
				{
					if (steering > -0.05)
					{
						steering = 0;
					}
				}

				steering = steering * steeringFriction;

				steering -=  (steering * 0.1);

				this.rotation +=  steering * speeed;
			}

		}


		function onMyPress(event:KeyboardEvent):void
		{

			//trace("Key Code Pressed: " + event.keyCode);
			if (event.keyCode == 87 || event.keyCode == 38)
			{
				lorryState = true;
				speeed += 0.1
				up = true; 
			}

			if (event.keyCode == 83 || event.keyCode == 40)
			{
				lorryState = true;
				down = true;
			}

			if (event.keyCode == 65 || event.keyCode == 37)
			{
				lorryState = true;
				left = true;
			}

			if (event.keyCode == 68 || event.keyCode == 39)
			{
				lorryState = true;
				right = true;
			}

			if (event.keyCode == 32)
			{
				lorryState = false;
			}

			event.updateAfterEvent();
		}

		function onMyRelease(event:KeyboardEvent):void
		{
			
			if (event.keyCode == 87 || event.keyCode == 38)
			{
				up = false;
			}

			if (event.keyCode == 83 || event.keyCode == 40)
			{
				down = false;
			}

			if (event.keyCode == 65 || event.keyCode == 37)
			{
				left = false;
			}

			if (event.keyCode == 68 || event.keyCode == 39)
			{
				right = false;
			}

		}

	}
}