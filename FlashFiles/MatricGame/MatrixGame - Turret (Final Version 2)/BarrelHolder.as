﻿package {	import flash.events.*;	import flash.display.*;	import flash.geom.*;	public class BarrelHolder extends MovieClip	{		public var refM:MovieClip;		var myColorTransform3 = new ColorTransform  ;		public function BarrelHolder()		{			this.addEventListener(Event.ENTER_FRAME,gameLoop);			refM = MovieClip(this.parent);			refM.baseArray.push(this);		}		function gameLoop(myEvent:Event):void		{					}	}}