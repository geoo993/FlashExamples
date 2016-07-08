﻿package  {		// import shape, event and various tweening classes	import flash.display.Shape;	import flash.events.Event;	import fl.transitions.Tween;	import fl.transitions.TweenEvent;	import fl.transitions.easing.*;		public class BasicLeaf extends Shape {		// make a tweening variable - tweens often fail if not stored		protected var tween:Tween;		// user must pass a radius, colour and time to tween		public function BasicLeaf(size:int, colour:uint, time:int) {			// draw the circle			graphics.beginFill(colour);			graphics.curveTo(size/2, -size/2, size, 0);			graphics.curveTo(size/2, size/2, 0, 0);			graphics.endFill();			// tween the circle's scale			tween = new Tween(this, "scaleX", Back.easeOut, 0, 1, time);			// add listeners to the tween to update the scaleY and to dispatch an event			tween.addEventListener(TweenEvent.MOTION_CHANGE, update);			tween.addEventListener(TweenEvent.MOTION_FINISH, finish);		}				protected function update(t:TweenEvent):void {			// the scaleX is controlled by the tween. Make scaleY match it			scaleY=scaleX;		}				protected function finish(t:TweenEvent):void {			// dispatch a custom event that we can listen for in the animation(s)			dispatchEvent(new Event("shapeComplete"));		}	}	}