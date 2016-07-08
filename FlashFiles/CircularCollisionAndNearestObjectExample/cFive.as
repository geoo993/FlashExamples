package  {
	
	import flash.display.MovieClip;
	
	
	public class cFive extends MovieClip 
	{
		
		public var refM:MovieClip;
		
		public function cFive() 
		{
			refM = MovieClip (this.parent);
			refM.myArray.push(this)
		}
	}
	
}
