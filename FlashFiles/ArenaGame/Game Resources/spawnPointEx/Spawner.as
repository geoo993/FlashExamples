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
		var xDir:Number = 0;
		var yDir:Number = 15;

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
			this.y +=  yDir;
			this.x +=  xDir;

			if (this.hitTestObject(refToM.cp1))
			{
				myRandomNum = Math.random() * 3;
				myRandomNum = Math.round(myRandomNum);

				if (myRandomNum == 0)
				{
					this.y = refToM.sp1.y;
					this.x = refToM.sp1.x;

					yDir =  15;
					xDir =  0;
				}
				if (myRandomNum == 1)
				{
					this.y = refToM.sp2.y;
					this.x = refToM.sp2.x;

					yDir =  0;
					xDir =  -15;
				}
				if (myRandomNum == 2)
				{
					this.y = refToM.sp3.y;
					this.x = refToM.sp3.x;
					
					yDir =  -15;
					xDir =  0;
				}
				if (myRandomNum == 3)
				{
					this.y = refToM.sp4.y;
					this.x = refToM.sp4.x;
					yDir =  0;
					xDir =  15;
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