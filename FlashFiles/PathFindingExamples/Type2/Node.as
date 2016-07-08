package  
{
	import com.untoldentertainment.pathfinding.INode;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Phillip Chertok
	 */
	public class Node extends MovieClip implements INode
	{
		//Our interface variables since we inherit from MovieClip x and y are already set
		private var _parentNode:INode;		
		private var _f:Number;
		private var _g:Number;
		private var _h:Number;
		private var _traversable:Boolean = true;
		
		private static const W:int = 15;
		private static const H:int = 15;
		
		//Some 
		private var _row:int;
		private var _col:int;
		
		public function Node(r:int, c:int) 
		{
			this.row = r;
			this.col = c;
			
			this.highlight(  );
		}
		
		public function highlight(color:uint =  0x0080C0):void
		{
			this.graphics.clear();
			this.graphics.lineStyle(2);
			this.graphics.beginFill(color);
			this.graphics.drawRect( 0, 0, W, H);
			this.graphics.endFill();
		}
		
		/* INTERFACE com.untoldentertainment.pathfinding.INode */
		public function get parentNode():INode { return _parentNode; }		
		public function set parentNode(value:INode):void 
		{
			_parentNode = value;
		}
		
		public function get f():Number { return _f; }		
		public function set f(value:Number):void 
		{
			_f = value;
		}
		
		public function get g():Number { return _g; }		
		public function set g(value:Number):void 
		{
			_g = value;
		}
		
		public function get h():Number { return _h; }		
		public function set h(value:Number):void 
		{
			_h = value;
		}
		
		public function get traversable():Boolean { return _traversable; }		
		public function set traversable(value:Boolean):void 
		{
			_traversable = value;
		}
		
		public function get row():int { return _row; }		
		public function set row(value:int):void 
		{
			_row = value;
		}
		
		public function get col():int { return _col; }		
		public function set col(value:int):void 
		{
			_col = value;
		}
	}
}