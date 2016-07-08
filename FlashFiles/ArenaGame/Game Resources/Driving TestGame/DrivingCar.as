package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	public class DrivingCar extends MovieClip
	{

		var refM:MovieClip;

		var speeed:Number = 0;
		var speedMax:Number = 15;
		var speedMaxReverse:Number = -8;
		var speedAcceleration:Number = .50;
		var speedDeceleration:Number = 1;

		var groundFriction:Number = .92;

		var steering:Number = 0;
		var steeringMax:Number = 2.4;
		var steeringAcceleration:Number = .20;
		var steeringFriction:Number = .95;

		var velocityX:Number = 0;
		var velocityY:Number = 0;

		var up:Boolean = false;
		var down:Boolean = false;
		var left:Boolean = false;
		var right:Boolean = false;

		var leftSignal:Boolean = false;

		var rightSignal:Boolean = false;





		public function DrivingCar()
		{
			this.addEventListener(Event.ENTER_FRAME,gLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onMyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP,onMyRelease);
			refM = MovieClip(this.parent);

			refM.carsArray.push(this);

		}
		function gLoop(myEvent:Event):void
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

			if (((speeed > 0) && speeed < 0.05))
			{
				speeed = 0;
			}

			velocityX = Math.sin(this.rotation * Math.PI / 180) * speeed;
			velocityY = Math.cos(this.rotation * Math.PI / 180) *  -  speeed;


			this.x +=  velocityX;
			this.y +=  velocityY;


			if ((steering > 0))
			{
				if ((steering < 0.05))
				{
					steering = 0;
				}
			}
			else if ((steering < 0))
			{
				if ((steering > -0.05))
				{
					steering = 0;
				}
			}

			steering = steering * steeringFriction;

			steering -=  (steering * 0.1);

			this.rotation +=  steering * speeed;


			if (this.y < -80)
			{
				this.y = 680;
			}

			if (this.y > 680)
			{
				this.y = -80;
			}

			if (this.x > 880)
			{
				this.x = -80;
			}

			if (this.x < -80)
			{
				this.x = 880;
			}


			

		}
		function onMyPress(event:KeyboardEvent):void
		{
			if (event.keyCode == 87 || event.keyCode == 38)
			{
				up = true;
				speeed +=  0.1;
			}

			if (event.keyCode == 83 || event.keyCode == 40)
			{

				down = true;
			}

			if (event.keyCode == 65 || event.keyCode == 37)
			{

				left = true;
			}

			if (event.keyCode == 68 || event.keyCode == 39)
			{

				right = true;
			}
			event.updateAfterEvent();


			//trace(event.keyCode);

			if (event.keyCode == 90)
			{
				leftSignal = true;
				rightSignal = false;
			}
			if (event.keyCode == 88)
			{
				rightSignal = true;
				leftSignal = false;
			}
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