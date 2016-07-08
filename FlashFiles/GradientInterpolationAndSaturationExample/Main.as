package
{
    import flash.display.*
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.text.*;
	import fl.motion.*;
	import fl.transitions.*;
	import fl.transitions.easing.*;
    
    public class Main extends Sprite
    {
		
		public var Transitions:ColorTransform = new ColorTransform  ;
		public var color:Color = new Color();
		
		public var wi:int = 1000 //stage.stageWidth; 
		public var he:int = 600 //stage.stageHeight;
		
		public var bgArray:Array = new Array ();
        public var bg:Sprite = new Sprite();
		public var s:Sprite = new Sprite();
		
		public var tween:Tween;
		public var trans:Number;
		public var ranColourNum:int = 0;
		
		public var tweenColor1:uint = 0xFFFFFF;
		public var tweenColor2:uint = 0xFFFFFF;
		
		public var startColor:uint = Math.random()*0xFFFFFF;
		public var endColor:uint = Math.random()*0xFFFFFF;
		
		public var lightMaroonRed:uint = 0xF5CCE0;
		public var darkMaroonRed:uint = 0xA30052;
		
		public var lightLimeGreen:uint = 0xC6E3B9;
		public var darkLimeGreen:uint = 0x2E7210;
		
		public var lightOceanBlue:uint = 0xD5E0FB;
		public var darkOceanBlue:uint = 0x1E47A5;
		
		public var lightGrape:uint = 0xDFDEE6;
		public var darkGrape:uint = 0x4B4866;
		
		public var lightPurpleIris:uint = 0xDDD1E5;
		public var darkPurpleIris:uint = 0x571B7E;
		
		public var lightCantaloupe:uint = 0xFFEDD5;
		public var darkCantaloupe:uint = 0x99641C;
		
		public var lightMoccasin:uint = 0xFFEDD5;
		public var darkMoccasin:uint = 0x68602E;
		
		public var lightVgreen:uint = 0xD5DCB2;
		public var darkVgreen:uint = 0x506200;
		
		public var lightMagenta:uint = 0xFFCCFF;
		public var darkMagenta:uint = 0xB200B2;
		
		public var lightGold:uint = 0xFEF1B9;
		public var darkGold:uint = 0xB19210;
		public var colorTransition:ColorTransform = new ColorTransform  ;
		
        public function Main()
        {
			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(MouseEvent.CLICK, MouseGenerator); 
			
			ranColourNum = Math.round(Math.random() * 9);
			randColor();
			//normalShape() ;
			gradientShape();
			//addChild(new Background());
			
        }
		public function gL(myEvent:Event):void
		{  
			//trace(tween.time+"  "+trans+"  "+bgArray.length)
			//trace(ranColourNum)

		}
		public function MouseGenerator(m:MouseEvent) 
		{  
			//while (numChildren>0) removeChildAt(0); 
			//bgArray.length = 0;
			//bgArray.splice(0);
			//trans = 0;
			//ranColourNum = Math.round(Math.random() * 9);
			//randColor();
			//gradientShape();
		
		}
		public function randColor()
		{
			if(ranColourNum == 0)
			{
				startColor = lightOceanBlue;
				endColor = darkOceanBlue;
			}
			if(ranColourNum == 1)
			{
				startColor = lightLimeGreen;
				endColor = darkLimeGreen;
			}
			if(ranColourNum == 2)
			{
				startColor = lightMaroonRed;
				endColor = darkMaroonRed;
			}
			if(ranColourNum == 3)
			{
				startColor = lightPurpleIris;
				endColor = darkPurpleIris;
			}
			if(ranColourNum == 4)
			{
				startColor = lightCantaloupe;
				endColor = darkCantaloupe;
			}
			if(ranColourNum == 5)
			{
				startColor = lightGrape;
				endColor = darkGrape;
			}
			if(ranColourNum == 6)
			{
				startColor = lightMoccasin;
				endColor = darkMoccasin;
			}
			if(ranColourNum == 7)
			{
				startColor = lightVgreen;
				endColor = darkVgreen;
			}
			if(ranColourNum == 8)
			{
				startColor = lightMagenta;
				endColor = darkMagenta;
			}
			if(ranColourNum == 9)
			{
				startColor = lightGold;
				endColor = darkGold;
			}
		}
        private function scaleColor(color:uint, scale:Number):uint
        {
            var r:int = (color & 0xFF0000) >> 16;
            var g:int = (color & 0x00FF00) >> 8;
            var b:int = color & 0x0000FF;
            r += (255 * scale)*(r/(r+g+b)); r = (r > 255) ? 255 : r; r = (r < 0) ? 0 : r;
            g += (255 * scale)*(g/(r+g+b)); g = (g > 255) ? 255 : g; g = (g < 0) ? 0 : g;
            b += (255 * scale)*(b/(r+g+b)); b = (b > 255) ? 255 : b; b = (b < 0) ? 0 : b;
            return (r << 16 & 0xff0000) + (g << 8 & 0x00ff00) + (b & 0x0000ff);
        }
        
        private function labelText(str:String, x:int, y:int):void
        {
            var tf:TextField = new TextField();
            tf.text = str; tf.x = x; tf.y = y; tf.autoSize = "left";
            tf.setTextFormat(new TextFormat("verdana", 20));
            addChild(tf);
        }
		function adjustColors(mc:Sprite):void
		{
			var colorFilter:AdjustColor = new AdjustColor();
			var mColorMatrix:ColorMatrixFilter;
			var mMatrix:Array = [];
			
			colorFilter.hue = 60;
			colorFilter.saturation = 60;
			colorFilter.brightness = 60;
			colorFilter.contrast = 40;
		 
			mMatrix = colorFilter.CalculateFinalFlatArray();
			mColorMatrix = new ColorMatrixFilter(mMatrix);
		 
			mc.filters = [mColorMatrix];
		}
		public function normalShape() 
		{
			s.graphics.clear();
			s.graphics.beginFill(scaleColor(Math.random()*0xffffff,.6), 1);
			s.graphics.drawRect(0, 0, wi, he);
			s.graphics.endFill();
			addChild(s);
			
			labelText("Flat Background Color", wi/2, he/2);
			//adjustColors(s)
		}
		function gradientShape() 
		{
			var colours = [color,0xffffff] 
			var alphas = [ 1, .1 ]; 
			var ratios = [ 0, 200 ]; 
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(wi, he, Math.PI);
			
			bg.graphics.clear();
			bg.graphics.beginGradientFill(GradientType.LINEAR, colours, alphas, ratios, matrix);
			bg.graphics.drawRect(0,0,wi,he);
			bg.graphics.endFill();
			addChild(bg);
			bgArray.push(bg);
			
			labelText("Gradient Background Color", wi/2, he/2);
			//adjustColors(bg)
			tweenMe();
		}
		function tweenMe(t:TweenEvent=null):void 
		{
			startColor = endColor;
			endColor = Math.random()*0xffffff;
			
			tween = new Tween(this, "trans", Regular.easeInOut, 0, 1, 255);
			tween.addEventListener(TweenEvent.MOTION_CHANGE, update);
			tween.addEventListener(TweenEvent.MOTION_FINISH, tweenMe);
		}
		
		function update(t:TweenEvent):void 
		{  
			Transitions.color = Color.interpolateColor(startColor, endColor, trans);
			
			color.setTint(Transitions.color, .5);
			transform.colorTransform = color;
			
		}
		
    }
}