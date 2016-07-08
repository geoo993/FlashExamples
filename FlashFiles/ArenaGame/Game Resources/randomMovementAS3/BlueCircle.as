package 
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class BlueCircle extends MovieClip
	{
		private var newX:Number = 0;
		private var newY:Number = 0;

		private var speed:Number;

		private var speedX:Number;
		private var speedY:Number;

		private var totalDistance:Number;
		private var previousDistance:Number = 0;
		private var currentDistance:Number = 0;

		public function BlueCircle()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, Setup);
		}

		private function SetNewPosition()
		{
			this.newX = this.GetRandomXPosition();
			this.newY = this.GetRandomYPosition();

			this.totalDistance = this.GetDistance();

			var time:Number = this.totalDistance / this.speed;

			speedX = (this.newX - this.x)/time;
			speedY = (this.newY - this.y)/time;
		}

		private function Setup(e:Event)
		{
			this.x = this.GetRandomXPosition();
			this.y = this.GetRandomYPosition();

			this.alpha = .1 + Math.random() * .5;
			this.scaleX = this.scaleY = .1 + Math.random() * 5;

			speed = Math.round(.5 + Math.random() * 5);

			this.addEventListener(Event.ENTER_FRAME, MoveCircle);
		}

		private function GetRandomXPosition():Number
		{
			//
			//basic formula: Math.floor(Math.random()*(1+High-Low))+Low; 
			//
			return Math.floor(Math.random() * (1+ (stage.stageWidth + this.width) + this.width) - this.width);
		}

		private function GetRandomYPosition():Number
		{
			//
			//basic formula: Math.floor(Math.random()*(1+High-Low))+Low; 
			//
			return Math.floor(Math.random() * (1+ (stage.stageHeight + this.height) + this.height) - this.height);
		}

		private function GetDistance():Number
		{
			return Math.sqrt(Math.pow(this.x - this.newX,2) + Math.pow(this.y - this.newY,2));
		}

		private function MoveCircle(e:Event)
		{
			this.previousDistance = this.currentDistance;
			this.currentDistance = this.GetDistance();

			if (this.currentDistance < this.previousDistance)
			{
				this.x +=  this.speedX;
				this.y +=  this.speedY;
			}
			else
			{
				this.SetNewPosition();
			}
		}
	}
}