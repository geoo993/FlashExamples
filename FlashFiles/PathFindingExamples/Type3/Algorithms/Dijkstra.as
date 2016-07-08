package Algorithms
{
	import flash.display.*;
	import flash.geom.*;
	import flash.events.*;
	
	import Graph.Edge;
	import Graph.Graph;
	import utils.IndexedPriorityQ;
	
	public class Dijkstra 
	{
		public var graph:Graph					//The graph where the search will be made
		public var SPT:Vector.<Edge>;			//This vector will store the Shortest Path Three
		public var cost2Node:Vector.<Number>;	//This vector will store the costs of getting to each node
		public var SF:Vector.<Edge>;			//This will be our search frontier, it will contain
		public var source:int;
		public var target:int;
		
		public function Dijkstra(n_graph:Graph,src:int,tar:int) 
		{
			graph=n_graph;
			source=src;
			target=tar;
			SPT= new Vector.<Edge>(graph.numNodes());
			cost2Node = new Vector.<Number>(graph.numNodes());
			SF = new Vector.<Edge>(graph.numNodes());
			search();
		}
		private function search():void
		{
			//This will be the indexed priority Queue that will sort the nodes
			var pq:IndexedPriorityQ = new IndexedPriorityQ(cost2Node)
			//To start the algorithm we first add the source to the pq
			pq.insert(source);
			//With this we make sure that we will continue the search until there is no more nodes on the pq
			while(!pq.isEmpty())
			{
				
				/* 1.- Take the closest node not yet analysed */
				
				//We get the Next Closest Node (NCN) which is the first element of the pq
				var NCN:int = pq.pop();
				
				/* 2.-Add its best edge to the Shortest Path Tree (Its best edge is stored on the SF) */
				
				SPT[NCN]=SF[NCN];
				
				//This will color the actual edge to red in order to see which edges algorithm had analyzed
				if(SPT[NCN])
				{
					SPT[NCN].drawEdge(
						graph.getNode(SPT[NCN].getFrom()).getPos(),
						graph.getNode(SPT[NCN].getTo()).getPos(),
						"visited"
					);
				}
				
				/* 3.- If if is the target node, finish the search */
				
				if(NCN==target)return;
				
				/* 4.- Retrieve all the edges of this node */
				
				var edges:Array=graph.getEdges(NCN);
				
				//With this loop we will analyse each of the edges of the array
				for each(var edge:Edge in edges)
				{
					/* 5.- For each edge calculate the cost of moving from the source node to the arrival Node */
					
					//The total cost is calculated by: Cost of the node + Cost of the edge
					var nCost:Number = cost2Node[NCN]+edge.getCost();
					
					//If the arrival node has no edge on the SF, then add its cost to the
					//Cost vector, the arrival node to the pq, and add the edge to the SF
					if(SF[edge.getTo()]==null)
					{
						cost2Node[edge.getTo()]=nCost;
						pq.insert(edge.getTo());
						SF[edge.getTo()]=edge;
					}

					/* 6.- If the cost of this edge is less than the cost of the arrival node until now, then update the node cost with the new one */					
					else if((nCost<cost2Node[edge.getTo()])&&(SPT[edge.getTo()]==null))
					{
						cost2Node[edge.getTo()]= nCost;
						//Since the cost of the node has changed, we need to reorder again the pq to reflect the changes
						pq.reorderUp();
						//Because this edge is better, we update the SF with this edge
						SF[edge.getTo()]=edge;
					}
				}
			}
		}
		
		public function getPath():Array
		{
			//Create the variable where we will store the path
			graph.path = new Array();
			//If the target is a not valid index, or the SPT doesn't have a path to the node,
			//meaning that is wasn't found, just return an empty path
			if((target<0)||(SPT[target]==null)) return graph.path;
			//nd will store the current node, wich at the beggining is the target
			graph.nd = target;
			//add the target to the path
			graph.path.push(graph.nd);
			//This loop will work until we find the source, or theres no edge in the SPT for a certain node
			while((graph.nd!=source)&&(SPT[graph.nd]!=null))
			{
				//This will change the color of the path to black so we can actually se it
				SPT[graph.nd].drawEdge(
					graph.getNode(SPT[graph.nd].getFrom()).getPos(),
					graph.getNode(SPT[graph.nd].getTo()).getPos(),
					"path"
				);
				//Get the next node and add it to the path
				graph.nd = SPT[graph.nd].getFrom()
				graph.path.push(graph.nd);
			}
			//Reverse the path so the first element will be the source
			graph.path = graph.path.reverse();
			
			if(graph.path.length >1)
			{
				
				for (var i:uint = 0; i < graph.path.length; i++)
				{
					graph.edgesColorTransform.color = graph.nodesColor;;
					graph.nodes[graph.path[i]].transform.colorTransform = graph.edgesColorTransform;
					
				}
			}
			return graph.path;
			
		}
	}
}
