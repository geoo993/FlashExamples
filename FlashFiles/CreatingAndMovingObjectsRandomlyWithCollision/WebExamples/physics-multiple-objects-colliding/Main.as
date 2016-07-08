/**
 * Simple Physics
 * ---------------------
 * VERSION: 1.1
 * DATE: 07/31/2011
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.FreeActionScript.com
 **/
package 
{
	import flash.display.MovieClip;
	import com.freeactionscript.SimplePhysics;
	
	public class Main extends MovieClip
	{
		// classes
		private var _physics:SimplePhysics
		
		public function Main()
		{
			// SimplePhysics usage: 
			// new SimplePhysics(any_display_object);
			_physics = new SimplePhysics(container); // container is a movieclip on stage
			
			// create balls
			_physics.createBalls(10);
			
			// enable physics simulation
			_physics.enable();
		}
	}
	
}
