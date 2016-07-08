package Graph
{
	import flash.display.*;
	import flash.geom.*;
	import flash.events.*;
	import flash.sampler.StackFrame;
	
    public class Graph
    {
        public static var nextIndex:int=0;
        public var nodes:Vector.<Node>;
        public var edges:Array = new Array();
		public var path:Array = new Array();
		public var nd:int;
		
		public var edgesColorTransform = new ColorTransform  ;
		public var nodesColorTransform = new ColorTransform  ;
		public var colorCodeSrting:String = "0x"+(Math.random()*0xFFFFFF).toString(16);
		public var nodesColor:uint = Math.random() * 0xFFFFFF;
		public var pathColor:uint;
		public var allNodesColor = colorCodeSrting;
		
		
        public function Graph()
        {
            nodes = new Vector.<Node>();
            edges = new Array();
			
        }
        //In order to get the node, we just ask for the index of it, and access the nodes vector with that key
        public function getNode(idx:int):Node
        {
            return nodes[idx];
        }
 
        //To get an edge, we ask for the two nodes that it connects,
        //then we retrieve all the edges of the from node and search if one of them
        //goes to the same node as the edge we are looking for, if it does, that's our edge.
        public function getEdge(from:int,to:int):Edge
        {
            var from_Edges:Array = edges[from] as Array;
            for(var a:int=0;a<from_Edges.length;a++)
            {
                if(from_Edges[a].getTo()==to)
                {
                    return from_Edges[a];
                }
            }
            return null;
        }
 
        //To add a node to the graph, we first look if it already exist on it,
        //if it doesn't, then we add it to the nodes vector, and add an array to the
        //edges vector where we will store the edges of that node, finally we increase
        //the next valid index int in order to give the next available index in the graph
        public function addNode(node:Node):int
        {
            if(validIndex(node.getIndex()))
            {
                nodes.push(node);
                edges.push(new Array());
                nextIndex++;
            }
            return 0;
        }
        //To add an edge we must first look if both nodes it connects actually exist,
        //then we must see if this edge already exist on the graph, finally we add it
        //to the array of edges of the node from where it comes
        public function addEdge(edge:Edge):void
        {
            if(validIndex(edge.getTo())&&validIndex(edge.getFrom()))
            {
                if(getEdge(edge.getFrom(),edge.getTo())==null)
                {
                    (edges[edge.getFrom()]as Array).push(edge);
                }
            }
        }
 
        //To get the edges of a node, just return the array given by the edges vector
        //at node's index position
        public function getEdges(node:int):Array
        {
            return edges[node];
        }
 
        //This function checks if the node index is between the range of already added nodes
        //which is form 0 to the next valid index of the graph
        public function validIndex(idx:int):Boolean
        {
            return (idx>=0 && idx<=nextIndex)
        }
 
        //Just returns the amount of nodes already added to the graph
        public function numNodes():int
        {
            return nodes.length;
        }
 
        //This is to redraw all the edges on the graph to get them to the normal style
        public function redraw():void
        {
            for each(var a_edges:Array in edges)
            {
                for each(var edge:Edge in a_edges)
                {
                    edge.drawEdge(getNode(edge.getFrom()).getPos(),getNode(edge.getTo()).getPos());
                }
            } 
			graphColor();
        }
 
        //This function return the next valid node index to be added
        public static function getNextIndex():int
        {
            return nextIndex;
        }
		public function graphColor()
		{
			pathColor = Math.random ()*0xFFFFFF;
			
			for (var i:uint = 0; i < nodes.length; i++)
			{
				nodesColorTransform.color = allNodesColor;
				nodes[i].transform.colorTransform = nodesColorTransform;
			}
			
		}
    }
}