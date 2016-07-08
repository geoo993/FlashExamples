package 
{

	import flash.display.MovieClip;
	import flash.events.Event;

	public class Player2 extends MovieClip
	{
		
		
		var mRef:MovieClip;
		var speeed:Number = 4;

		var playerTwo:Boolean = false;

		public function Player2()
		{
			// constructor code
			stage.addEventListener(Event.ENTER_FRAME,gameLoop);
			mRef = MovieClip(this.parent);
		}
		function gameLoop(event:Event):void
		{
			this.x +=  speeed;

			if (this.x > 550)
			{
				speeed *=  -1;

			}
			if (this.x < 0)
			{
				speeed *=  -1;

			}

	}

}