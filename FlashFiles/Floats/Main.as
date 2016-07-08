package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.text.*;
	import com.greensock.*;
	import com.greensock.easing.*;

	public class Main extends MovieClip
	{
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
		
		public var xPoss:Number = 0;
		public var yPoss:Number = 0;
		public var ySpeed:Number = 1;
		public var xPosition:Number = 0;
		public var yPosition:Number = 0;
		public var radius:Number = 0;
		public var transparency:Number = 1;
		public var scaleFactor:Number = .5;
		public var whatShape:Number = 1;
		
		public var rotationRadian:Number;
		public var maxSpeed:Number = 4;
		public var minSize:Number = 5;
		public var maxSize:Number = 15;
		public var minFragments:Number = 2;
		public var maxFragments:Number = 10;
		public var fragmentRange:Number = 80;
		public var totalFragments:Number = randomRange(minFragments,maxFragments);
		
		public var numOfShapes:uint = 100;
		public var playerType:Number = 0;
		public var playerSpeed:Number = 10;
		public var playerSize:Number = 0;
		public var playerScore:Number = 0;
		public var MaxScoreLimit = 1200;
		public var minScoreLimit:Number = 0; 
		public var oppositeScore = 1200;
		public var scoreType1:Number = 300;
		public var scoreType2:Number = 10;
		public var levesNum:Number = 1;
		
		public var destinationX:Number = 0;
		public var destinationY:Number = 0;
		public var myCount:Number = 0;
		
		public var scoreBarColor:uint = Math.random() * 0xFFFFFF;
		public var scoreBar2Color:uint = Math.random() * 0xFFFFFF;
		public var outlineColor = Math.random() * 0xFFFFFF;
		public var shapesColor:uint = Math.random() * 0xFFFFFF;
		public var ExShapesColor:uint = Math.random() * 0xFFFFFF;
        public var backgrounColor:uint = Math.random() * 0xFFFFFF;
		public var playerColor:uint = Math.random() * 0xFFFFFF;
		
		public var resetScore:Boolean = false;
		public var backColorState:Boolean = false;
		public var createPlayer:Boolean = false;
		public var shapesState:Boolean = false;
		public var moveState:Boolean = false;
		public var moveShapes:Boolean = false;
        public var hitOut:Boolean = false;
		public var destroyState:Boolean = false;
		public var findBoth:Boolean = false;
		
		public var targetMove:String = "idle";
		public var goto:String = "idle";
		
		public var temp:MovieClip;
		public var selectedSprite:MovieClip;
		public var selectedPlayer:MovieClip;
		
		public var playerIndex:uint;
        public var currentIndex:uint;
		public var shapeCurrentIndex:uint;
		
		public var scoreBarColorTransform = new ColorTransform  ;
		public var targetColorTransform = new ColorTransform  ;
		public var myExploColorTransform = new ColorTransform  ;
		public var myColorTransform = new ColorTransform  ;
		public var newShapeColorTransform = new ColorTransform  ;
		public var backgroundColorTransform = new ColorTransform  ;
		public var playerColorTransform = new ColorTransform  ;
		
		public var exploShapesArray:Array = new Array  ;
		public var myShapesArray:Array = new Array  ;
		public var outlineArray:Array = new Array();
		public var playerArray:Array = new Array  ; 
		public var targetArray:Array = new Array();
		public var followersArray:Array = new Array();
		
		
		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			stage.addEventListener(MouseEvent.CLICK,mouseClick);
		}
		function drawTarget()
		{
			var circle:MovieClip = new MovieClip(); 
			circle.graphics.lineStyle(2, 0x000000); 
			circle.graphics.drawCircle(0, 0, 20); 
			circle.graphics.endFill(); 
			
			addChild(circle);
			targetArray.push(circle)
		}
		function targetOnStage()
		{
			if(targetArray.length < 1)
			{
				drawTarget();
			}
			
			if(targetMove == "idle")
			{
				targetArray[0].alpha = 0;
			}
			if(targetMove == "findTarget")
			{
				whatShape = randomRange(1,myShapesArray.length-1);
				targetMove = "stayOnTarget";
			}
			if(targetMove == "stayOnTarget")
			{
				for (var i:uint = 0; i < targetArray.length; i++) 
				{ 
					targetArray[i].x = myShapesArray[whatShape].x;
					targetArray[i].y = myShapesArray[whatShape].y;
					
					targetColorTransform.color = playerColor
					targetArray[i].transform.colorTransform = targetColorTransform;
					myShapesArray[whatShape].transform.colorTransform = targetColorTransform;
				} 
			
			}
		}
		public function CreateShapesOnPlayer(tempp:MovieClip)
		{
			for (var i:Number = 0; i < totalFragments; i++)
			{
				var thisShape2:MovieClip = new MyShape2(this);
				thisShape2.graphics.beginFill(ExShapesColor,1);
	
				thisShape2.graphics.drawCircle(0,0,randomRange(minSize,maxSize));
				
				thisShape2.graphics.endFill();
				this.addChild(thisShape2);
				exploShapesArray.push(thisShape2);
              
				thisShape2.x = tempp.x;
				thisShape2.y = tempp.y;
			}
		}
		function duplicateCircle() 
		{
			if(playerType == 0)
			{
				var circle:ColorCircles = new ColorCircles();
				for (var i:uint = 0; i < playerArray.length; i++)
				{
					circle.x = playerArray[i].x;
					circle.y = playerArray[i].y;
					
					scaleFactor = playerArray[i].height/50;
					circle.scaleX= scaleFactor;
					circle.scaleY= scaleFactor;
				}
				this.addChild(circle);
				followersArray.push(circle)
			} 
			if(playerType == 1)
			{
				var triangle:ColorTriangle = new ColorTriangle();
				for (var e:uint = 0; e < playerArray.length; e++)
				{
					triangle.x = playerArray[e].x;
					triangle.y = playerArray[e].y;
					
					scaleFactor = playerArray[i].height/20;
					triangle.scaleX= scaleFactor;
					triangle.scaleY= scaleFactor;
					
				}
				this.addChild(triangle);
				followersArray.push(triangle)
			}
			
			for (var s:uint = 0; s < followersArray.length; s++)
			{
				if (followersArray[s].alpha<0) 
				{
					followersArray.splice(s,1);
				}
			}
		}
		function drawPlayer(mySize:Number)
		{
			var myPlayer:MovieClip = new FloatingBall()  ;
			myPlayer.graphics.beginFill(playerColor,transparency);
			
			if(playerType == 0)
			{
				myPlayer.graphics.drawCircle(0,0,mySize);
			}
			if (playerType == 1)
			{
				myPlayer.graphics.moveTo(0,0);
				myPlayer.graphics.lineTo(mySize,(mySize*2));
				myPlayer.graphics.lineTo(-mySize,(mySize*2));
			}
			myPlayer.graphics.endFill();
			
			myPlayer.x = stage.stageWidth / 2;
			myPlayer.y = stage.stageHeight / 2;
			stage.addChild(myPlayer);
			playerArray.push(myPlayer);
			
			temp = myPlayer;
			
			for (var i:uint = 0; i < playerArray.length; i++)
			{
				playerArray[i].addEventListener(Event.ENTER_FRAME, playerEnterFrame);
			}
		} 
		function playerEnterFrame(event:Event):void
		{
			if(playerSize > 15)
			{
				playerSpeed = 25;
			}
			if(playerSize <= 15)
			{
				playerSpeed = 20;
			}
			if(playerSize <= 10)
			{
				playerSpeed = 15;
			}
			
			for (var i:uint = 0; i < playerArray.length; i++)
			{
				destinationX = stage.mouseX;
				destinationY = stage.mouseY;
				playerArray[i].x += (destinationX - playerArray[i].x) / playerSpeed;
				playerArray[i].y += (destinationY - playerArray[i].y) / playerSpeed;
				
				var radians:Number = Math.atan2(destinationY - playerArray[i].y, destinationX - playerArray[i].x);
				var degrees:Number = radians / (Math.PI / 180) + 90;
				
				playerArray[i].rotation = degrees;
			
				for (var q:uint = 0; q < myShapesArray.length; q++)
				{
					xDist = playerArray[i].x - myShapesArray[q].x;
					yDist = playerArray[i].y - myShapesArray[q].y;
					closestObjectDist = Math.sqrt(xDist * xDist + yDist * yDist);
					
					getMinNum = Math.abs(Math.sqrt(xDist * xDist + yDist * yDist)) 
					
					if(getMinNum < minNum || q == 0) 
					{ 
						minNum= getMinNum;
						closestObject = q;
					} 
				}
				circularCollisionWithShapes(playerArray[i],myShapesArray[closestObject])
			}	
			addPlayerListeners();
		}
		function circularCollisionWithShapes(mc1:MovieClip,mc2:MovieClip)
		{
			if(findBoth == true)
			{
				radiusOfBoth = (mc1.width/2) + (mc2.width/2);
			
				xDistance = mc1.x - mc2.x;
				yDistance = mc1.y - mc2.y;
				distanceBetween = Math.sqrt(xDistance * xDistance + yDistance * yDistance);
			
				if (distanceBetween <= radiusOfBoth && playerType == 0 || mc2.hitTestPoint(mc1.x,mc1.y,true) && playerType == 1) 
				{
					playerScore -= scoreType2;
					oppositeScore += scoreType2;
							
					if(mc2.transform.colorTransform.color.toString(16) == playerColor.toString(16))
					{
						CreateShapesOnPlayer(temp)
						
						playerScore += scoreType1;
						oppositeScore -= scoreType1;
					}
					targetMove = "findTarget";
					
					playerColorChange();
					addAllShapeOnStage()
					destroyShapes(mc2);
				}
			}
		}
		function addPlayerListeners():void
		{
			for (var i:uint = 0; i < playerArray.length; i++) 
			{
				playerArray[i].buttonMode = true;
				playerArray[i].addEventListener(MouseEvent.CLICK, playerClickHandler);
			}
		}
	
		function removePlayerListeners():void
		{
			for (var i:uint = 0; i < playerArray.length; i++) 
			{
				playerArray[i].buttonMode = false;
				playerArray[i].removeEventListener(MouseEvent.CLICK, playerClickHandler);
			}
		}
		function playerClickHandler(e:MouseEvent):void
		{
			selectedPlayer = e.currentTarget as MovieClip;
			playerIndex = playerArray.indexOf(e.currentTarget);
			
			playerColorChange();
			removePlayerListeners();      
		}
		
		function playerColorChange()
		{
			for (var i:uint = 0; i < playerArray.length; i++)
			{
				playerColor = Math.random() * 0xFFFFFF;
			
				playerColorTransform.color = playerColor
				playerArray[i].transform.colorTransform = playerColorTransform;
			}
		}
		function createNewPlayer()
		{
			for (var s:uint = 0; s < playerArray.length; s++)
			{
				destroyPlayer(playerArray[s]);
				createPlayer = false
			}
		}
		function playerScoreBar()
		{
			TweenNano.to(scoreB,2,{width:playerScore});
			TweenNano.to(scoreB2,2,{width:oppositeScore});
			if(resetScore == true)
			{
				playerScore = 1+minScoreLimit;
				oppositeScore = 1200-minScoreLimit; 
				resetScore = false;
			}
			levelss()
			
			if(playerScore >= MaxScoreLimit)
			{
				backColorState = false;
				scoreBar2Color = Math.random() * 0xFFFFFF; 
			
				levesNum += 1;
				resetScore = true;
			}
			if(playerScore <= 0)
			{
				levesNum -= 1;
				playerScore = 1;
			}
			
			if(oppositeScore >=1200)
			{
				oppositeScore = 1200;
			}
		}
		function levelss()
		{
			if(levesNum <= 0)
			{
				scoreType1 = 300;
				scoreType2 = 20;
				minScoreLimit = 0;
				levesNum = 0;
			}
			
			if(levesNum == 1)
			{
				minScoreLimit = 100;
				scoreType1 = 250;
				scoreType2 = 40;
			}
			if(levesNum == 2)
			{
				minScoreLimit = 200;
				scoreType1 = 200;
				scoreType2 = 60;
			}
			if(levesNum == 3)
			{
				minScoreLimit = 300;
				scoreType1 = 150;
				scoreType2 = 80;
			}
			if(levesNum >= 4)
			{
				minScoreLimit = 400;
				scoreType1 = 100;
				scoreType2 = 100;
			}
			
		}
		public function gL(myEvent:Event):void
		{
			trace(levesNum)
			
			if(shapesState == false)
			{
				myCount ++;
				
				if(createPlayer == false)
				{
					playerType = Math.round(Math.random() * 1);
					
					if(playerType == 0)
					{
						playerSize =  randomRange(5,20)
					}
					if(playerType == 1)
					{
						playerSize =  randomRange(5,10)
					}
					
					drawPlayer(playerSize);
					createPlayer = true;
				}
				if(myCount > 10)
				{
					shapesState = true;
					myCount = 0;
				}
			}
			if ((shapesState == true))  
			{   
				addAllShapeOnStage()
				findBoth = true;
				shapesState = false;
			}
			
			targetOnStage();
			addListeners();
			duplicateCircle();
			playerScoreBar()
		}
		function addAllShapeOnStage()
		{
			
			xPoss = randomRange(50,1150);
			yPoss = randomRange(680,700);
			radius = randomRange(minSize,maxSize)
			shapesColor = Math.random() * 0xFFFFFF;
		
			if(myShapesArray.length < numOfShapes)
			{
				allShapes(xPoss,yPoss,radius);
			}
		}
		public function allShapes(x1:Number,y1:Number,radius:Number)
		{
				
			var thisShape:MovieClip = new MyShape(this);
			thisShape.graphics.beginFill(shapesColor,1);
			
			thisShape.graphics.drawCircle(0,0,radius);
		
			thisShape.graphics.endFill();
			this.addChild(thisShape);
			myShapesArray.push(thisShape);
		
			thisShape.x = x1;
			thisShape.y = y1;
		}
		
		
		
		public function addListeners():void
		{
			for (var i:uint = 0; i < myShapesArray.length; i++)
			{
				myShapesArray[i].buttonMode = true;
				myShapesArray[i].addEventListener(MouseEvent.CLICK,clickHandler);
			}
		}
		public function removeListeners():void
		{
			for (var i:uint = 0; i < myShapesArray.length; i++)
			{
				myShapesArray[i].buttonMode = false;
				myShapesArray[i].removeEventListener(MouseEvent.CLICK,clickHandler);
			}
		}

		public function clickHandler(e:MouseEvent):void
		{
			selectedSprite = e.currentTarget as MovieClip;
			currentIndex = myShapesArray.indexOf(e.currentTarget);
			
			shapesColor = Math.random() * 0xFFFFFF;
			newShapeColorTransform.color = shapesColor ;
			selectedSprite.transform.colorTransform = newShapeColorTransform;
			
			//trace(selectedSprite.transform.colorTransform.color.toString(16))
			//trace(shapesColor.toString(16))
			
			removeListeners();
			
			//trace(currentIndex);
			selectedSprite.addEventListener(Event.ENTER_FRAME, spriteEnterFrame);
		}
		
		function spriteEnterFrame(event:Event):void
		{
			//selectedSprite.alpha = .5;
		}
		
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}

		function twoPointsDistance(x1:Number, x2:Number,  y1:Number, y2:Number)
		{
			var xDist:Number = x1 - x2;
			var yDist:Number = y1 - y2;
			return Math.sqrt(xDist * xDist + yDist * yDist);
		}
	
        public function destroyPlayer(newPlayer:MovieClip):void
		{
			var thisPlayer:MovieClip;

			for (var i:uint = 0; i < playerArray.length; i++)
			{
				thisPlayer = playerArray[i];

				if ((thisPlayer == newPlayer))
				{
					playerArray.splice(i,1);
					newPlayer.parent.removeChild(newPlayer) 
					newPlayer = null;
				}
			}
		}
		public function destroyShapes(myTemp:MovieClip):void
		{
			var thisShape:MovieClip;

			for (var i:uint = 0; i < myShapesArray.length; i++)
			{
				thisShape = myShapesArray[i];

				if (thisShape == myTemp)
				{
					myShapesArray.splice(i,1);
					this.removeChild(myTemp);
					myTemp = null;
				}
			}
		}
		public function destroyExploShape(myExplo:MovieClip):void
		{
			var thisExplo:MovieClip;

			for (var i:uint = 0; i < exploShapesArray.length; i++)
			{
				thisExplo = exploShapesArray[i];

				if (thisExplo == myExplo)
				{
					exploShapesArray.splice(i,1);
					this.removeChild(myExplo);
					myExplo = null;
				}
			}
		}
		function kDown(event:KeyboardEvent):void
		{  
			if (event.keyCode == 32)
			{
				backColorState = false
				createNewPlayer();
			}
		}

		public function mouseClick(event:MouseEvent):void
		{ 
			
		}

	}

}