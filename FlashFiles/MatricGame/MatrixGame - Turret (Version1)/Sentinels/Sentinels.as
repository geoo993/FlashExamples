﻿package {	import flash.events.*;	import flash.display.*;	import flash.geom.*;	public class Sentinels extends MovieClip	{		public var refM:MovieClip;		public var thisCount:Number = 0;		var myColorTransform2 = new ColorTransform  ;		public function Sentinels()		{			this.addEventListener(Event.ENTER_FRAME,gameLoop);			refM = MovieClip(this.parent);			refM.sentArray.push(this);			refM.tempp = this;		}		function gameLoop(myEvent:Event):void		{						for (var a:uint = 0; a < refM.sentArray.length; a += 1)				{					if (refM.electTarget.hitTestObject(refM.sentArray[a]))					{						refM.explosion2(refM.tempp2);						refM.sentArray[a].x = Math.random() * 500;						refM.sentArray[a].y = Math.random() * 400;						myColorTransform2.color = Math.random() * 0xFFFFFF;						refM.sentArray[a].transform.colorTransform = myColorTransform2;					}				}			for (var e:uint = 0; e < refM._bullets.length; e += 1)			{				for (var s:uint = 0; s < refM.sentArray.length; s += 1)				{					if (refM._bullets[e].hitTestObject(refM.sentArray[s]))					{												refM.target_mc.x = refM.sentArray[s].x;						refM.target_mc.y = refM.sentArray[s].y;												myColorTransform2.color = Math.random() * 0xFFFFFF;						refM.sentArray[s].transform.colorTransform = myColorTransform2;												refM.sentArray[s].x = Math.random() * 500;						refM.sentArray[s].y = Math.random() * 400;						refM.explosion(refM.tempp);											}								}			}		}	}}