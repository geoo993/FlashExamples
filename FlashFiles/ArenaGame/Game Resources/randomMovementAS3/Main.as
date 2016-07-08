package 
{

	import flash.display.MovieClip;

	public class Main extends MovieClip
	{

		public function Main()
		{
			PopulateCircles();
		}

		private function PopulateCircles():void
		{
			for (var i:int=0; i < 50; i++)
			{
				var blueCircle:BlueCircle = new BlueCircle();

				this.addChild(blueCircle);
			}
		}
	}

}