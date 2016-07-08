package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;	import flash.geom.*;		public class Main extends MovieClip	{		public var mapState:Boolean = false;
		
		public var mousePoint:Point = new Point(mouseX, mouseY);
		public var elementPoint:Point = new Point();
		
		public var myColor:uint = Math.random() * 0xFFFFFF;
		public var onProximityColors:uint = Math.random() * 0xFFFFFF;		public var offProximityColors:uint = Math.random() * 0xFFFFFF;
		
		public var myArray:Array = new Array();
				public var myObjectColorTransform = new ColorTransform  ;
		public var onProximityColorTransform = new ColorTransform  ;
		public var offProximityColorTransform = new ColorTransform  ;
		
		public var radiusOfBoth:Number = 0;
		public var xDist:Number = 0;
		public var yDist:Number = 0;
		public var xDistance:Number = 0;
		public var yDistance:Number = 0;
		public var distanceBetween:Number = 0;
		public var closestObjectDist:Number = 0;
		
		public var minNum:Number = 0;
		public var getMinNum:Number  = 0;
		public var myNum:Number = 0;
		public var closestObject:Number = 0;
				public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gL)
			
			myArray.push(c3)
			myArray.push(c4)
			myArray.push(c5)		}		public function gL(myEvent:Event):void		{
	
			for (var i:uint = 0; i < myArray.length; i += 1)
			{  
				offProximityColorTransform.color = offProximityColors;
				myArray[i].transform.colorTransform = offProximityColorTransform;
			}			nearestObject();		}
		public function nearestObject()
		{
			//trace(myArray[closestObject])
			
			for (var a:uint = 0; a < myArray.length; a += 1)
			{   
				xDist = c1.x - myArray[a].x;
				yDist = c1.y - myArray[a].y;
				closestObjectDist = Math.sqrt(xDist * xDist + yDist * yDist);
				
				getMinNum = Math.abs(Math.sqrt(xDist * xDist + yDist * yDist)) 
				
				if(getMinNum < minNum || a == 0) 
				{ 
					minNum = getMinNum;
					closestObject = a;
				} 
			}
			onProximityColorTransform.color = onProximityColors;
			myArray[closestObject].transform.colorTransform = onProximityColorTransform;
			
			circularCollision(c1,myArray[closestObject]);
			trace(myArray[closestObject])
		}
		public function circularCollision(mc1:MovieClip,mc2:MovieClip)
		{
			mc1.x = stage.mouseX;
			mc1.y = stage.mouseY;
			
			radiusOfBoth = (mc1.width/2) + (mc2.width/2);
			
			xDistance = mc1.x - mc2.x;
			yDistance = mc1.y - mc2.y;
			distanceBetween = Math.sqrt(xDistance * xDistance + yDistance * yDistance);
			//trace(distanceBetween)	
		
			if (distanceBetween <= radiusOfBoth) 
			{
				myColor = 0x00FFAA
				//mc1.alpha = .5;
			}
			else 
			{				
				myColor= 0xFF0000;
				//mc1.alpha = 1;
			}
			myObjectColorTransform.color = myColor;
			c1.transform.colorTransform = myObjectColorTransform;
			
		}
		
		function PointDistance()
		{
			for (var i:uint = 0; i < myArray.length; i += 1)
			{ 
				elementPoint.x = myArray[i].x;
				elementPoint.y = myArray[i].y;
				var dist:Number = Point.distance(mousePoint, elementPoint);
				//trace(dist)
				
				//var tempDistance:Number = getDistance(mousePoint, elementPoint);
				//trace(tempDistance)
			}
		}
		function Distance(x1:Number, x2:Number,  y1:Number, y2:Number)
		{
			var xDist:Number = x1 - x2;
			var yDist:Number = y1 - y2;
			return Math.sqrt(xDist * xDist + yDist * yDist);
		}
		function getDistance(point1:Point, point2:Point):Number 
		{
    		var x:Number = point1.x - point2.x;
    		var y:Number = point1.y - point2.y;
    		return Math.sqrt(x * x + y * y);
    	}	}}