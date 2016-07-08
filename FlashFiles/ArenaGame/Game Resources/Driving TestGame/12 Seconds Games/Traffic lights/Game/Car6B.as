package 
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Car6B extends MovieClip
	{

		var refM:MovieClip;
		var car6Speed:Number = 0;


		public function Car6B()
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
				car6Speed = 8;
				this.x +=  car6Speed;

			}
			if (refM.light1.Statee == true)
			{
				
				if (this.x > 232)
				{
					car6Speed = 4;
					this.x +=  car6Speed;
				}
				if (this.x < 232)
				{
					car6Speed = 1;
					this.x +=  car6Speed;
				}
				if (this.x == 232)
				{
					this.x -=  car6Speed;
				}

			}

			if (this.hitTestObject(refM.maincar1))
			{
				refM.light1.carPos = false;
				refM.loser.losingState = true;
				refM.loser2.losingState2 = true;

			}
			if (this.hitTestObject(refM.car5b))
			{
				this.x -=  car6Speed;

			}
			
		}

	}

}