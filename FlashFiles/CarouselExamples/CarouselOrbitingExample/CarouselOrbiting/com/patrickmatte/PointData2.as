package com.patrickmatte {
	
	import flash.geom.Point;

	public class PointData2 extends Point {
		
		public var velocityX;
		public var velocityY;
		
		public function PointData2 (x,y,velocityX=10,velocityY=10) {
			this.x = x;
			this.y = y;
			this.velocityX = velocityX;
			this.velocityY = velocityY;
		}

	}
	
}