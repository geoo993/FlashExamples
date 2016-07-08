package 
{		import flash.display.*;	import flash.events.*;
	import fl.motion.*;
	import flash.geom.*;
	
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent; 
		public class Main extends MovieClip 
	{
		public var stageW:Number = 1200;
		public var stageH:Number = 700;
		
		protected var tween:Tween;
		public var trans:Number;
		public var startColor:uint;
		public var endColor:uint;
				public function Main() 
		{
			var mat:Matrix = new Matrix();
			mat.createGradientBox(stageW, stageH);
			graphics.clear();
			graphics.beginGradientFill("radial", [ 0x000000, 0x999999], [ 255, 255 ], [ 0, 255 ], mat);
			graphics.drawRect(0, 0, stageW, stageH);
			graphics.endFill();
			
			tweenMe();
			startColor = Math.random()*0xFFFFFF;
			endColor = Math.random()*0xFFFFFF;
		}
		
		private function tweenMe(t:TweenEvent=null):void 
		{
			startColor = endColor;
			endColor = Math.random()*0xFFFFFF;
			
			tween = new Tween(this, "trans", Regular.easeInOut, 0, 1, 100+Math.random()*50);
			tween.addEventListener(TweenEvent.MOTION_CHANGE, update);
			tween.addEventListener(TweenEvent.MOTION_FINISH, tweenMe);
		}
		
		private function update(t:TweenEvent):void 
		{
			var color:Color = new Color();
			color.setTint(Color.interpolateColor(startColor, endColor, trans), 0.5);
			transform.colorTransform = color;
		}
			}}