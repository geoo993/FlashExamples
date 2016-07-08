package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;	import flash.geom.*;
	import fl.motion.Color;
	
		public class Main extends MovieClip
	{
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		public var color1:uint;
		public var color2:uint;
		
		public var canvas:BitmapData = new BitmapData(stage.stageWidth,stage.stageHeight,false, 0x000000);
		
		public var p0:Sprite;
		public var p1:Sprite;
		public var p2:Sprite;
		public var p3:Sprite;
				public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gloop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
			 
			p0 = dot(100, 100);
			p1 = dot(120, 180);
			p2 = dot(220, 180);
			p3 = dot(250, 250);
			
		}
				public function gloop(myEvent:Event):void		{
			//backgroundColorTransition();
			
			addChild(new Bitmap(canvas));
			canvas.lock();  
			canvas.fillRect(canvas.rect, 0x000000);
			
			curve(p0, p1, p2, p3);
			canvas.unlock();
		}
		
		public function curve(p0:Sprite, p1:Sprite, p2:Sprite, p3:Sprite, rez:Number=.02):void
		{
			var px:Number = 0;
			var py:Number = 0;
			var m0:Point = tangent(p1, p0);
			var m1:Point = tangent(p2, p0);
			var m2:Point = tangent(p3, p1);
			var m3:Point = tangent(p3, p2);
		   
			for (var t:Number = 0; t <1; t+=rez)
			{
				 var t_2:Number = t * t;
				 var _1_t:Number = 1 - t;
				 var _2t:Number = 2 * t;
				 
				 var h00:Number =  (1 + _2t) * (_1_t) * (_1_t);
				 var h10:Number =  t  * (_1_t) * (_1_t);
				 var h01:Number =  t_2 * (3 - _2t);
				 var h11:Number =  t_2 * (t - 1);
				 
				 px = h00 * p0.x + h10 * m0.x + h01 * p1.x + h11 * m1.x;
				 py = h00 * p0.y + h10 * m0.y + h01 * p1.y + h11 * m1.y;
				 canvas.setPixel(px, py, 0xFFFFFF);
				 
				 px = h00 * p1.x + h10 * m1.x + h01 * p2.x + h11 * m2.x;
				 py = h00 * p1.y + h10 * m1.y + h01 * p2.y + h11 * m2.y;
				 canvas.setPixel(px, py, 0xFFFFFF);
				 
				 px = h00 * p2.x + h10 * m2.x + h01 * p3.x + h11 * m3.x;
				 py = h00 * p2.y + h10 * m2.y + h01 * p3.y + h11 * m3.y;
				 canvas.setPixel(px, py, 0xFFFFFF);
			}
		}
		 
		public function tangent(pk1:Sprite, pk_1:Sprite)
		{
			return new Point((pk1.x - pk_1.x) / 2, (pk1.y - pk_1.y) / 2);
		}
		 
		// draggable dot
		public function dot(xp:Number, yp:Number):Sprite 
		{
			var s:Sprite = Sprite(addChild(new Sprite));
			s.x = xp;
			s.y = yp;
			with(s.graphics) beginFill(0x507399,1), drawCircle(0,0,5);
			s.buttonMode = true;
			s.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
			return s;
		}
		public function onDrag(evt:MouseEvent):void 
		{
			evt.currentTarget.startDrag()
		}
		
		public function onUp(evt:MouseEvent):void
		{
			stopDrag();
		}
		
		public function backgroundColorTransition()
		{
			
			if(colorTransSwitch == "goingUp")
			{
				colorTransNum += 1;
			}
			if(colorTransSwitch == "goingDown")
			{
				colorTransNum -= 1; 
			}
			if(curVal <= 0)
			{   
				colorTransSwitch = "goingUp";
				color2 = Math.random() * 0xFFFFFF;
				
			}
			if(curVal >= 1)
			{
				color1 = Math.random() * 0xFFFFFF;
				colorTransSwitch = "goingDown";
			}
			
			curVal = colorTransNum/255;
			stage.color = Color.interpolateColor(color1,color2,curVal);
			
		}
		
		public function kDown(event:KeyboardEvent):void
		{
			if (event.keyCode == 32)
			{   
				
			}
		}
			}}