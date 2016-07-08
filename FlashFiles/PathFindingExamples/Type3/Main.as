package 
{
	import flash.display.*;
	import flash.geom.*;
	import flash.events.*;
	import flash.utils.*;
	import fl.motion.Color;
    import Graph.*;
    import utils.Grapher;
    import Algorithms.Dijkstra;
    import Algorithms.Astar;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	public class Main extends Sprite 
	{
		public var graph:Graph = new Graph();
		public var fromPoint:Number;
		public var toPoint:Number;
		
		public var pathFindingState:String = "normal";
		public var pathType:Number = 0;
		
		public var selectedBox:Sprite;
		public var currentIndex:uint;
		
		public var myEnem:Sprite = new Sprite();;
		public var myEnmMov:Boolean = false;
		public var myEnmColor:uint = Math.random()*0xFFFFFF;
		public var myEnmArray:Array = new Array();
		public var moveSpeed:Number = 1;
		
		public var patrolPoints:Array = new Array();
		public var currentPoint:Number = 0;
		
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		public var color1:uint;
		public var color2:uint;
		
		public function Main() 
		{
			this.addEventListener(Event.ENTER_FRAME,gLoop); 
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			stage.color =  Math.random()* 0xFFFFFF;
			graphGrid();
			pathType = randomRange(0,1);
			graph.redraw();
			createEnemy();
		}
		public function graphGrid()
		{
			var grapher:Grapher = new Grapher(stage.stageWidth,stage.stageHeight-30,19,19,graph);
            addChild(grapher);
			
		}
		public function gLoop(myEvent:Event)
		{
			//trace(myEnmArray.length);
			//trace(graph.nodes.length+"  "+graph.edges.length+"  "+pathFindingState)
			//trace(graph.colorCodeSrting)
			//trace(pathColor.toString(16))
			//trace(this.transform.colorTransform.color.toString(16))
			//trace(pathType+"     "+graph.path)
			//trace(graph.path+"  "+points)
			//trace(pathType+"     "+graph.nd)
			//trace(patrolPoints.length+"  "+graph.path.length)
			
			if(pathType == 0)
			{
				var dijkstra:Dijkstra = new Dijkstra(graph,fromPoint,toPoint);
				dijkstra.getPath();
			}
			if(pathType == 1)
			{
				var astar:Astar = new Astar(graph,fromPoint,toPoint);
				astar.getPath();
			}
			addListeners();
			enemyMovement();
			//backgroundColorTransition();
		}
		public function addListeners():void
		{
			for (var i:uint = 0; i < graph.nodes.length; i++)
			{
				graph.nodes[i].addEventListener(MouseEvent.CLICK,clickHandler);
				graph.nodes[i].addEventListener(MouseEvent.MOUSE_OVER,gridItemOver);
				graph.nodes[i].addEventListener(MouseEvent.MOUSE_OUT,gridItemOut);
			}
		}
		public function removeListeners():void
		{
			for (var i:uint = 0; i < graph.nodes.length; i++)
			{
				graph.nodes[i].removeEventListener(MouseEvent.CLICK,clickHandler);
			}
		}
		function gridItemOver(e)
		{
			selectedBox = e.currentTarget as Sprite;
			currentIndex = graph.nodes.indexOf(e.currentTarget);
			
			if(pathFindingState == "mouseRoll")
			{   
				graph.redraw();
				toPoint = currentIndex;
			}
			
			TweenLite.to(e.currentTarget,0.5,{scaleX:1.4, scaleY:1.4,ease:Elastic.easeOut});
		}
		function gridItemOut(e)
		{
			TweenLite.to(e.currentTarget,0.5,{scaleX:1, scaleY:1,ease:Elastic.easeOut});
		}
		public function clickHandler(e:MouseEvent):void
		{
			//trace(currentIndex);
			restartMove();
			graph.redraw();
			
			if(pathFindingState == "normal")
			{
				fromPoint = currentIndex;
				toPoint = randomRange(1,graph.nodes.length);;
			}
			
			if(pathFindingState == "mouseRoll")
			{
				fromPoint = currentIndex;;
			}
			
			removeListeners();
			
		}
		public function createEnemy()
		{
			myEnem.graphics.clear();
			myEnem.graphics.lineStyle(2,0x666666,1,true);
			myEnem.graphics.beginFill(myEnmColor,1);
			myEnem.graphics.drawCircle(0,0,10);
			myEnem.graphics.endFill();
			addChild(myEnem)
			myEnmArray.push(myEnem);
			
			myEnem.x = graph.nodes[randomRange(0,graph.nodes.length-1)].x;
			myEnem.y = graph.nodes[randomRange(0,graph.nodes.length-1)].y;
			
			if(myEnmArray.length>1)
			{
				myEnmArray.pop();
			}
		}
		
		public function enemyMovement()
		{    
			if(graph.path.length > 1)
			{
				if(myEnmMov == false)
				{
					for (var i:uint = 0; i < graph.path.length; i++)
					{   
						patrolPoints.push( new Point(graph.nodes[graph.path[i]].x,graph.nodes[graph.path[i]].y));
					}
					myEnmMov = true;
				}
				
				//trace(patrolPoints[randomRange(1,patrolPoints.length-1)]+"   "+patrolPoints.length+"  "+graph.path.length)
				//trace(patrolPoints[patrolPoints.length-1]+"  "+stage.mouseX+"  "+stage.mouseY+"  "+currentPoint)
				//trace(patrolPoints.length+"  "+graph.path.length+"  "+currentPoint)
				//TweenLite.to(myEnem, .1, {x:stage.mouseX, y:stage.mouseY});
				//TweenMax.to(myEnem, 5, {x:points.x, y:points.y});
				//trace(stage.mouseX+"  "+patrolPoints[2]+"  "+patrolPoints[2].x)
				//trace(patrolPoints[0].x+"  "+myEnem.x)
				
				var getDistanceTo:Number = getDistances(patrolPoints[currentPoint].x - myEnem.x, patrolPoints[currentPoint].y - myEnem.y);
				if(getDistanceTo<5)
				{
					currentPoint++
					if (currentPoint >= patrolPoints.length)
					{
						//currentPoint = 0;
						currentPoint = patrolPoints.length-1;
					}
				} 
				if(pathFindingState == "normal")
				{
					TweenMax.to(myEnem, moveSpeed, {x:patrolPoints[currentPoint].x, y:patrolPoints[currentPoint].y});
				}
				
				//trace(currentPoint+"  "+patrolPoints.length)
				//trace(getDistanceTo+"   "+getDistance(patrolPoints[currentPoint].x,myEnem.x,patrolPoints[currentPoint].y,myEnem.y));
			}
		}
		public function restartMove()
		{
			if(myEnmMov == true)
			{
				currentPoint = 0;
				//patrolPoints.length = 0;
				patrolPoints.splice(0);
				myEnmMov = false;
			}
		}
		public function backgroundColorTransition()
		{
			
			if(colorTransSwitch == "goingUp")
			{
				colorTransNum += 1;
			}
			if(colorTransSwitch == "goingDown")
			{
				colorTransNum -= 1; 
			}
			if(curVal <= 0)
			{   
				colorTransSwitch = "goingUp";
				color2 = Math.random() * 0xFFFFFF;
			}
			if(curVal >= 1)
			{
				color1 = Math.random() * 0xFFFFFF;
				colorTransSwitch = "goingDown";
			}
			
			curVal = colorTransNum/255;
			stage.color = Color.interpolateColor(color1,color2,curVal);
			
		}
		public function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
		public function getDistances(delta_x:Number, delta_y:Number):Number
		{
			return Math.sqrt((delta_x*delta_x)+(delta_y*delta_y));
		}
		function getDistance(destinationX:Number, FromX:Number,  destinationY:Number, FromY:Number)
		{
			var xDist:Number = destinationX - FromX;
			var yDist:Number = destinationY - FromY;
			return Math.sqrt(xDist * xDist + yDist * yDist);
		}
		
		public function kDown(event:KeyboardEvent):void
		{
			if (event.keyCode == 38)
			{  
				moveSpeed += .2
				if(moveSpeed>= 4)
				{
					moveSpeed = 4;
				}
			}
			if (event.keyCode == 40)
			{
				moveSpeed -= .2;
				
				if(moveSpeed<.4)
				{
					moveSpeed = .4;
				}
			}
			if (event.keyCode == 32)
			{   
				if(pathFindingState == "mouseRoll")
				{
				     fromPoint = randomRange(1,graph.nodes.length);;
				}
				else
				{
					fromPoint = 0; 
					toPoint = 0;
				}
				myEnmColor = Math.random()* 0xFFFFFF;
				graph.nodesColor = Math.random()* 0xFFFFFF;
				stage.color =  Math.random()* 0xFFFFFF;
				graph.redraw();
				createEnemy();
			}
			if (event.keyCode == 78)
			{ 
				restartMove();
				pathFindingState = "normal";
			}
			if (event.keyCode == 77)
			{ 
				pathFindingState = "mouseRoll";
			}
				
		}
		
	}
}