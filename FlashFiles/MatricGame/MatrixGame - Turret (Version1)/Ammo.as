package 
{
	import flash.events.*;
	import flash.display.*;
	import flash.geom.*;


	public class Ammo extends MovieClip
	{
		public var refM:MovieClip;

		public var ammoCount:Number = 0;
		public var ammoState:Boolean = false;

		public var ammoColorTransform = new ColorTransform  ;

		public function Ammo()
		{
			this.addEventListener(Event.ENTER_FRAME,gameLoop);

			refM = MovieClip(this.parent);
			refM.ammoArray.push(this);

		}

		function gameLoop(myEvent:Event):void
		{

			for (var e:uint = 0; e < refM.ammoArray.length; e += 1)
			{
				if (ammoState == true)
				{
					ammoCount = Math.round(Math.random() * 500);

					if (ammoCount == 235 || ammoCount == 195)
					{
						refM.ammoArray[e].x = Math.random() * 500;
						refM.ammoArray[e].y = Math.random() * 300;
						
						//ammoColorTransform.color = Math.random() * 0xFFFFFF;
//						refM.ammoArray[e].transform.colorTransform = ammoColorTransform;
						
						ammoState = false;
					}
					else
					{
						refM.ammoArray[e].x = 5000;
						refM.ammoArray[e].y = 5000;
					}
				}

				if (refM.electTarget.hitTestObject(refM.ammoArray[e]) || refM.mouseTarg.hitTestObject(refM.ammoArray[e]))
				{
					ammoState = true
					refM.t1healthNum +=  10;
					refM.t2healthNum +=  10;
					refM.t3healthNum +=  10;
					refM.t4healthNum +=  10;


				}



			}


		}



	}

}