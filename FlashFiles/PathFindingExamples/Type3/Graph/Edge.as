package Graph
{
    import flash.display.Sprite;
    import flash.geom.Vector3D;
 
    public class Edge extends Sprite
    {
		public var graph:Graph = new Graph();
        public var from:int;     //The index of the node from which this edge departs
        public var to:int;       //The index of the node from which this edge arrives
        public var cost:Number;  //The cost of crossing through this node (i.e. the distance)
		
		public var visitedColor:uint = 0x000fff;
		
		public var edgesColor:uint = 0xdddddd;
		
        public function Edge(n_From:int,n_To:int,n_Cost:Number=1.0)
        {
            from = n_From;
            to = n_To;
            cost = n_Cost;
            this.z = 1;
        }
 
        public function getFrom():int
        {
            return from;
        }
 
        public function setFrom(n_From:int):void
        {
            from=n_From;
        }
 
        public function getTo():int
        {
            return to;
        }
 
        public function setTo(n_To:int):void
        {
            to=n_To;
        }
 
        public function setCost(n_Cost:Number):void
        {
            cost=n_Cost;
        }
 
        public function getCost():Number
        {
            return cost;
        }
        /*
          Since the edge is just a line that connects the nodes,
          we will use this method to draw the edge, the style refers to how we will
          want the edge to be
        */
        public function drawEdge(fromPos:Vector3D,toPos:Vector3D,style:String="normal")
        {
			//trace(pathColor.toString(16))
			//trace(this.transform.colorTransform.color.toString(16))
			
			if(style == "normal")
			{
				this.graphics.clear();
				this.graphics.lineStyle(1, edgesColor, .2);
				this.graphics.moveTo(fromPos.x,fromPos.y+10);
				this.graphics.lineTo(toPos.x,toPos.y+10);
			}
			if(style == "path")
			{
				this.graphics.clear();
				this.graphics.lineStyle(2, graph.pathColor,1);
				this.graphics.moveTo(fromPos.x,fromPos.y+10);
				this.graphics.lineTo(toPos.x,toPos.y+10);
			}
			/*if(style == "visited")
			{
				this.graphics.clear();
				this.graphics.lineStyle(1, visitedColor,1);
				this.graphics.moveTo(fromPos.x,fromPos.y);
				this.graphics.lineTo(toPos.x,toPos.y);
			}*/
            
        }
    }
}