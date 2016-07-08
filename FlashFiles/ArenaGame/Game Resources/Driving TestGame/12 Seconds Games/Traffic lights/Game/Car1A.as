package 
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Car1A extends MovieClip
	{

		var refM:MovieClip;
		var car1Speed:Number = 0;


		public function Car1A()
		{
			this.addEventListener(Event.ENTER_FRAME,gLoop);
			refM = MovieClip(this.parent);

		}

		function gLoop(event:Event):void
		{

			if (this.x > 650 + 100)
			{
				this.x = -100;
			}


			if (refM.light1.Statee == false)
			{
				car1Speed = 5;
				this.x +=  car1Speed;

			}
			if (refM.light1.Statee == true)
			{
				
				if (this.x > 232)
				{
					car1Speed = 3;
					this.x +=  car1Speed;
				}
				if (this.x < 232)
				{
					car1Speed = 1;
					this.x +=  car1Speed;
				}
				if (this.x == 232)
				{
					this.x -=  car1Speed;
				}

			}

			if (this.hitTestObject(refM.maincar1))
			{
				refM.light1.carPos = false;
				refM.loser.losingState = true;
				refM.loser2.losingState2 = true;

			}
			if (this.hitTestObject(refM.car4a))
			{
				this.x -=  car1Speed;

			}

		}

	}

}