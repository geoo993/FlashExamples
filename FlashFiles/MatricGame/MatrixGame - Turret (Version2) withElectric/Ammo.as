﻿package 
{
	import flash.events.*;
	import flash.display.*;
	import flash.geom.*;


	public class Ammo extends MovieClip
	{
		public var refM:MovieClip;

		public var ammoCount:Number = 0;
		public var ammoState:Boolean = false;
		public var ammoTypeState:String = "light";
		public var ammoTypeNum:Number = 0;

		public var ammoColorTransform = new ColorTransform  ;

		public function Ammo()
		{
			this.addEventListener(Event.ENTER_FRAME,gameLoop);

			refM = MovieClip(this.parent);
			refM.ammoArray.push(this);

		}

		function gameLoop(myEvent:Event):void
		{
			refM.ammoArray[0].y += 1;

			for (var e:uint = 0; e < refM.ammoArray.length; e += 1)
			{
				if (ammoState == true)
				{
					ammoCount = Math.round(Math.random() * 500);
					

					if (ammoCount == 235 || ammoCount == 195)
					{
						refM.ammoArray[e].x = Math.random() * 500;
						refM.ammoArray[e].y = Math.random() * 500;


						ammoState = false;
					}
					else
					{
						refM.ammoArray[e].x = 50000;
					}
				}


				if (refM.electTarget.hitTestObject(refM.ammoArray[e]) || refM.mouseTarg.hitTestObject(refM.ammoArray[e]) || refM.baseLine.hitTestObject(refM.ammoArray[e])|| refM.Lazer.hitTestObject(refM.ammoArray[e]))
				{
					ammoState = true;
					
					ammoTypeNum =  Math.round(Math.random() * 10)
					
					if(ammoTypeNum < 7)
					{
						ammoTypeState = "light";
					}
					if(ammoTypeNum >= 7)
					{
						ammoTypeState = "Heavy";
					}
					
					if (ammoTypeState == "light")
					{
						ammoColorTransform.color = 0xFFFF00;
						refM.ammoArray[e].transform.colorTransform = ammoColorTransform;
						refM.t1healthNum +=  10;
						refM.t2healthNum +=  10;
						refM.t3healthNum +=  10;
						refM.t4healthNum +=  10;
						
					}
					else if (ammoTypeState == "Heavy")
					{
						ammoColorTransform.color = 0xF6358A;
						refM.ammoArray[e].transform.colorTransform = ammoColorTransform;
						refM.t1healthNum +=  40;
						refM.t2healthNum +=  40;
						refM.t3healthNum +=  40;
						refM.t4healthNum +=  40;
					}


				}



			}


		}



	}

}