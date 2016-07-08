package 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;


	public class Player extends MovieClip
	{
		var mRef:MovieClip;
		
		var playerOne:Boolean = false;

		public function Player()
		{
			stage.addEventListener(Event.ENTER_FRAME,gameLoop);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,mDown);
			this.addEventListener(MouseEvent.MOUSE_OVER,mOver);
			mRef = MovieClip(this.parent);

		}

		function gameLoop(event:Event):void
		{
			if (playerOne == false)
			{
				mRef.player2.playerTwo = false;
			}
		}


		function mOver(event:MouseEvent):void
		{
			this.startDrag();


		}
		function mDown(myEvent:MouseEvent):void
		{

			this.stopDrag();

		}

		

	}

}