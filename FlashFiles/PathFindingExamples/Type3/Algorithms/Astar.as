package Algorithms
{
	import Graph.Edge;
	import Graph.Graph;
	import utils.IndexedPriorityQ;
	import flash.geom.*;
	
	public class Astar 
	{
		public var graph:Graph;
		public var SPT:Vector.<Edge>;
		public var G_Cost:Vector.<Number>;	//This vector will store the G cost of each node
		public var F_Cost:Vector.<Number>;	//This vector will store the F cost of each node
		public var SF:Vector.<Edge>;
		public var source:int;
		public var target:int;

		public function Astar(n_graph:Graph,src:int,tar:int)
		{
			graph=n_graph;
			source=src;
			target=tar;
			SPT= new Vector.<Edge>(graph.numNodes());
			G_Cost = new Vector.<Number>(graph.numNodes());
			F_Cost = new Vector.<Number>(graph.numNodes());		
			SF = new Vector.<Edge>(graph.numNodes());
			search();
		}
		public function search():void
		{
			//The pw is now sorted depending on the F cost vector
			var pq:IndexedPriorityQ = new IndexedPriorityQ(F_Cost)
			pq.insert(source);
			while(!pq.isEmpty())
			{
				var NCN:int = pq.pop();
				SPT[NCN]=SF[NCN];
				if(SPT[NCN])
				{
				SPT[NCN].drawEdge(
					graph.getNode(SPT[NCN].getFrom()).getPos(),
					graph.getNode(SPT[NCN].getTo()).getPos(),
					"visited"
				);
				}
				if(NCN==target)return;
				var edges:Array=graph.getEdges(NCN);
				for each(var edge:Edge in edges)
				{
					//The H cost is obtained by the distance between the target node, and the arrival node of the edge being analyzed
					var Hcost:Number = Vector3D.distance(
						graph.getNode(edge.getTo()).getPos(),
						graph.getNode(target).getPos())
					var Gcost:Number = G_Cost[NCN] + edge.getCost();
					var to:int=edge.getTo();
					if(SF[edge.getTo()]==null)
					{
						F_Cost[edge.getTo()]=Gcost+Hcost;
						G_Cost[edge.getTo()]=Gcost;
						pq.insert(edge.getTo());
						SF[edge.getTo()]=edge;
					}
					else if((Gcost<G_Cost[edge.getTo()])&&(SPT[edge.getTo()]==null))
					{
						F_Cost[edge.getTo()]=Gcost+Hcost;
						G_Cost[edge.getTo()]=Gcost;
						pq.reorderUp();
						SF[edge.getTo()]=edge;
					}
				}
			}
		}
		public function getPath():Array
		{
			graph.path = new Array();
			
			if(target<0) return graph.path;
			
			graph.nd = target;
			
			graph.path.push(graph.nd);
			
			while((graph.nd!=source)&&(SPT[graph.nd]!=null))
			{
				SPT[graph.nd].drawEdge(
					graph.getNode(SPT[graph.nd].getFrom()).getPos(),
					graph.getNode(SPT[graph.nd].getTo()).getPos(),
					"path"
					);
				graph.nd = SPT[graph.nd].getFrom();
				graph.path.push(graph.nd);
			}
			graph.path = graph.path.reverse();
			
			if(graph.path.length >1)
			{
				for (var i:uint = 0; i < graph.path.length; i++)
				{
					graph.edgesColorTransform.color = graph.nodesColor;
					graph.nodes[graph.path[i]].transform.colorTransform = graph.edgesColorTransform;
				}
			}
			
			return graph.path;
		}
	}
}
