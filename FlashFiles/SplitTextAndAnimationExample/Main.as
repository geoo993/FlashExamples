package {	import flash.display.*;	import flash.events.*;	import flash.geom.*;	import flash.text.*;	import com.greensock.*;	import com.greensock.text.*;
	import com.greensock.easing.*;	public class Main extends MovieClip	{				public var myFormat:TextFormat = new TextFormat				public function Main()		{			stage.addEventListener(Event.ENTER_FRAME,gL);		}		public function gL(myEvent:Event):void		{			//part1
			var sstf:SplitTextField = new SplitTextField(sText);			//TweenMax.to(sstf.textFields[10], 0.5, {alpha:0, delay:1});
						//TweenMax.allFrom(sstf.textFields, 0.5, {rotationX:90, alpha:0}, 0.1);
			TweenMax.staggerFromTo(sstf.textFields, 0.2, {alpha:0}, {alpha:1}, 0.1 );
			
			//part2		    //var sstf2:SplitTextField = new SplitTextField(sText, "words");
			//TweenMax.allFrom(sstf2.textFields, .5, {rotationX:120, y:"90", alpha:0, delay:.5}, 0.1);
			//TweenMax.staggerFromTo(sstf2.textFields, 0.2, {alpha:0}, {alpha:1}, 0.1 );
			
			
			//part3
			 // var sstf3:SplitTextField = new SplitTextField(sText, "lines");
			//TweenMax.allFrom(sstf3.textFields, .8, {x:"200", alpha:0, delay:1.5, ease:Cubic.easeInOut}, 0.1);
			//TweenMax.staggerFromTo(sstf3.textFields, 0.2, {alpha:0}, {alpha:1}, 0.1 );
			
			
			
			
			//TweenNano.to(sText,2,{alpha:.5});		}	}}