﻿package  {		import flash.display.Sprite;	import flash.events.Event;			public class Controller extends Sprite {				private var classes:Array; // possible animations in the chain		private var animations:Array; // could use a Vector.<BasicAnimation>		private var lastAnimation:BasicAnimation;		private const GRACE_PERIOD = 6;				public function Controller() {			addEventListener(Event.ADDED_TO_STAGE, begin);		}				private function begin(e:Event):void {			// put all possible animation classes into the classes list			classes = [ FlowerAnimation2, FlowerAnimation, LineAnimation ];			animations = new Array();			// start animation!			nextAnimation();			// start tracking the animation			addEventListener(Event.ENTER_FRAME, focus);		}				private function focus(e:Event):void {			// zoom to the position of the current animation - smoothly			x += (-lastAnimation.x-lastAnimation.end.x-x)*0.1;			y += (-lastAnimation.y-lastAnimation.end.y-y)*0.1;			// fade out the old animations			for (var i:int = animations.length-1-GRACE_PERIOD; i>=0; i--) {				animations[i].alpha-=0.02; // 2% each frame				if (animations[i].alpha<=0) {					removeChild(animations[i]);					animations.splice(i, 1);				}			}		}				private function nextAnimation(e:Event=null):void {			// randomly select an animation			var index:int = Math.random()*classes.length;			var animation:BasicAnimation = new classes[index]();			// position it			if (lastAnimation!=null) {				animation.x = lastAnimation.x + lastAnimation.end.x;				animation.y = lastAnimation.y + lastAnimation.end.y;			}			// add it to the screen and wait for it to finish			addChild(animation);			animation.addEventListener("animationComplete", nextAnimation);			// add it to the animations list and make it the lastAnimation			animations.push(animation);			lastAnimation = animation;		}	}	}