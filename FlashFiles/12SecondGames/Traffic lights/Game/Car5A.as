package 
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Car5A extends MovieClip
	{

		var refM:MovieClip;
		var car5Speed:Number = 0;


		public function Car5A()
		{
			this.addEventListener(Event.ENTER_FRAME,gLoop);
			refM = MovieClip(this.parent);

		}

		function gLoop(event:Event):void
		{

			if (this.x < 0 - 100)
			{
				this.x = 600 + 96;
			}

			if (refM.light1.Statee == false)
			{
				car5Speed = 7;
				this.x -=  car5Speed;
			}
			if (refM.light1.Statee == true)
			{
				if (this.x > 408)
				{
					car5Speed = 1;
					this.x -=  car5Speed;
				}

				if (this.x < 408)
				{
					car5Speed = 4;
					this.x -=  car5Speed;
				}

				if (this.x == 408)
				{
					this.x +=  car5Speed;
				}
			}

			if (this.hitTestObject(refM.maincar1))
			{
				refM.light1.carPos = false;
				refM.loser.losingState = true;
				refM.loser2.losingState2 = true;

			}
			if (this.hitTestObject(refM.car6a))
			{
				this.x +=  car5Speed;

			}

		}

	}

}