package utils
{
	import Graph.Edge;
	import Graph.Graph;
	import Graph.Node;
	
	import flash.geom.*;
	import flash.display.*
	import flash.events.*

	public class Grapher extends Sprite
	{
		var edgesCont:Sprite = new Sprite();
		public function Grapher(sWidth:int,sHeight:int,cellsX:int,cellsY:int,n_graph:Graph)
		{
			addChild(edgesCont);
			var dx:int=sWidth/cellsX;
			var dy:int=sHeight/cellsY;
			for(var x:int=dx/2;x<sWidth;x+=dx)
			{
				for(var y:int=dy/2;y<sHeight;y+=dy)
				{
					var node:Node = new Node(Graph.Graph.getNextIndex(),new Vector3D(x,y));
					n_graph.addNode(node);
					addChild(node);
				}
			}
			for(var node_x:int=0;node_x<cellsX;node_x++)
			{
				for(var node_y:int=0;node_y<cellsY;node_y++)
				{
						addNeighbours(n_graph,node_y,node_x,cellsX,cellsY);
				}
			}
		}
		
		public function addNeighbours(n_graph:Graph,row:int,col:int,cellsX:int,cellsY:int):void
		{
			for(var i:int=-1;i<=1;i++)
			{
				for(var j:int=-1;j<=1;j++)
				{
					var nodeY = row+j;
					var nodeX = col+i;
					if(i==0&&j==0)continue;
					if(nodeX>=0&&nodeX<cellsX&&nodeY>=0&&nodeY<cellsY)
					{
						var nodeIdx:int=col*cellsY+row;
						var nIdx:int=nodeX*cellsY+nodeY
						var nodePos:Vector3D=n_graph.getNode(nodeIdx).getPos();
						var neighbourPos:Vector3D=n_graph.getNode(nIdx).getPos();
						var cost:Number=Vector3D.distance(nodePos,neighbourPos);
						var edge:Edge = new Edge(nodeIdx,nIdx,Number(cost));
						n_graph.addEdge(edge);
						edgesCont.addChild(edge);
						edge.drawEdge(nodePos,neighbourPos);
					}
				}
			}
		}
	}
}