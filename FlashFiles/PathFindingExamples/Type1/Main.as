package 
{
	import flash.display.*;
	import flash.geom.*;
	import flash.events.*;
	import flash.utils.*;
	
	
	public class Main extends MovieClip 
	{
		public var canvas:Sprite = new Sprite();
		
		public var startPoint:Point = new Point();
		public var endPoint:Point = new Point();
		public var currPoint:Point = new Point();
		
		public var tilesArray:Array = new Array();
		public var path:Array = new Array();
		
		public var countingState:Boolean = false;
		public var timer:Number = 0;
		
		public var rows:Number = 60;
		public var columms:Number = 34;
		public var lengthh:Number = 20;
		
		public var currentTileColor:uint = Math.random()*0x0000ff;
		public var gridColor:uint = Math.random()*0xffffff;
		public var gridOutlineColor:uint = Math.random()*0x999999;
		public var startColor:uint = Math.random()*0x00ff00;
		public var endColor:uint = Math.random()*0xff0000;
		public var stepsColor:uint = 0xAAAAAA;
		
		
		public function Main() 
		{
			
			createCanvas();
			fieldSetup();
			drawGrid();
			findPath();
			
			stage.addEventListener(MouseEvent.CLICK,addWall);
			this.addEventListener(Event.ENTER_FRAME,gLoop); 
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			
		}
		public function gLoop(myEvent:Event)
		{
			if(countingState == false)
			{
				timer ++;
				if(timer > 2)
				{
					step();
					timer = 0;
				}
			}
		}
		public function createCanvas()
		{
			canvas.graphics.clear();
			//canvas.x = 0;
			canvas.y = 10;
			addChild(canvas);
		}
		
		public function fieldSetup():void 
		{
			for (var i:Number = 0; i<rows; i++) 
			{
				tilesArray[i] = new MovieClip();
				
				for (var j:Number = 0; j < columms; j++) 
				{
					tilesArray[i][j] = new MovieClip();
					tilesArray[i][j].walkable = true;
					tilesArray[i][j].startPoint = false;
					tilesArray[i][j].endPoint = false;
					tilesArray[i][j].visited = false;
				}
			}
			startAndEndPoint();
		}
		
		public function startAndEndPoint():void
		{
			startPoint = new Point(Math.floor(Math.random() *rows),Math.floor(Math.random() *columms));
			endPoint = new Point(Math.floor(Math.random() *rows),Math.floor(Math.random() *columms));
			
			tilesArray[startPoint.x][startPoint.y].startPoint = true;
			tilesArray[startPoint.x][startPoint.y].visited = true;
			tilesArray[endPoint.x][endPoint.y].endPoint = true;
		}
		
		public function findPath():void 
		{
			path.push(startPoint);
			
			for (var i:Number = 0; i<rows; i++) 
			{
				for (var j:Number=0; j<columms; j++) 
				{
					tilesArray[i][j].visited=false;
				}
			}
			currPoint = new Point(startPoint.x,startPoint.y);
		}
		
		public function step():void 
		{
			
			var minF:Number = 10000;
			var savedPoint:Point;
			
			for (var i:Number=-1; i<=1; i++) 
			{
				for (var j:Number=-1; j<=1; j++) 
				{
					if ((i!=0 && j==0)||(i==0 && j!=0)) 
					{
						if (insideField(currPoint,i,j) && tilesArray[currPoint.x+i][currPoint.y+j].walkable && !tilesArray[currPoint.x+i][currPoint.y+j].visited) 
						{
							var g:Number = getG(i,j);
							var h:Number = HeuristicType(new Point(currPoint.x+i,currPoint.y+j),endPoint);
							var f:Number = Math.floor(g+h);
							if (f < minF) 
							{
								minF = f;
								savedPoint = new Point(currPoint.x+i,currPoint.y+j);
							}
							trace(f+"  "+path.length+"  "+f+"  "+h)
						}

					}
				}
			}
			
			if (savedPoint) 
			{
				if (savedPoint.x != endPoint.x || savedPoint.y != endPoint.y) 
				{
					drawTile(savedPoint.x,savedPoint.y,currentTileColor);
				}
				tilesArray[savedPoint.x][savedPoint.y].visited = true;
				currPoint = savedPoint;
				path.push(currPoint);
				
				if (path.length > 2) 
				{
					drawTile(path[path.length-2].x,path[path.length-2].y,stepsColor);
				}
				
				if (currPoint.x == endPoint.x && currPoint.y == endPoint.y) 
				{
					timer = 0;
					countingState = true;
				}
			}
			else 
			{
				if (path.length > 1) 
				{
					currPoint = path[path.length-2];
					drawTile(path[path.length-1].x,path[path.length-1].y,stepsColor);
					path.pop();
				}
				else 
				{
					drawTile(currPoint.x,currPoint.y,0xffffff);
					timer = 0;
					countingState = true;
				}
			}
		}
		
		public function getG(n1:Number,n2:Number) 
		{
			return 1;
		}
		
		public static function HeuristicType(p1:Point, p2:Point) 
		{   
			var cost:Number = 1.0;
			var diagonalCost:Number = 1.0;
			
			//Manhattan
			//return Math.abs(p1.x - p2.x) * cost + Math.abs(p1.y - p2.y) * cost;
			
			//Euclidian
			//var dx:Number = p1.x - p2.x;
			//var dy:Number = p1.y - p2.y;
			//return Math.sqrt( dx * dx + dy * dy ) * cost;
		
			//Diagonal
			var dx:Number = Math.abs(p1.x - p2.x);
			var dy:Number = Math.abs(p1.y - p2.y);
			var diag:Number = Math.min(dx, dy);
			var straight:Number = dx + dy;
			return diagonalCost * diag + cost * (straight - 2 * diag);
			
		}

		public function insideField(p:Point,n1:Number,n2:Number):Boolean 
		{
			if (p.x+n1 > rows-1 || p.x+n1 < 0 || p.y+n2 > columms-1 || p.y+n2<0) 
			{
				return false;
			}
			return true;
		}
		
		public function addWall(e:MouseEvent):void 
		{
			countingState = false;
			var row:Number = Math.floor(mouseY/lengthh);
			var col:Number = Math.floor(mouseX/lengthh);
			
			if (! tilesArray[col][row].startPoint &&! tilesArray[col][row].endPoint) 
			{
				tilesArray[col][row].walkable =! tilesArray[col][row].walkable;
			}
			else 
			{
				fieldSetup();
			}
			drawGrid();
			findPath();
		}
		
		public function drawTile(pX:Number,pY:Number,color:Number):void 
		{
			canvas.graphics.beginFill(color,1);
			canvas.graphics.drawRect(pX*lengthh,pY*lengthh,lengthh,lengthh);
			canvas.graphics.endFill();
		}
		
		public function drawGrid() 
		{
			canvas.graphics.clear();
			canvas.graphics.lineStyle(1,gridOutlineColor);
			
			for (var i:Number=0; i<rows; i++) 
			{
				for (var j:Number=0; j<columms; j++) 
				{
					drawTile(i,j,gridColor);
					
					if (tilesArray[i][j].walkable == false) 
					{
						drawTile(i,j,0x000000);
					}
					if (tilesArray[i][j].startPoint == true) 
					{
						drawTile(i,j,startColor);
					}
					if (tilesArray[i][j].endPoint == true) 
					{
						drawTile(i,j,endColor);
					}
				}
			}
		}
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
		public function kDown(event:KeyboardEvent):void
		{  
			if (event.keyCode == 32)
			{
				countingState = false;
				fieldSetup();
				drawGrid();
				findPath();
				startColor = Math.random()*0x00ff00;
				endColor = Math.random()*0xff0000;
				currentTileColor = Math.random()*0x0000ff;
				gridColor = Math.random()*0xffffff;
				
			}
		}
	}
}