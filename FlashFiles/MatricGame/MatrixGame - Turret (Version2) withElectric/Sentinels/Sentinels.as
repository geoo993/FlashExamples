package 
{
	import flash.events.*;
	import flash.display.*;
	import flash.geom.*;


	public class Sentinels extends MovieClip
	{
		public var refM:MovieClip;

		public var thisCount:Number = 0;
		public var sentSpeed:Number = .1;
		public var sentstate:Boolean = false;
		public var sentColourState:Boolean = false;
		public var myColorTransform2 = new ColorTransform  ;

		public function Sentinels()
		{
			this.addEventListener(Event.ENTER_FRAME,gameLoop);

			refM = MovieClip(this.parent);
			refM.sentArray.push(this);
			refM.tempp = this;
		}

		function gameLoop(myEvent:Event):void
		{
			//if (sentstate == true)
			//{
			//thisCount +=  1;
			//}

			if (sentColourState == false)
			{
				for (var n:uint = 0; n < refM.sentArray.length; n += 1)
				{
					myColorTransform2.color = Math.random() * 0xFFFFFF;
					refM.sentArray[n].transform.colorTransform = myColorTransform2;

					refM.sentArray[n].x = Math.random() * 500;
					refM.sentArray[n].y = Math.random() * 400;
					sentColourState = true;
				}
			}
			for (var i:uint = 0; i < refM.sentArray.length; i += 1)
			{
				if (sentstate == false)
				{
					refM.sentArray[i].y +=  sentSpeed;
				}

			}

			for (var j:uint = 0; j < refM.sentArray.length; j += 1)
			{
				if (refM.sentArray[j].hitTestObject(refM.baseLine))
				{
					refM.basse.width -=  20;

					refM.sentArray[j].x = Math.random() * 500;
					refM.sentArray[j].y = Math.random() * 400;
					sentstate = false;

					myColorTransform2.color = Math.random() * 0xFFFFFF;
					refM.sentArray[j].transform.colorTransform = myColorTransform2;
				}

			}
			for (var m:uint = 0; m < refM.sentArray.length; m += 1)
			{
				if (refM.sentArray[m].hitTestObject(refM.Lazer))
				{
					refM.sentArray[m].x = Math.random() * 500;
					refM.sentArray[m].y = Math.random() * 400;
					sentstate = false;

					myColorTransform2.color = Math.random() * 0xFFFFFF;
					refM.sentArray[m].transform.colorTransform = myColorTransform2;
				}
			}


			for (var a:uint = 0; a < refM.sentArray.length; a += 1)
			{
				if (refM.electTarget.hitTestObject(refM.sentArray[a]))
				{
					refM.explosion2(refM.tempp2);
					refM.sentArray[a].x = Math.random() * 500;
					refM.sentArray[a].y = Math.random() * 400;
					sentstate = false;

					//myColorTransform2.color = Math.random() * 0xFFFFFF;
					//refM.sentArray[a].transform.colorTransform = myColorTransform2;
				}
			}


			for (var s:uint = 0; s < refM.sentArray.length; s += 1)
			{
				for (var e:uint = 0; e < refM.bulletsArray.length; e += 1)
				{
					if (refM.bulletsArray[e].hitTestObject(refM.sentArray[s]))
					{

						refM.target_mc.x = refM.sentArray[s].x;
						refM.target_mc.y = refM.sentArray[s].y;

						myColorTransform2.color = Math.random() * 0xFFFFFF;
						refM.sentArray[s].transform.colorTransform = myColorTransform2;

						refM.sentArray[s].x = Math.random() * 500;
						refM.sentArray[s].y = Math.random() * 400;
						sentstate = false;

						if (sentstate == true)
						{
							refM.sentArray[s].y -=  sentSpeed;
						}
						refM.explosion(refM.tempp);

					}

				}

			}


		}



	}

}