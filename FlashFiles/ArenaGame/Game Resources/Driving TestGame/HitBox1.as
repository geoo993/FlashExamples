﻿package {	import flash.display.MovieClip;	import flash.events.Event;	public class HitBox1 extends MovieClip	{				var car11:MovieClip;		var refM:MovieClip;			public function HitBox1()		{			stage.addEventListener(Event.ENTER_FRAME,gLoop);						car11 = MovieClip(this.parent);			refM = MovieClip(car11.parent);						refM.hit1Array.push(this);		}		function gLoop(event:Event):void		{			//this.alpha = 0.3;		}	}}