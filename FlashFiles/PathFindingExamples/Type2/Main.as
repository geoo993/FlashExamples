package  
{
	import com.untoldentertainment.pathfinding.INode;
	import com.untoldentertainment.pathfinding.Pathfinder;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Phillip Chertok
	 */
	public class Main extends Sprite
	{
		private static const GRID_WIDTH:int = 25;
		private static const GRID_HEIGHT:int = 15;
		private static const GRID_SPACING:int = 5;
		
		private var _gridHolder:Sprite;
		private var _nodes:Array;
		
		private var _startNode:INode;
		private var _endNode:INode;
		
		public function Main() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
			
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			createNodes();
			
			initEvents();
			
			Pathfinder.heuristic = Pathfinder.manhattanHeuristic;
		}
		
		private function initEvents():void
		{
			enableNodes();
			
			Reset.addEventListener(MouseEvent.CLICK, onResetClick);
			heuristics.addEventListener(Event.CHANGE, onHeuristicChange);
		}
		
		private function onHeuristicChange(e:Event):void 
		{
			switch(heuristics.selectedLabel)
			{
				case 'Manhattan': Pathfinder.heuristic = Pathfinder.manhattanHeuristic; break;				
				case 'Euclidian': Pathfinder.heuristic = Pathfinder.euclidianHeuristic; break;				
				case 'Diagonal':  Pathfinder.heuristic = Pathfinder.diagonalHeuristic; break;
			}
			
			if (_startNode && _endNode) {
				clearNodes();
				drawPath( Pathfinder.findPath(_startNode, _endNode, findConnectedNodes) );
			}
		}
		
		private function onResetClick(e:MouseEvent):void 
		{
			_startNode = null;
			_endNode = null;
			
			createNodes();
			
			enableNodes();
		}
		
		private function enableNodes():void
		{
			var node:Node;
			for (var i:int = 0; i < _nodes.length; i++) 
			{
				node = _nodes[i];
				
				node.buttonMode = true;
				node.addEventListener(MouseEvent.ROLL_OVER, onNodeOver, false, 0, true);
				node.addEventListener(MouseEvent.ROLL_OUT, onNodeOut, false, 0, true);
				node.addEventListener(MouseEvent.CLICK, onNodeClick, false, 0, true);				
			}			
		}
		
		private function disableNodes():void
		{
			var node:Node;
			for (var i:int = 0; i < _nodes.length; i++) 
			{
				node = _nodes[i];
				
				node.buttonMode = false;
				node.removeEventListener(MouseEvent.ROLL_OVER, onNodeOver);
				node.removeEventListener(MouseEvent.ROLL_OUT, onNodeOut);
				node.removeEventListener(MouseEvent.CLICK, onNodeClick);
			}			
		}
		
		private function clearNodes():void
		{
			var node:Node;
			for (var i:int = 0; i < _nodes.length; i++) 
			{
				node = _nodes[i];								
				node.highlight();
			}			
		}		
		
		private function createNodes():void
		{
			if (_gridHolder && contains(_gridHolder) ) {
				removeChild(_gridHolder);
			}
			
			_gridHolder = new Sprite();
			_nodes = [];
			
			var node:Node;
			
			for (var r:int = 0; r < GRID_HEIGHT; r++) 
			{
				for (var c:int = 0; c < GRID_WIDTH; c++) 
				{
					node = new Node(r, c);
					node.x = c * (node.width + GRID_SPACING);
					node.y = r * (node.height + GRID_SPACING);				
					
					_gridHolder.addChild(node);
					
					_nodes.push( node );
				}
			}
			
			_gridHolder.x = int( (stage.stageWidth - _gridHolder.width) * 0.5 );
			_gridHolder.y = 80;
			
			addChild(_gridHolder);
		}
		
		public function findConnectedNodes( node:INode ):Array
		{
			var n:Node = node as Node;
			var connectedNodes:Array = [];			
			var testNode:Node;
			for (var i:int = 0; i < _nodes.length; i++) 
			{
				testNode = _nodes[i];
				if (testNode.row < n.row - 1 || testNode.row > n.row + 1) continue;
				if (testNode.col < n.col - 1 || testNode.col > n.col + 1) continue;
				
				connectedNodes.push( testNode );
			}
			
			return connectedNodes;
		}
		
		private function drawPath(nodes:Array):void
		{
			if (!nodes) return;
			
			disableNodes();
			
			var n:Node;		
			
			for (var i:int = 0; i < nodes.length; ++i) {
				n = nodes[i];
				n.highlight(0xFFFF00);
			}
		}
		
		//---- EVENT HANDLERS -------------------------------------------------------------------------
		private function onNodeClick(e:MouseEvent):void 
		{
			var node:Node = e.currentTarget as Node;
			if (!_startNode) {
				_startNode = node;
				node.highlight( 0xFF0000 );
				node.buttonMode = false;
				return;
			}
			
			if (node == _startNode) return;
			
			node.buttonMode = false;
			
			_endNode = node;
			
			node.highlight( 0xFF0000 );
			
			drawPath( Pathfinder.findPath(_startNode, _endNode, findConnectedNodes) );
		}			
		
		private function onNodeOver(e:MouseEvent):void 
		{
			var node:Node = e.currentTarget as Node;
			if(node != _startNode && node != _endNode) node.highlight( 0xD5FFD5 );
		}
		
		private function onNodeOut(e:MouseEvent):void 
		{
			var node:Node = e.currentTarget as Node;
			if(node != _startNode && node != _endNode) node.highlight();
		}		
	}

}