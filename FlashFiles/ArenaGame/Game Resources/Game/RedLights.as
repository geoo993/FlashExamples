﻿package  {		import flash.display.MovieClip;	import flash.events.Event;			public class RedLights extends MovieClip 	{		var refM:MovieClip;				public function RedLights() 		{			this.addEventListener(Event.ENTER_FRAME,gLoop);			this.stop();			refM = MovieClip(this.parent);		}		function gLoop(event:Event):void		{						if (refM.maincar1.y < 135)			{				this.gotoAndStop(3)			}			if (refM.maincar1.y < 500 && refM.maincar1.y > 135)			{				this.gotoAndStop(2)			}			if (refM.maincar1.y > 500)			{				this.gotoAndStop(2)			}					}	}	}