package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import com.senocular.drawing.Path;
	import flash.utils.*;
	
	/**
 	 * @author Matt Przybylski [http://www.reintroducing.com]
 	 * @version 1.0
 	 */
	public class Main extends Sprite
	{
		
		public var point:Point = new Point();
		public var localPoint:Point = new Point();
		
		public var DistPercentage:Number = .01;
		public var ballSpeed:Number = .01;
		
		public var curvePath:Path = new Path();
		public var curve:Sprite = new Sprite();
		public var s:Sprite = new Sprite();
		
		public var textt:TextField = new TextField();
		public var mType:String = "onMouse";
		
		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			drawCurve();
		}
		public function gL(myEvt:Event):void
		{ 
			if(mType == "onLoop")
			{
				DistPercentage += ballSpeed;
				point = curvePath.pointAt(DistPercentage);
				
				s.x = point.x;
				s.y = point.y;
				
				if(DistPercentage >.9888)
				{
					ballSpeed *= -1;
					//DistPercentage = 0;
				}
				if(DistPercentage<0.01)
				{
					ballSpeed *= -1;
				}
			}
            textFiel()
		}
		public function textFiel()
		{
			var nextLine:String = "\n"
			textt.text = String("PERCENT:  "+Math.round(DistPercentage * 100)+"%"+nextLine+"POINT:  "+ point+nextLine+"MOVETYPE:  "+mType);
			
		}
		public function drawCurve():void
		{
			curve.graphics.lineStyle(2, Math.random()*0xFFFF00, 1);
			curve.x = curve.y = 200;
			
			curvePath.moveTo(0, 0);
			curvePath.curveTo(400, 200, 800, 0);
			curvePath.draw(curve.graphics);
			
			s.graphics.beginFill(Math.random()*0xFFFFFF, 1);
			s.graphics.drawCircle(0, 0, 10);
			s.graphics.endFill();
			s.buttonMode = true;
			
			s.addEventListener(MouseEvent.MOUSE_DOWN, mPressed);
			s.addEventListener(MouseEvent.MOUSE_UP, mRelease);
			
			curve.addChild(s);
			addChild(curve);
			
			textt.width = 800;
			textt.x = 100;
			textt.y = 400;
			addChild(textt);
		}
		
		public function mPressed(evt:MouseEvent):void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, mRelease);
		}
		
		public function mMove(evt:MouseEvent):void
		{
			if(mType == "onMouse")
			{
				localPoint = curve.globalToLocal(new Point(evt.stageX, evt.stageY));
				DistPercentage = (localPoint.x / curvePath.length);
				point = curvePath.pointAt(DistPercentage);
				
				if ((localPoint.x >= 0) && (localPoint.x <= curvePath.length))
				{
					s.x = point.x;
					s.y = point.y;
				}
			}
			evt.updateAfterEvent();
		}
		public function mRelease(evt:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mRelease);
		}
		public function kDown(event:KeyboardEvent):void
		{  
			if (event.keyCode == 32)
			{
				if(mType == "onMouse")
				{
					mType = "onLoop";
				}
				else if(mType == "onLoop")
				{
					mType = "onMouse";
				}
			}
		}
		
	}
}