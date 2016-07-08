package 
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Car2A extends MovieClip
	{

		var refM:MovieClip;
		var car2Speed:Number = 0;

		public function Car2A()
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
				car2Speed = 6;
				this.x -=  car2Speed;
			}
			if (refM.light1.Statee == true)
			{
				if (this.x > 408)
				{
					car2Speed = 1;
					this.x -=  car2Speed;
				}

				if (this.x < 408)
				{
					car2Speed = 3;
					this.x -=  car2Speed;
				}

				if (this.x == 408)
				{
					this.x +=  car2Speed;
				}


			}

			if (this.hitTestObject(refM.maincar1))
			{
				refM.light1.carPos = false;
				refM.loser.losingState = true;
				refM.loser2.losingState2 = true;

			}
			if (this.hitTestObject(refM.car3b))
			{
				this.x +=  car2Speed;

			}

		}

	}

}