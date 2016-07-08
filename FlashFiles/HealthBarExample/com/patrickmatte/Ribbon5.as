package {
	
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.Strong;
	
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class Ribbon5 extends MovieClip {
		
		private var points:Array;
		public var brushWidth:Number = 30;
		private var tween:Tween;
		
		public function Ribbon5() {
			super();
			trace("Ribbon5");
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			
			tween = new Tween(this, "brushWidth", Strong.easeInOut, 40, 4, 6, false);
			tween.addEventListener(TweenEvent.MOTION_FINISH, tweenFinishHandler);
		}
		
		private function tweenFinishHandler(event:TweenEvent):void {
			tween.yoyo();
		}
		
		private function mouseDownHandler(event:MouseEvent):void {
			points = new Array();
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function mouseUpHandler(event:MouseEvent):void {
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			//calculatePoints();
		}
		
		private function enterFrameHandler(event:Event):void {
			var point:PointData;
			if (points.length > 0) {
				var prevPoint:PointData = points[points.length - 1] as PointData;
				if (prevPoint.pt.x != mouseX && prevPoint.pt.y != mouseY) {
					point = new PointData(new Point(mouseX, mouseY), 0, new Point(mouseX, mouseY).subtract(points[points.length - 1].pt), new RGBColor(0, 0, 0), brushWidth);
				}
			} else {
				point = new PointData(new Point(mouseX, mouseY), 0, new Point(0, 0), new RGBColor(0, 0, 0), brushWidth);
			}
			if (point) {
				points.push(point);
				calculatePoints();
			}
		}
		
		private function calculatePoints():void {
			var curve1Points:Array = new Array();
			var curve2Points:Array = new Array();
			
			if (points.length > 1) {
				var curve1StartPoint1:PointData = points[0] as PointData;
				var curve1StartPoint2:PointData = points[1] as PointData;
				var curve1StartPointAngle:Point = curve1StartPoint2.pt.subtract(curve1StartPoint1.pt);
				var curve1StartPointRadians:Number = Math.atan2(curve1StartPointAngle.y, curve1StartPointAngle.x);
				var curve1StartPointDegrees:Number = curve1StartPointRadians * 180 / Math.PI;
				
				var curve1StartPointTop:Point = Point.polar(curve1StartPoint2.brushWidth / 2,  (curve1StartPointDegrees + 90) * Math.PI / 180);
				curve1StartPointTop = curve1StartPointTop.add(curve1StartPoint1.pt);
				curve1Points.push(curve1StartPointTop);
				
				var curve1StartPointBottom:Point = Point.polar(curve1StartPoint2.brushWidth / 2,  (curve1StartPointDegrees - 90) * Math.PI / 180);
				curve1StartPointBottom = curve1StartPointBottom.add(curve1StartPoint1.pt);
				curve2Points.push(curve1StartPointBottom);
			}
			/*
			for each(var originalPoint:PointData in points) {
				var circle:MovieClip = new BlackCircle();
				addChild(circle);
				circle.x = originalPoint.pt.x;
				circle.y = originalPoint.pt.y;
			}
			*/
			for (var i:int = 1; i < points.length - 1; i++) {
				var point1:PointData = points[i-1] as PointData;
				var point2:PointData = points[i] as PointData;
				var point3:PointData = points[i+1] as PointData;
				
				var anglePoint1:Point = point2.pt.subtract(point1.pt);
				var radians1:Number = Math.atan2(anglePoint1.y, anglePoint1.x);
				var degrees1:Number = radians1 * 180 / Math.PI;
				
				var anglePoint2:Point = point3.pt.subtract(point2.pt);
				var radians2:Number = Math.atan2(anglePoint2.y, anglePoint2.x);
				var degrees2:Number = radians2 * 180 / Math.PI;
				
				var angle1:Number = (degrees1 + degrees2) / 2;
				
				if (degrees1 < -90 && degrees2 > 90) {
					angle1 -= 270;
				} else {
					angle1 -= 90;
				}
				
				if (degrees2 < -90 && degrees1 > 90) {
					angle1 -= 270;
				} else {
					angle1 -= 90;
				}
				
				angle1 -= 90;
				
				var extraPoint1:Point = Point.polar(point2.brushWidth / 2,  angle1 * Math.PI / 180);
				curve1Points.push(new Point(extraPoint1.x + point2.pt.x, extraPoint1.y + point2.pt.y));
				
				var extraPoint2:Point = Point.polar(point2.brushWidth / 2,  (angle1 + 180) * Math.PI / 180);
				curve2Points.push(new Point(extraPoint2.x + point2.pt.x, extraPoint2.y + point2.pt.y));
				
			}
			if (points.length > 2) {
				var curveEndPoint1:PointData = points[points.length - 2] as PointData;
				var curveEndPoint2:PointData = points[points.length - 1] as PointData;
				var curveEndPointAngle:Point = curveEndPoint2.pt.subtract(curveEndPoint1.pt);
				var curveEndPointRadians:Number = Math.atan2(curveEndPointAngle.y, curveEndPointAngle.x);
				var curve1EndPointDegrees:Number = curveEndPointRadians * 180 / Math.PI;
				
				var curveEndPointTop:Point = Point.polar(brushWidth / 2,  (curve1EndPointDegrees + 90) * Math.PI / 180);
				curveEndPointTop = curveEndPointTop.add(curveEndPoint2.pt);
				curve1Points.push(curveEndPointTop);
				
				var curveEndPointBottom:Point = Point.polar(brushWidth / 2,  (curve1EndPointDegrees - 90) * Math.PI / 180);
				curveEndPointBottom = curveEndPointBottom.add(curveEndPoint2.pt);
				curve2Points.push(curveEndPointBottom);
			}
			/*
			for each(var redPoint:Point in curve1Points) {
				var extraCircle1:MovieClip = new RedCircle();
				extraCircle1.x = redPoint.x;
				extraCircle1.y = redPoint.y;
				addChild(extraCircle1);
			}
			for each(var bluePoint:Point in curve2Points) {
				var extraCircle2:MovieClip = new BlueCircle();
				extraCircle2.x = bluePoint.x;
				extraCircle2.y = bluePoint.y;
				addChild(extraCircle2);
			}
			*/
			drawCurve(curve1Points, curve2Points);
		}
		
		private function drawCurve(points1:Array, points2:Array) {
			this.graphics.clear();
			for (var i:int = 1; i < points.length - 1; i++) {
				this.graphics.beginFill(0x000000, 1);
				
				var curve1StartPoint:Point = points1[i-1] as Point;
				var curve1MiddlePoint:Point = points1[i] as Point;
				var curve1EndPoint:Point = points1[i+1] as Point;
				var curve1Mid1:Point = Point.interpolate(curve1StartPoint, curve1MiddlePoint, 0.5);
				var curve1Mid2:Point = Point.interpolate(curve1MiddlePoint, curve1EndPoint, 0.5);
				
				this.graphics.moveTo(curve1Mid1.x, curve1Mid1.y);
				this.graphics.curveTo(curve1MiddlePoint.x, curve1MiddlePoint.y, curve1Mid2.x, curve1Mid2.y);
				
				var curve2StartPoint:Point = points2[i+1] as Point;
				var curve2MiddlePoint:Point = points2[i] as Point;
				var curve2EndPoint:Point = points2[i-1] as Point;
				var curve2Mid2:Point = Point.interpolate(curve2StartPoint, curve2MiddlePoint, 0.5);
				var curve2Mid1:Point = Point.interpolate(curve2MiddlePoint, curve2EndPoint, 0.5);
				
				this.graphics.lineTo(curve2Mid2.x, curve2Mid2.y);
				this.graphics.curveTo(curve2MiddlePoint.x, curve2MiddlePoint.y, curve2Mid1.x, curve2Mid1.y);
				
				this.graphics.lineTo(curve1Mid1.x, curve1Mid1.y);
				
				this.graphics.endFill();
			}
			
		}
		
	}
	
}
