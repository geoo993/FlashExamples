package 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.display.MovieClip;

	public class Spawner extends MovieClip
	{
		var refToM:MovieClip;
		var statee:String;

		var myRandomNum:Number = 0;

		public function Spawner()
		{
			// constructor code
			trace("in constructor");
			this.addEventListener(Event.ENTER_FRAME, gameLoop);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, kDown);

			refToM = MovieClip(this.parent);
			statee = "idle";

			


		}


		function gameLoop(myEvent:Event):void
		{


			this.y +=  15;


			if (this.y > 400)
			{


				myRandomNum = Math.random() * 3;
				myRandomNum = Math.round(myRandomNum);
				//trace(myRandomNum);

				if (myRandomNum == 0)
				{
					this.y = refToM.sp1.y;
					this.x = refToM.sp1.x;
				}
				if (myRandomNum == 1)
				{
					this.y = refToM.sp2.y;
					this.x = refToM.sp2.x;
				}
				if (myRandomNum == 2)
				{
					this.y = refToM.sp3.y;
					this.x = refToM.sp3.x;
				}
				if (myRandomNum == 3)
				{
					this.y = refToM.sp4.y;
					this.x = refToM.sp4.x;
				}


			}




		}

		function mDown(myEvent:MouseEvent):void
		{

			//trace("mouse down");
			//this.startDrag();

		}
		function mUp(myEvent:MouseEvent):void
		{

			//trace("mouse up");
			//this.stopDrag();

		}

		function kDown(myEvent:KeyboardEvent):void
		{


		}
	}

}