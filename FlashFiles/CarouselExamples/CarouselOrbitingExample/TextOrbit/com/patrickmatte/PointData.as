package com.patrickmatte 
{
	
	import flash.geom.Point;

	public class PointData 
	{
		
		public var pt:Point;
		public var time:Number;
		public var vel:Point;
		public var color:RGBColor;
		public var brushWidth:Number;
		
		public function PointData(pt:Point, time:Number, vel:Point, color:RGBColor, brushWidth:Number) {
			this.pt = pt;
			this.time = time;
			this.vel = vel;
			this.color = color;
			this.brushWidth = brushWidth;
		}

	}
	
}
