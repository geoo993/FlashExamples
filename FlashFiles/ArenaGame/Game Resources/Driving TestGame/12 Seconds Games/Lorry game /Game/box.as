package 
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class box extends MovieClip
	{

		var refM:MovieClip;

		public function box()
		{
			this.addEventListener(Event.ENTER_FRAME,gLoop);
			refM = MovieClip(this.parent);
		}
		
		//var canDo : Boolean = true;
		
		function gLoop(myEvent:Event):void
		{
			//if(1+1 == 2 && canDo == true)
//			{
//				trace("HELLO!!!" + this.name);
//				canDo = false;
//			}
			
			if (this.hitTestObject(refM.lorry1.dec1))
			{
				refM.loser.losingState = "onScreen";
				refM.playagain.restartState = true;
				refM.box1.text3.alpha = 0;
				refM.box1.text2.alpha = 0;
				refM.lorry1.counter = 0;
				refM.lorry1.speeed = 0;
				refM.lorry1.steering = 0;
				refM.lorry1.speedMax = 0;
				refM.lorry1.speedMaxReverse = 0;
				refM.lorry1.lorryState = false;
				
			}
			if (this.hitTestObject(refM.lorry1.dec2))
			{
				refM.loser.losingState = "onScreen";
				refM.playagain.restartState = true;
				refM.box1.text3.alpha = 0;
				refM.box1.text2.alpha = 0;
				refM.lorry1.counter = 0;
				refM.lorry1.speeed = 0;
				refM.lorry1.steering = 0;
				refM.lorry1.speedMaxReverse = 0;
				refM.lorry1.speedMax = 0;
				refM.lorry1.lorryState = false;
			}
			if (this.hitTestObject(refM.lorry1.dec3))
			{
				refM.loser.losingState = "onScreen";
				refM.playagain.restartState = true;
				refM.box1.text3.alpha = 0;
				refM.box1.text2.alpha = 0;
				refM.lorry1.counter = 0;
				refM.lorry1.speeed = 0;
				refM.lorry1.steering = 0;
				refM.lorry1.speedMaxReverse = 0;
				refM.lorry1.speedMax = 0;
				refM.lorry1.lorryState = false;
				
			}
			if (this.hitTestObject(refM.lorry1.dec4))
			{
				refM.loser.losingState = "onScreen";
				refM.playagain.restartState = true;
				refM.box1.text3.alpha = 0;
				refM.box1.text2.alpha = 0;
				refM.lorry1.counter = 0;
				refM.lorry1.speeed = 0;
				refM.lorry1.steering = 0;
				refM.lorry1.speedMaxReverse = 0;
				refM.lorry1.speedMax = 0;
				refM.lorry1.lorryState = false;
				
			}
			if (this.hitTestObject(refM.lorry1.dec5))
			{
				refM.loser.losingState = "onScreen";
				refM.playagain.restartState = true;
				refM.box1.text3.alpha = 0;
				refM.box1.text2.alpha = 0;
				refM.lorry1.counter = 0;
				refM.lorry1.speeed = 0;
				refM.lorry1.steering = 0;
				refM.lorry1.speedMaxReverse = 0;
				refM.lorry1.speedMax = 0;
				refM.lorry1.lorryState = false;
				
			}
			if (this.hitTestObject(refM.lorry1.dec6))
			{
				refM.loser.losingState = "onScreen";
				refM.playagain.restartState = true;
				refM.box1.text3.alpha = 0;
				refM.box1.text2.alpha = 0;
				refM.lorry1.counter = 0;
				refM.lorry1.speeed = 0;
				refM.lorry1.steering = 0;
				refM.lorry1.speedMaxReverse = 0;
				refM.lorry1.speedMax = 0;
				refM.lorry1.lorryState = false;
				
			}
			if (this.hitTestObject(refM.lorry1.dec7))
			{
				refM.loser.losingState = "onScreen";
				refM.playagain.restartState = true;
				refM.box1.text3.alpha = 0;
				refM.box1.text2.alpha = 0;
				refM.lorry1.counter = 0;
				refM.lorry1.speeed = 0;
				refM.lorry1.steering = 0;
				refM.lorry1.speedMaxReverse = 0;
				refM.lorry1.speedMax = 0;
				refM.lorry1.lorryState = false;
				
			}
			if (this.hitTestObject(refM.lorry1.dec8))
			{
				refM.loser.losingState = "onScreen";
				refM.playagain.restartState = true;
				refM.box1.text3.alpha = 0;
				refM.box1.text2.alpha = 0;
				refM.lorry1.counter = 0;
				refM.lorry1.speeed = 0;
				refM.lorry1.steering = 0;
				refM.lorry1.speedMaxReverse = 0;
				refM.lorry1.speedMax = 0;
				refM.lorry1.lorryState = false;
				
			}
			if (this.hitTestObject(refM.lorry1.dec9))
			{
				refM.loser.losingState = "onScreen";
				refM.playagain.restartState = true;
				refM.box1.text3.alpha = 0;
				refM.box1.text2.alpha = 0;
				refM.lorry1.counter = 0;
				refM.lorry1.speeed = 0;
				refM.lorry1.steering = 0;
				refM.lorry1.speedMaxReverse = 0;
				refM.lorry1.speedMax = 0;
				refM.lorry1.lorryState = false;
				
			}
			if (this.hitTestObject(refM.lorry1.dec10))
			{
				refM.loser.losingState = "onScreen";
				refM.playagain.restartState = true;
				refM.box1.text3.alpha = 0;
				refM.box1.text2.alpha = 0;
				refM.lorry1.counter = 0;
				refM.lorry1.speeed = 0;
				refM.lorry1.steering = 0;
				refM.lorry1.speedMaxReverse = 0;
				refM.lorry1.speedMax = 0;
				refM.lorry1.lorryState = false;
			
			}
			

		}
	}

}