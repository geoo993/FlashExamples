﻿package {	import flash.display.MovieClip;	import flash.events.Event;	public class CarOneHitBox extends MovieClip	{				public var cOne:MovieClip;		public var refM:MovieClip;			public function CarOneHitBox()		{			stage.addEventListener(Event.ENTER_FRAME,gLoop);						cOne = MovieClip(this.parent);			refM = MovieClip(cOne.parent);						refM.HitBoxesArray.push(this);		}		function gLoop(event:Event):void		{			this.alpha = 0;					}	}}