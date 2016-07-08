package  
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import fl.motion.Color;
	
	public class Main extends MovieClip
	{		
		public var player:MovieClip;
		public var playerSpeed:Number = 20;
		public var playerArray:Array = new Array();
		public var playerColor = Math.random() * 0xFFFFFF;
		public var playerOutColor:uint = Math.random() * 0xFFFFFF;
		public var playerColorTransform = new ColorTransform()  ;
		
		public var missileColor:uint = Math.random() * 0xFFFFFF;
		public var missileColorTransform = new ColorTransform()  ;
		public var reloadComplete:String = "idle";
		public var numberOfMissiles:Number = 3;
		public var missileSpeed:Number = 4;
		public var turnRate:Number = .7;
		public var distanceX:Number = 0;
		public var distanceY:Number = 0;
		public var moveX:Number = 0;
		public var moveY:Number = 0;
		public var targetX:Number = 0;
		public var targetY:Number = 0;
		public var getEnemyIndex:Number = 0;
		public var missileArray:Array = new Array();
		
		public var trailerArray:Array = new Array();
		public var trailerColor:uint = Math.random() * 0xFFFFFF;		
		public var trailerColorTransform = new ColorTransform()  ;
		
		public var particlesArray:Array = new Array();
		public var minFragments:Number = 5;
		public var maxFragments:Number = 20;
		public var fragmentRange:Number = 80;
		public var totalFragments:Number = randomRange(minFragments,maxFragments);
		
		public var enemySpawn:Boolean = false;
		public var enemyArray:Array = new Array() ;
		public var maxEnemies:uint = 50;
		public var enemyCreator:Number = 0;
		public var enemyCreatorState:Boolean = false;
		
		public var colorTransSwitch:String = "idle";
		public var colorTransNum:Number = 0;
		public var curVal:Number= 0;
		public var backColor1 = 0xFF0000;
		public var backColor2 = 0x0000FF;
		
		public function Main() 
		{
			createPlayer();
			stage.addEventListener(Event.ENTER_FRAME, gameLoop);
			stage.addEventListener(MouseEvent.CLICK,mouseClick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
		}
		
		public function createPlayer():void
		{
			player = new MovieClip();
			player.graphics.beginFill(playerColor,1);
			player.graphics.drawCircle(0,0,randomRange(10,20));
			player.graphics.endFill();
			
			//player = new Player();
			player.x = stage.stageWidth / 2;
			player.y = stage.stageHeight / 2;
			stage.addChild(player);
			playerArray.push(player);
			
		}
		function MovePlayer()
		{
			player.x += (stage.mouseX - player.x) / playerSpeed;
			player.y += (stage.mouseY - player.y) / playerSpeed;
			
			rotatePlayer();
			
			for (var i:uint = 0; i < enemyArray.length; i++)
			{
				if(circularCollision(player,enemyArray[i]))
				{
					PlayerColour();
					//destroyer(enemyArray[i]);
					enemyCreatorState = true;
				}
				else
				{
					enemyCreatorState = false;
				}
			}
			
		}
		function PlayerColour()
		{
			playerColor = Math.random() * 0xFFFFFF;
			playerColorTransform.color = playerColor
			player.transform.colorTransform = playerColorTransform;
		}
		function EnemyGlow()
		{
			
			var radius:Number = (Math.random() * 3)+1;
			var glowAlpha:Number = Math.random() * .8;
			var glowBlurX:Number = 5;
			var glowBlurY:Number = 5;
			var glowStrength:Number = 2;
			var glowQuality:Number = 3;
			var glowColor:uint = Math.random() * 0xFFFFFF;
			var filterGlow:GlowFilter = new GlowFilter(glowColor,glowAlpha,glowBlurX,glowBlurY,glowStrength,glowQuality);
			
			for (var i:uint = 0; i < enemyArray.length; i++)
			{
				enemyArray[i].filters = [filterGlow];
			}
		}
		
		function createEnemy()
		{
			EnemyGlow();
			var radius:Number = (Math.random() * 3)+1;
			
			var myEnemies:MovieClip = new Enemies();
			this.addChild(myEnemies);
			enemyArray.push(myEnemies);
			
			if(enemySpawn == false)
			{
				myEnemies.x = stage.mouseX;
				myEnemies.y = stage.mouseY;
			}
			if(enemySpawn == true)
			{
				myEnemies.x = randomRange(100,stage.stageWidth-100);
				myEnemies.y =randomRange(100,stage.stageHeight-100);
			}
			//myEnemies.alpha = Math.random() * 2;
			
			var sizeScale:Number = radius; 
			myEnemies.scaleX = sizeScale;
			myEnemies.scaleY = sizeScale;	
			
			myEnemies.EnemyLoop();
			
			if(enemyArray.length > maxEnemies)
			{   
				destroyer(myEnemies);
			}
		}
		public function controlEnemy()
		{
			for (var i:uint = 0; i < enemyArray.length; i++)
			{
				if(enemyArray.length > maxEnemies)
				{   
					destroyer(enemyArray[i]);
					enemyArray.pop();
				}
			}
		}
		public function removeEnemy() 
		{
			for (var i:uint = 0; i < enemyArray.length; i++)
			{
				destroyer(enemyArray[i]);
			}
		}

		public function createMissile()
		{
			var tempMissile:MovieClip = new Missile();
			
			if(reloadComplete == "shoot")
			{
				this.addChild(tempMissile);
				missileArray.push(tempMissile);
				tempMissile.x = player.x;
				tempMissile.y = player.y;
				tempMissile.rotation = player.rotation-90; 
				
				moveX = 0;
				moveY = 0;	
				
				targetX = tempMissile.x;
				targetY = tempMissile.y;
				
				missileColour();
				
				reloadComplete = "counting";
			}
			if(reloadComplete == "counting")
			{
				for (var i:uint = 0; i < missileArray.length; i++)
				{
					followEnemy(missileArray[i], enemyArray[getEnemyIndex]);
				}
			}
		}
		function missileColour()
		{
			for (var i:uint = 0; i < missileArray.length; i++)
			{
				missileColor = Math.random() * 0xFFFFFF;
				missileColorTransform.color = missileColor
				missileArray[i].transform.colorTransform = missileColorTransform;
			}
		}
		public function removeMissile() 
		{
			for (var i:uint = 0; i < missileArray.length; i++)
			{   
				CreateParticles(missileArray[i]);
				destroyMissiles(missileArray[i]);
			}
		}
		public function followEnemy(follower:MovieClip, target:MovieClip)
		{
			distanceX = target.x - follower.x;
			distanceY = target.y - follower.y;
			
			var distanceTotal:Number = Math.sqrt(distanceX * distanceX + distanceY * distanceY);
			
			var moveDistanceX:Number  = turnRate * distanceX / distanceTotal;
			var moveDistanceY:Number  = turnRate * distanceY / distanceTotal;
			
			moveX += moveDistanceX;
			moveY += moveDistanceY;
			
			var totalmove:Number = Math.sqrt(moveX * moveX + moveY * moveY);
			
			moveX = missileSpeed * moveX/ totalmove;
			moveY = missileSpeed * moveY/ totalmove;
			
			follower.x += moveX;
			follower.y += moveY;
			
			follower.rotation = 180 * Math.atan2(moveY, moveX)/Math.PI;
			
			addSmokeTrailer(follower.x, follower.y);
			
			if(follower.hitTestObject(target))
			{
				destroyer(enemyArray[getEnemyIndex]);
				removeMissile(); 
			}
		}
		
		function addSmokeTrailer(targetX:Number, targetY:Number)
		{
			var trailer:MovieClip = new Smoke(this);
			this.addChild(trailer);
			trailerArray.push(trailer);
			trailer.x = targetX;
			trailer.y = targetY;
			
			trailer.rotation = Math.random() *360;
			
			var randomScale:Number = Math.random() * 1;
			trailer.scaleX = randomScale;
			trailer.scaleY = randomScale;
			
			trailerColor = missileColor;
			trailerColorTransform.color = trailerColor
			trailer.transform.colorTransform = trailerColorTransform;
			
		}
		public function CreateParticles(tempp:MovieClip)
		{
			for (var i:Number = 0; i < totalFragments; i++)
			{
				var myParti:MovieClip = new Particles(this);
				myParti.graphics.beginFill(0x333333,1);
				myParti.graphics.drawCircle(0,0,randomRange(2,10));
				myParti.graphics.endFill();
				this.addChild(myParti);
				particlesArray.push(myParti);
              
				myParti.x = tempp.x;
				myParti.y = tempp.y;
			}
		}
		public function activateMissile()
		{
			if(missileArray.length<1 && enemyArray.length>0)
			{   
				getEnemyIndex = randomRange(0,enemyArray.length-1);
				reloadComplete = "shoot";
			}
		}
		public function gameLoop(event:Event):void
		{
			//trace(playerArray.length+"   "+enemyArray.length+"  "+missileArray.length+"  "+enemyCreator+"  "+enemyCreatorState)
			
			activateMissile();
			createMissile();
			controlEnemy();
			MovePlayer();
			backgroundColorTransition();
			
			if(enemyCreatorState == false)
			{
				enemyCreator ++;
				if(enemyCreator > 100)
				{
					enemySpawn = true;
					createEnemy();
					enemyCreator = 0;
				}
			}
			if(enemyCreatorState == true)
			{
				enemyCreator = 0;
			}
			
		}
		public function backgroundColorTransition()
		{
			if(colorTransSwitch == "goingUp")
			{
				colorTransNum += 2;
			}
			if(colorTransSwitch == "goingDown")
			{
				colorTransNum -= 2;
			}
			
			if(curVal <= 0)
			{
				colorTransSwitch = "goingUp";
				backColor2 = Math.random() * 0xFFFFFF;
			}
			if(curVal >= 1)
			{
				backColor1 = Math.random() * 0xFFFFFF;
				colorTransSwitch = "goingDown"
			}
			
			curVal = colorTransNum/255;
			stage.color = Color.interpolateColor(backColor1,backColor2,curVal);
			
		}
		function circularCollision(mc1:MovieClip,mc2:MovieClip)
		{
			var colliding:Boolean = false;
			var radiusOfBoth:Number = (mc1.width/2) + (mc2.width/2);
			var distance:Number = getDistance(mc1.x - mc2.x, mc1.y - mc2.y);
			
			if (distance <= radiusOfBoth) 
			{
				colliding = true;
			}
			else 
			{				
			}
			return colliding;
		}
		
		public function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
		public function getDistance(deltaX:Number, deltaY:Number):Number
		{
			return Math.sqrt((deltaX*deltaX)+(deltaY*deltaY));
		}
		public function getDistance2(x1:Number, x2:Number,  y1:Number, y2:Number)
		{
			var xDist:Number = x1 - x2;
			var yDist:Number = y1 - y2;
			return Math.sqrt(xDist * xDist + yDist * yDist);
		}
		public function getRadians(deltaX:Number, deltaY:Number):Number
		{
			var radian:Number = Math.atan2(deltaY, deltaX);
			
			if (deltaY < 0)
			{
				radian += (2 * Math.PI);
			}
			return radian;
		}
		public function getDegrees(radians:Number):Number
		{
			return Math.floor(radians/(Math.PI/180));
		}
		public function rotatePlayer():void
		{
			var rotationDirection:Number = Math.round(180 - ((Math.atan2(stage.mouseX - player.x, stage.mouseY - player.y)) * 180/Math.PI));
			player.rotation = rotationDirection;
		}
		public function destroyer(myMc:MovieClip):void
		{
			var thisMc:MovieClip;

			for (var i:uint = 0; i < enemyArray.length; i++)
			{
				thisMc= enemyArray[i];

				if (thisMc == myMc)
				{
					enemyArray.splice(i,1);
					myMc.parent.removeChild(myMc) 
				}
			}
		}
		public function destroyMissiles(miss:MovieClip):void
		{
			var thisMiss:MovieClip;

			for (var i:uint = 0; i < missileArray.length; i++)
			{
				thisMiss= missileArray[i];

				if (thisMiss == miss)
				{
					missileArray.splice(i,1);
					miss.parent.removeChild(miss) 
				}
			}
		}
		public function destroyParticles(myParticle:MovieClip):void
		{
			var thisParti:MovieClip;

			for (var i:uint = 0; i < particlesArray.length; i++)
			{
				thisParti = particlesArray[i];

				if (thisParti == myParticle)
				{
					particlesArray.splice(i,1);
					this.removeChild(myParticle);
					myParticle = null;
				}
			}
		}
		public function destroyTrailer(myTrailer:MovieClip):void
		{
			var thisTrailer:MovieClip;

			for (var i:uint = 0; i < trailerArray.length; i++)
			{
				thisTrailer = trailerArray[i];

				if (thisTrailer == myTrailer)
				{
					trailerArray.splice(i,1);
					this.removeChild(myTrailer);
					myTrailer = null;
				}
			}
		}
		function mouseClick(event:MouseEvent):void
		{   
			enemySpawn = false;
			createEnemy()
		}
		function kDown(event:KeyboardEvent):void
		{  
			if (event.keyCode == 32)
			{
				//removeEnemy(); 
			}
		}
		
	}
	
}