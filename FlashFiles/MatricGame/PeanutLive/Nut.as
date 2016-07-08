package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;


	public class Nut extends MovieClip
	{
		var refM:MovieClip;
		



		public function Nut()
		{
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN,onMyPress);
			this.stage.addEventListener(KeyboardEvent.KEY_UP,onMyRelease);
			this.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, MouseUp);
			this.addEventListener(Event.ENTER_FRAME,gameLoop);

			refM = MovieClip(this.parent);
		}
		
		

		function gameLoop(event:Event):void
		{
			this.x = refM.moverr.x;
			this.y = refM.moverr.y;
			


		}
		public function MouseUp(event:MouseEvent):void
		{
			
		}

		public function MouseDown(event:MouseEvent):void
		{
			
		}
		

		function onMyPress(event:KeyboardEvent):void
		{

			//trace("Key Code Pressed: " + event.keyCode);
			if (event.keyCode == 32)
			{

			}


		}

		function onMyRelease(event:KeyboardEvent):void
		{



		}

	}

}