package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.text.*;
	import fl.motion.Color;
	import com.greensock.*;
	import com.greensock.easing.*;

	public class Main extends MovieClip
	{  
		public var myShape:Sprite = new Sprite();
		public var circlee:Sprite = new Sprite();
		
		public var dColor:uint = Math.random() * 0xFFFFFF;
		public var myShapeColor:uint = Math.random() * 0xFFFFFF;
		public var myShapeOutColor:uint = Math.random() * 0xFFFFFF;
		
		public var platColorTransform = new ColorTransform  ;
		public var myShapeColorTransform = new ColorTransform  ;
		public var playerColorState:Boolean = false;
		public var diamondColorTransform = new ColorTransform  ;
		
		public var platformArray:Array = new Array();
		public var bigSquare:Array = new Array();
		public var arrayOfLittleSquare:Array = new Array();
		public var particlesArray:Array = new Array();
		
		public var thickness:Number = 0;
		public var transparency:Number = 1;
		public var numOfBoxes:uint = 17;
		public var platformBoxesNum:uint = 20;
		public var cols:uint = 5;
		
		public var s1X:Number = 0;
		public var s1Y:Number = 0;
		public var lenggth:Number = 10;
		public var cSize:Number = 0;
		public var onOffState:Number = 0;
		
		public var jumpState:String = "idle";
		public var platformType:String = "onFloor";
		
		public var left:Boolean = false;
		public var right:Boolean = false;
		public var up:Boolean = false;
		public var down:Boolean = false;
		public var onFloor:Boolean = false;
		public var stopCountState:Boolean = false;
		public var moveStatee:Boolean = false;
		
		public var ySpeed:Number = 0;
		public var leftForce:Number = 1.5;
		public var rightForce:Number = 1.5;
		public var rightSpeed:Number = 4;
		public var leftSpeed:Number = 4;
		public var flooor:Number = 0;
		
		public var downForce:Number = 5;
		public var gravity:Number = 2 ;
		public var speedMax:Number = 25;
		public var jumpingCount:Number = 0;
		public var currentPos:Number = 0;
		public var oldPos:Number = 0;
		public var oldY:Number = 0;
		public var Offset:Number = 100;
		
		public var createPlatCount:Number = 0;
		public var createPlat:Boolean = false;

		public var transitionTime:Number = 1;
		
		public var myColor:uint; // = Math.random()*0xB19210;
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		public var color1:uint;
		public var color2:uint;
		public var colorTransit:ColorTransform = new ColorTransform  ;
		
		public var myRotation:Number = 0;
		
		public var xDist:Number = 0;
		public var yDist:Number = 0;
		public var closestObjectDist:Number = 0;
		
		public var minNum:Number = 0;
		public var getMinNum:Number  = 0;
		public var closestObject:Number = 0;
		
		public var scoreNum:int = 0;
		public var scoreDiff:int = 0;
		public var diamondAlphaSpeed:Number = 0;
		
		public var changeShapee:Boolean = false;
		public var d:Sprite = new Sprite()
		
		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,kUp);
			
			createSmallShapes();
			
			playerColor();
			myShape.x = 0+lenggth;
			myShape.y = floorr.y-(myShape.height/2);
			createPlatforms();
			
			diamond();
			
		}
		
		public function createPlatforms()
		{
			
			if(platformArray.length < platformBoxesNum) 
			{
				var myPlatform:Platform = new Platform(); 
				stage.addChild(myPlatform);
					
				myPlatform.x = randomRange(150,stage.stageWidth-150);
				myPlatform.y = randomRange(-20,-50);
					
				platformArray.push(myPlatform);
			}
			
		}
		
		function createSmallShapes()
		{
			for (var i:uint = 0; i < numOfBoxes; i++) 
			{
				var littleShapes:Sprite = new Sprite();
				drawShape(littleShapes,10,10);
				addChild(littleShapes);
				arrayOfLittleSquare.push(littleShapes);
			}
		}
		function drawShape(sprite:Sprite,Width:Number,Height:Number)
		{
			//sprite.graphics.beginFill(0x0000FF);
			//sprite.graphics.drawCircle(0, 0, 4); 
			sprite.graphics.moveTo(-Width/2,-Height/2);
			sprite.graphics.lineTo(Width/2,-Height/2);
			sprite.graphics.lineTo(Width/2,Height/2);
			sprite.graphics.lineTo(-Width/2,Height/2);
			sprite.graphics.lineTo(-Width/2,-Height/2);
			sprite.graphics.endFill();
		}
		
		function drawDynamicShape(sprite:Sprite)
		{
			sprite.graphics.clear();
			sprite.graphics.lineStyle(thickness,myShapeOutColor,1,true);
			sprite.graphics.beginFill(myShapeColor,transparency);
			
			sprite.graphics.moveTo(arrayOfLittleSquare[0].x,arrayOfLittleSquare[0].y);
			sprite.graphics.lineTo(arrayOfLittleSquare[1].x,arrayOfLittleSquare[1].y);
			sprite.graphics.lineTo(arrayOfLittleSquare[2].x,arrayOfLittleSquare[2].y);
			sprite.graphics.lineTo(arrayOfLittleSquare[3].x,arrayOfLittleSquare[3].y);
			sprite.graphics.lineTo(arrayOfLittleSquare[4].x,arrayOfLittleSquare[4].y);
			sprite.graphics.lineTo(arrayOfLittleSquare[5].x,arrayOfLittleSquare[5].y);
			sprite.graphics.lineTo(arrayOfLittleSquare[6].x,arrayOfLittleSquare[6].y);
			sprite.graphics.lineTo(arrayOfLittleSquare[7].x,arrayOfLittleSquare[7].y);
			sprite.graphics.lineTo(arrayOfLittleSquare[8].x,arrayOfLittleSquare[8].y);
			sprite.graphics.lineTo(arrayOfLittleSquare[9].x,arrayOfLittleSquare[9].y);
			sprite.graphics.lineTo(arrayOfLittleSquare[10].x,arrayOfLittleSquare[10].y);
			sprite.graphics.lineTo(arrayOfLittleSquare[11].x,arrayOfLittleSquare[11].y);
			sprite.graphics.lineTo(arrayOfLittleSquare[12].x,arrayOfLittleSquare[12].y);
			sprite.graphics.lineTo(arrayOfLittleSquare[13].x,arrayOfLittleSquare[13].y);
			sprite.graphics.lineTo(arrayOfLittleSquare[14].x,arrayOfLittleSquare[14].y);
			sprite.graphics.lineTo(arrayOfLittleSquare[15].x,arrayOfLittleSquare[15].y); 
			//sprite.graphics.drawCircle(arrayOfLittleSquare[16].x, arrayOfLittleSquare[16].y, cSize); 
			
			sprite.graphics.endFill();
			addChild(sprite);
			sprite.addChild(circlee);
			bigSquare.push(sprite)
			
			circlee.graphics.clear();
			circlee.graphics.lineStyle(thickness,myShapeOutColor,1,true);
			circlee.graphics.beginFill(myShapeColor,transparency);
			circlee.graphics.moveTo(0,0);
			for (var i:uint = 0; i <= 360; i++) 
			{
				circlee.graphics.lineTo(cSize*Math.cos(i*Math.PI/180), -cSize*Math.sin(i*Math.PI/180));
			}
			circlee.graphics.endFill();
			circlee.x = arrayOfLittleSquare[16].x;
			circlee.y = arrayOfLittleSquare[16].y;
			
			for (var s:uint = 0; s < bigSquare.length; s++)
			{
				if(bigSquare.length > 0)
				{
					bigSquare.splice(s,1);
				}
			}
		}
	
		function playerColor()
		{
			myShapeColor = Math.random() * 0xFFFFFF;
			myShapeColorTransform.color = myShapeColor
			myShape.transform.colorTransform = myShapeColorTransform;
		}
		function createParticles() 
		{
			var parti:Particles = new Particles();
			parti.x = myShape.x;
			parti.y = myShape.y;
			
			var scaleFactor:Number = myShape.height/50;
			parti.scaleX= scaleFactor;
			parti.scaleY= scaleFactor;
			
			this.addChild(parti);
			particlesArray.push(parti);
			
			for (var s:uint = 0; s < particlesArray.length; s++)
			{
				if (particlesArray[s].alpha<0 ) 
				{
					particlesArray.splice(s,1);
				}
			}
		}
		public function diamond()
		{
			d.graphics.clear()
			d.graphics.beginFill(dColor,1)
			d.graphics.moveTo(0,0);
			d.graphics.lineTo(10,-20);
			d.graphics.lineTo(0,-40);
			d.graphics.lineTo(-10,-20);
			d.graphics.endFill()
			addChild(d);
			
			diamondPosition();
		}
		public function diamondPosition()
		{
			if(scoreNum<= 100)
			{
				d.alpha = 1
				d.x = randomRange(50,950);
				d.y = randomRange(50,650);
				
				dColor  = Math.random() * 0xFFFFFF;
				
				diamondColorTransform.color = dColor;
				d.transform.colorTransform = diamondColorTransform;
			}
			else
			{
				d.visible = false;
			}
		}
		public function gL(myEvent:Event):void
		{
			d.rotationY += 5;
			if(d.y>0)
			{
				diamondAlphaSpeed = .0005;
				scoreDiff = 5;
			}
			if(d.y>200)
			{
				diamondAlphaSpeed = .001;
				scoreDiff = 2;
			}
			if(d.y>450)
			{
				diamondAlphaSpeed = .005;
				scoreDiff = 1;
			}
			
			d.alpha -= diamondAlphaSpeed;
			if(d.alpha <= 0)
			{
				diamondPosition()
			}
			
			scoreText.text = String(scoreNum)
			
			if(scoreNum>= 100)
			{
				scoreNum = 100;
			}
			
			createPlatCount ++
			if(createPlatCount > 50)
			{
				createPlatforms();
				createPlatCount = 0;
			}
			for (var i:uint = 0; i < platformArray.length; i++)
			{
				if(platformArray[i].y<-50||platformArray[i].hitTestObject(floorr)||platformArray[i].x < -2||platformArray[i].alpha <= 0)
				{
					platformArray[i].PlatformDestructor();
					destroyPlatform(platformArray[i])
				}
				
			}
			
			for (var e:uint = 0; e < platformArray.length; e++)
			{
				
				var tempBall1:MovieClip = platformArray[e] as MovieClip;
				
				for (var k:uint = 0; k < platformArray.length; k++)
				{
					var tempBall2:MovieClip = platformArray[k] as MovieClip;
					
					if (tempBall1 == tempBall2) continue;
					if(tempBall1.hitTestObject(tempBall2))
					{   
						//tempBall2.xSpeed *= -1;
						//tempBall2.y -= .1;
						tempBall2.PlatformDestructor();
						destroyPlatform(tempBall2)
					}
					
				}
			}
			
			drawDynamicShape(myShape);
			playerTransition();
			playerMovement(); 
			colorTransition();
			
			currentPos = myShape.y;
			if (currentPos > oldPos)
			{
				jumpState = "Moving";
				//trace("falling")
				oldY = myShape.y;
			}
			if (currentPos < oldPos)
			{
				jumpState = "Moving";
				//trace("jumping")
			}
			else
			{
				jumpState = "notMoving";
				//trace("stopped")
			}
			oldPos = currentPos;
			
			for (var a:uint = 0; a < platformArray.length; a += 1)
			{   
				xDist = myShape.x - platformArray[a].x;
				yDist = myShape.y - platformArray[a].y;
				closestObjectDist = Math.sqrt(xDist * xDist + yDist * yDist);
				
				getMinNum = Math.abs(Math.sqrt(xDist * xDist + yDist * yDist)) 
				
				if(getMinNum < minNum || a == 0) 
				{ 
					minNum= getMinNum;
					closestObject = a;
				} 
				
			}
			
			//trace(myShape.y+"  "+oldY+"  "+platformArray[closestObject].y+"  "+ySpeed+"   "+speedMax+"  "+up+"  "+jumpState)
			if(myShape.hitTestObject(d))
			{   
				scoreNum += scoreDiff;
				diamondPosition();
			}
			if(myShape.hitTestObject(platformArray[closestObject]))
			{
				if(playerColorState == false)
				{
					platColorTransform.color = Math.random() * 0xFFFFFF;
					platformArray[closestObject].transform.colorTransform = platColorTransform;
					myShape.transform.colorTransform = platColorTransform;
					playerColorState = true;
				}
				platformArray[closestObject].alpha -= .1;
				
				myShape.y = oldY;
				up = false;
				//myShape.y = platformArray[closestObject].y-(myShape.height/2);
				
			}
			else if(myShape.hitTestObject(floorr))
			{
				up = false;
				myShape.y = floorr.y-(myShape.height/2);
			}
			
			if(!myShape.hitTestObject(platformArray[closestObject]))
			{
				if(up == false && myShape.y < 690 && jumpState == "notMoving")
				{
					up = true;
				}
				playerColorState = false;
			}
		
		}
		
		public function playerMovement()
		{
			if(myShape.x-(lenggth*2)< 0)
			{   
				leftSpeed = 0;  
				leftForce = 0;
			}
			if(myShape.x+(lenggth*2)> stage.width)
			{
				rightSpeed = 0;  
				rightForce = 0;
			}
			if(left == true)
			{
				rightSpeed = 4;  
				rightForce = 1.5;
				myShape.x -=  leftSpeed * leftSpeed;
			} 
			if(right == true)
			{   
				leftSpeed = 3;
				leftForce = 1.5; 
				myShape.x +=  rightSpeed * rightForce;
			}
			
			if(up == true)
			{
				createParticles() ;
				if(stopCountState == false)
				{
					jumpingCount++
				}
				
				ySpeed -= gravity;
				myShape.y -= ySpeed;
				
			}
			if(up == false)
			{
				jumpingCount = 0;
				stopCountState = false;
			}
				
			
			
		}
		public function playerTransition()
		{
			//trace(platformType+"  "+gravity+"  "+up+"  "+jumpState+"  "+myShape.y+"  "+(platformArray[0].y+lenggth)+"  "+flooor)
			//trace(left+"  "+right+"  "+up+"  "+jumpState+"   "+myRotation+"  "+flooor+"  "+myShape.y+" "+gravity+"  "+particlesArray.length)
			
			if(left == false && right == false && up == false)
			{
				if(changeShapee == false)
				{
					onOffState = randomRange(1,2);
					changeShapee = true;
				}
			}
			if(left == true || right == true || up == true )
			{
				onOffState = 0;
				changeShapee = false;
			}
		
			if(moveStatee == false)
			{
				if(!onOffState == 0)
				{
					cSize -= 3;
					if(cSize <= 0)
					{
						cSize = 0;
					}
				}
					
				if(onOffState == 0)
				{
					cSize += 3;
					if(cSize >= 10)
					{
						cSize = 10;
					}
					TweenNano.to(arrayOfLittleSquare[0], transitionTime, {x:s1X,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[1], transitionTime, {x:s1X,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[2], transitionTime, {x:s1X,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[3], transitionTime, {x:s1X,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[4], transitionTime, {x:s1X,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[5], transitionTime, {x:s1X,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[6], transitionTime, {x:s1X,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[7], transitionTime, {x:s1X,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[8], transitionTime, {x:s1X,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[9], transitionTime, {x:s1X,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[10], transitionTime, {x:s1X,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[11], transitionTime, {x:s1X,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[12], transitionTime, {x:s1X,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[13], transitionTime, {x:s1X,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[14], transitionTime, {x:s1X,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[15], transitionTime, {x:s1X,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[16], transitionTime, {x:s1X,y:s1Y});
				}
				if(onOffState == 1)
				{
					TweenNano.to(arrayOfLittleSquare[0], transitionTime, {x:s1X,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[1], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[2], transitionTime, {x:s1X+lenggth,y:s1Y+lenggth});
					TweenNano.to(arrayOfLittleSquare[3], transitionTime, {x:s1X-lenggth,y:s1Y+lenggth});
					TweenNano.to(arrayOfLittleSquare[4], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[5], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[6], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[7], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[8], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[9], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[10], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[11], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[12], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[13], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[14], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[15], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[16], transitionTime, {x:s1X,y:s1Y});
				}
				if (onOffState == 2)
				{
					TweenNano.to(arrayOfLittleSquare[0], transitionTime, {x:s1X,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[1], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[2], transitionTime, {x:s1X+lenggth,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[3], transitionTime, {x:s1X+lenggth,y:s1Y+lenggth});
					TweenNano.to(arrayOfLittleSquare[4], transitionTime, {x:s1X-lenggth,y:s1Y+lenggth});
					TweenNano.to(arrayOfLittleSquare[5], transitionTime, {x:s1X-lenggth,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[6], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[7], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[8], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[9], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[10], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[11], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[12], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[13], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[14], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[15], transitionTime, {x:s1X,y:s1Y-lenggth});
					TweenNano.to(arrayOfLittleSquare[16], transitionTime, {x:s1X,y:s1Y});
				}
				if (onOffState == 3)
				{
					TweenNano.to(arrayOfLittleSquare[0], transitionTime, {x:s1X,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[1], transitionTime, {x:s1X+(lenggth/2)+(lenggth/4),y:s1Y});
					TweenNano.to(arrayOfLittleSquare[2], transitionTime, {x:s1X+(lenggth/2),y:s1Y+(lenggth/2)+(lenggth/4)});
					TweenNano.to(arrayOfLittleSquare[3], transitionTime, {x:s1X-(lenggth/2),y:s1Y+(lenggth/2)+(lenggth/4)});
					TweenNano.to(arrayOfLittleSquare[4], transitionTime, {x:s1X-(lenggth/2)-(lenggth/4),y:s1Y});
					TweenNano.to(arrayOfLittleSquare[5], transitionTime, {x:s1X,y:s1Y-(lenggth/2)-(lenggth/4)});
					TweenNano.to(arrayOfLittleSquare[6], transitionTime, {x:s1X+(lenggth/2)+(lenggth/4),y:s1Y});
					TweenNano.to(arrayOfLittleSquare[7], transitionTime, {x:s1X+(lenggth/2)+(lenggth/4),y:s1Y});
					TweenNano.to(arrayOfLittleSquare[8], transitionTime, {x:s1X+(lenggth/2)+(lenggth/4),y:s1Y});
					TweenNano.to(arrayOfLittleSquare[9], transitionTime, {x:s1X+(lenggth/2)+(lenggth/4),y:s1Y});
					TweenNano.to(arrayOfLittleSquare[10], transitionTime, {x:s1X+(lenggth/2)+(lenggth/4),y:s1Y});
					TweenNano.to(arrayOfLittleSquare[11], transitionTime, {x:s1X+(lenggth/2)+(lenggth/4),y:s1Y});
					TweenNano.to(arrayOfLittleSquare[12], transitionTime, {x:s1X+(lenggth/2)+(lenggth/4),y:s1Y});
					TweenNano.to(arrayOfLittleSquare[13], transitionTime, {x:s1X+(lenggth/2)+(lenggth/4),y:s1Y});
					TweenNano.to(arrayOfLittleSquare[14], transitionTime, {x:s1X+(lenggth/2)+(lenggth/4),y:s1Y});
					TweenNano.to(arrayOfLittleSquare[15], transitionTime, {x:s1X+(lenggth/2)+(lenggth/4),y:s1Y});
					TweenNano.to(arrayOfLittleSquare[16], transitionTime, {x:s1X,y:s1Y});
				}
				if (onOffState == 4)
				{
					
					TweenNano.to(arrayOfLittleSquare[0], transitionTime, {x:s1X,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[1], transitionTime, {x:s1X+lenggth,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[2], transitionTime, {x:s1X+(lenggth/2),y:s1Y+(lenggth/2)+(lenggth/4)});
					TweenNano.to(arrayOfLittleSquare[3], transitionTime, {x:s1X-(lenggth/2),y:s1Y+(lenggth/2)+(lenggth/4)});
					TweenNano.to(arrayOfLittleSquare[4], transitionTime, {x:s1X-lenggth,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[5], transitionTime, {x:s1X-(lenggth/2),y:s1Y-(lenggth/2)-(lenggth/4)});
					TweenNano.to(arrayOfLittleSquare[6], transitionTime, {x:s1X+(lenggth/2),y:s1Y-(lenggth/2)-(lenggth/4)});
					TweenNano.to(arrayOfLittleSquare[7], transitionTime, {x:s1X+lenggth,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[8], transitionTime, {x:s1X+lenggth,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[9], transitionTime, {x:s1X+lenggth,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[10], transitionTime, {x:s1X+lenggth,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[11], transitionTime, {x:s1X+lenggth,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[12], transitionTime, {x:s1X+lenggth,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[13], transitionTime, {x:s1X+lenggth,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[14], transitionTime, {x:s1X+lenggth,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[15], transitionTime, {x:s1X+lenggth,y:s1Y});
					TweenNano.to(arrayOfLittleSquare[16], transitionTime, {x:s1X,y:s1Y});
				}
		}
		
		}
		
		public function colorTransition()
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
				colorTransSwitch = "goingDown"
			}
			
			curVal = colorTransNum/255;
			myColor = Color.interpolateColor(color1,color2,curVal);
			
			stage.color = myColor;
			//player.transform.colorTransform = colorTransit;
			
			
		}
		public function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
        public function destroyMyPlayer(newPlayer:MovieClip):void
		{
			var thisPlayer:MovieClip;

			for (var i:uint = 0; i < arrayOfLittleSquare.length; i++)
			{
				thisPlayer = arrayOfLittleSquare[i];

				if ((thisPlayer == newPlayer))
				{
					arrayOfLittleSquare.splice(i,1);
					newPlayer.parent.removeChild(newPlayer) 
					newPlayer = null;
				}
			}
		}
		public function destroyPlatform(newPlat:MovieClip):void
		{
			var thisPlat:MovieClip;

			for (var i:uint = 0; i < platformArray.length; i++)
			{
				thisPlat = platformArray[i];

				if ((thisPlat == newPlat))
				{
					platformArray.splice(i,1);
					newPlat.parent.removeChild(newPlat) 
					newPlat = null;
				}
			}
		}
		function kDown(event:KeyboardEvent):void
		{  
			
			if (event.keyCode == 38)
			{
				if(jumpingCount > 0)
				{
					ySpeed = speedMax;
					jumpingCount = 0;
					stopCountState = true;
					up = true;
				}
				if(up == false)
				{
					ySpeed = speedMax;
					up = true;
				}
			}
			
			if (event.keyCode == 37)
			{
				left = true;
			}
			if (event.keyCode == 39)
			{
				right = true;
			}
			
			if (event.keyCode == 32)
			{
				createPlatforms();
			}
		}
		function kUp(event:KeyboardEvent):void
		{ 
			
			if (event.keyCode == 38)
			{
				//up = false;
			}
			if (event.keyCode == 37)
			{
				left = false;
			}
			if (event.keyCode == 39)
			{
				right = false;
			}
			
		}

	}

}