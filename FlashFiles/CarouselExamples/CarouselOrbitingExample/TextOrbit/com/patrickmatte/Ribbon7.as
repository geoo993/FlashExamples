package {
	
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.Strong;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;

	public class Ribbon7 extends MovieClip {
		
		public var ink:MovieClip;
		public var brush:Sprite;
		private var points:Array = new Array();
		public var brushWidth:Number = 30;
		private var tween:Tween;
		private var isDrawing:Boolean;
		private var life:Number = 150;
		private var death:Number = 100;
		private var birth:Number = 50;
		private var velocityDivider:Number = 10;
		public var circles:Array;
		private var showDots:Boolean;
		public var showAnchorPoints:TextField;
		
		public function Ribbon7() {
			super();
			trace("Ribbon7");
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			
			brush = this;
			
			tween = new Tween(this, "brushWidth", Strong.easeInOut, 40, 4, 6, false);
			tween.addEventListener(TweenEvent.MOTION_FINISH, tweenFinishHandler);
			
			showAnchorPoints.addEventListener(MouseEvent.CLICK, showAnchorPointsClickHandler);
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function showAnchorPointsClickHandler(event:MouseEvent):void {
			showDots = !showDots;
			if (showDots) {
				showAnchorPoints.text = "Hide Anchor Points";
			} else {
				showAnchorPoints.text = "Show Anchor Points";
			}
		}
		
		private function tweenFinishHandler(event:TweenEvent):void {
			tween.yoyo();
		}
		
		private function mouseDownHandler(event:MouseEvent):void {
			//points = new Array();
			isDrawing = true;
		}
		
		private function mouseUpHandler(event:MouseEvent):void {
			//removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			isDrawing = false;
		}
		
		private function enterFrameHandler(event:Event):void {
			if (isDrawing) {
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
				}
			}
			
			calculatePoints();
		}
		
		private function getBrushWidth(pointData:PointData):Number {
			var brushwidth:Number;
			if (pointData.time < birth) {
				brushwidth = Strong.easeOut(pointData.time, 0, pointData.brushWidth, birth);
			} else if (pointData.time > life - death) {
				brushwidth = Strong.easeIn(death - (life - pointData.time), pointData.brushWidth, -pointData.brushWidth, death);
			} else {
				brushwidth = pointData.brushWidth;
			}
			return brushwidth;
		}
		
		private function calculatePoints():void {
			if (points.length > 0) {
				var firstPoint:PointData = points[0] as PointData;
				if (firstPoint.time > life) {
					points.shift();
				}
			}
			var curve1Points:Array = new Array();
			var curve2Points:Array = new Array();
			
			if (points.length > 1) {
				var curve1StartPoint1:PointData = points[0] as PointData;
				var curve1StartPoint2:PointData = points[1] as PointData;
				var curve1StartPointAngle:Point = curve1StartPoint2.pt.subtract(curve1StartPoint1.pt);
				var curve1StartPointRadians:Number = Math.atan2(curve1StartPointAngle.y, curve1StartPointAngle.x);
				var curve1StartPointDegrees:Number = curve1StartPointRadians * 180 / Math.PI;
				
				curve1StartPoint1.time++;
				
				var curve1StartPointTopPoint:Point = Point.polar(getBrushWidth(curve1StartPoint2) / 2,  (curve1StartPointDegrees + 90) * Math.PI / 180);
				curve1StartPointTopPoint = curve1StartPointTopPoint.add(curve1StartPoint1.pt);
				var curve1StartPointTop:PointData = new PointData(curve1StartPointTopPoint, curve1StartPoint2.time, curve1StartPoint2.vel, curve1StartPoint2.color, curve1StartPoint2.brushWidth);
				curve1Points.push(curve1StartPointTop);
				
				var curve1StartPointBottomPoint:Point = Point.polar(getBrushWidth(curve1StartPoint2) / 2,  (curve1StartPointDegrees - 90) * Math.PI / 180);
				curve1StartPointBottomPoint = curve1StartPointBottomPoint.add(curve1StartPoint1.pt);
				var curve1StartPointBottom:PointData = new PointData(curve1StartPointBottomPoint, curve1StartPoint2.time, curve1StartPoint2.vel, curve1StartPoint2.color, curve1StartPoint2.brushWidth);
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
				
				point2.time++;
				
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
				
				var extraPoint1:Point = Point.polar(getBrushWidth(point2) / 2,  angle1 * Math.PI / 180);
				var curve1Point:Point = new Point(extraPoint1.x + point2.pt.x, extraPoint1.y + point2.pt.y);
				var curve1PointData:PointData = new PointData(curve1Point, point2.time, point2.vel, point2.color, point2.brushWidth);
				curve1Points.push(curve1PointData);
				
				var extraPoint2:Point = Point.polar(getBrushWidth(point2) / 2,  (angle1 + 180) * Math.PI / 180);
				var curve2Point:Point = new Point(extraPoint2.x + point2.pt.x, extraPoint2.y + point2.pt.y);
				var curve2PointData:PointData = new PointData(curve2Point, point2.time, point2.vel, point2.color, point2.brushWidth);
				curve2Points.push(curve2PointData);
				
			}
			if (points.length > 2) {
				var curveEndPoint1:PointData = points[points.length - 2] as PointData;
				var curveEndPoint2:PointData = points[points.length - 1] as PointData;
				var curveEndPointAngle:Point = curveEndPoint2.pt.subtract(curveEndPoint1.pt);
				var curveEndPointRadians:Number = Math.atan2(curveEndPointAngle.y, curveEndPointAngle.x);
				var curve1EndPointDegrees:Number = curveEndPointRadians * 180 / Math.PI;
				
				curveEndPoint2.time++;
				
				var curveEndPointTopPoint:Point = Point.polar(getBrushWidth(curveEndPoint2) / 2,  (curve1EndPointDegrees + 90) * Math.PI / 180);
				curveEndPointTopPoint = curveEndPointTopPoint.add(curveEndPoint2.pt);
				var curveEndPointTop:PointData = new PointData(curveEndPointTopPoint, curveEndPoint2.time, curveEndPoint2.vel, curveEndPoint2.color, curveEndPoint2.brushWidth);
				curve1Points.push(curveEndPointTop);
				
				var curveEndPointBottomPoint:Point = Point.polar(getBrushWidth(curveEndPoint2) / 2,  (curve1EndPointDegrees - 90) * Math.PI / 180);
				curveEndPointBottomPoint = curveEndPointBottomPoint.add(curveEndPoint2.pt);
				var curveEndPointBottom:PointData = new PointData(curveEndPointBottomPoint, curveEndPoint2.time, curveEndPoint2.vel, curveEndPoint2.color, curveEndPoint2.brushWidth);
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
			brush.graphics.clear();
			for each(var oldCircle:MovieClip in circles) {
				removeChild(oldCircle);
			}
			circles = new Array();
			for (var i:int = 1; i < points.length - 1; i++) {
				brush.graphics.beginFill(0x000000, 1);
				
				var curve1StartData:PointData = points1[i-1] as PointData;
				var curve1MiddleData:PointData = points1[i] as PointData;
				var curve1EndData:PointData = points1[i+1] as PointData;
				
				//var curve1StartPoint:Point = curve1StartData.pt;
				//var curve1MiddlePoint:Point = curve1MiddleData.pt;
				//var curve1EndPoint:Point = curve1EndData.pt;
				
				var curve1StartPoint:Point = new Point(curve1StartData.pt.x + curve1StartData.vel.x / velocityDivider * curve1StartData.time, curve1StartData.pt.y + curve1StartData.vel.y / velocityDivider * curve1StartData.time);
				var curve1MiddlePoint:Point = new Point(curve1MiddleData.pt.x + curve1MiddleData.vel.x / velocityDivider * curve1MiddleData.time, curve1MiddleData.pt.y + curve1MiddleData.vel.y / velocityDivider * curve1MiddleData.time);
				var curve1EndPoint:Point = new Point(curve1EndData.pt.x + curve1EndData.vel.x / velocityDivider * curve1EndData.time, curve1EndData.pt.y + curve1EndData.vel.y / velocityDivider * curve1EndData.time);
				
				var curve1Mid1:Point = Point.interpolate(curve1StartPoint, curve1MiddlePoint, 0.5);
				var curve1Mid2:Point = Point.interpolate(curve1MiddlePoint, curve1EndPoint, 0.5);
				
				brush.graphics.moveTo(curve1Mid1.x, curve1Mid1.y);
				brush.graphics.curveTo(curve1MiddlePoint.x, curve1MiddlePoint.y, curve1Mid2.x, curve1Mid2.y);
				
				var curve2StartData:PointData = points2[i+1] as PointData;
				var curve2MiddleData:PointData = points2[i] as PointData;
				var curve2EndData:PointData = points2[i-1] as PointData;
				
				//var curve2StartPoint:Point = curve2StartData.pt;
				//var curve2MiddlePoint:Point = curve2MiddleData.pt;
				//var curve2EndPoint:Point = curve2EndData.pt;
				
				var curve2StartPoint:Point = new Point(curve2StartData.pt.x + curve2StartData.vel.x / velocityDivider * curve2StartData.time, curve2StartData.pt.y + curve2StartData.vel.y / velocityDivider * curve2StartData.time);
				var curve2MiddlePoint:Point = new Point(curve2MiddleData.pt.x + curve2MiddleData.vel.x / velocityDivider * curve2MiddleData.time, curve2MiddleData.pt.y + curve2MiddleData.vel.y / velocityDivider * curve2MiddleData.time);
				var curve2EndPoint:Point = new Point(curve2EndData.pt.x + curve2EndData.vel.x / velocityDivider * curve2EndData.time, curve2EndData.pt.y + curve2EndData.vel.y / velocityDivider * curve2EndData.time);

				var curve2Mid2:Point = Point.interpolate(curve2StartPoint, curve2MiddlePoint, 0.5);
				var curve2Mid1:Point = Point.interpolate(curve2MiddlePoint, curve2EndPoint, 0.5);
				
				brush.graphics.lineTo(curve2Mid2.x, curve2Mid2.y);
				brush.graphics.curveTo(curve2MiddlePoint.x, curve2MiddlePoint.y, curve2Mid1.x, curve2Mid1.y);
				
				brush.graphics.lineTo(curve1Mid1.x, curve1Mid1.y);
				
				brush.graphics.endFill();
				
				if (showDots) {
				
					var extraCircle1:MovieClip = new RedCircle();
					extraCircle1.x = curve1MiddlePoint.x;
					extraCircle1.y = curve1MiddlePoint.y;
					addChild(extraCircle1);
					circles.push(extraCircle1);
					
					var extraCircle2:MovieClip = new BlueCircle();
					extraCircle2.x = curve2MiddlePoint.x;
					extraCircle2.y = curve2MiddlePoint.y;
					addChild(extraCircle2);
					circles.push(extraCircle2);
					
					var extraCircle3:MovieClip = new GreenCircle();
					extraCircle3.x = curve2Mid2.x;
					extraCircle3.y = curve2Mid2.y;
					addChild(extraCircle3);
					circles.push(extraCircle3);
					
					var extraCircle4:MovieClip = new GreenCircle();
					extraCircle4.x = curve2Mid1.x;
					extraCircle4.y = curve2Mid1.y;
					addChild(extraCircle4);
					circles.push(extraCircle4);
					
					var extraCircle5:MovieClip = new GreenCircle();
					extraCircle5.x = curve1Mid2.x;
					extraCircle5.y = curve1Mid2.y;
					addChild(extraCircle5);
					circles.push(extraCircle5);
					
					var extraCircle6:MovieClip = new GreenCircle();
					extraCircle6.x = curve1Mid1.x;
					extraCircle6.y = curve1Mid1.y;
					addChild(extraCircle6);
					circles.push(extraCircle6);
				
				}
			}
			
		}
		
	}
	
}
