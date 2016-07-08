package 
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Car5B extends MovieClip
	{

		var refM:MovieClip;
		var car5Speed:Number = 0;


		public function Car5B()
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
				car5Speed = 8;
				this.x +=  car5Speed;

			}
			if (refM.light1.Statee == true)
			{
				
				if (this.x > 232)
				{
					car5Speed = 4;
					this.x +=  car5Speed;
				}
				if (this.x < 232)
				{
					car5Speed = 1;
					this.x +=  car5Speed;
				}
				if (this.x == 232)
				{
					this.x -=  car5Speed;
				}

			}

			if (this.hitTestObject(refM.maincar1))
			{
				refM.light1.carPos = false;
				refM.loser.losingState = true;
				refM.loser2.losingState2 = true;

			}
			if (this.hitTestObject(refM.car6b))
			{
				this.x -=  car5Speed;

			}
			
		}

	}

}