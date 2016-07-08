package  
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	
	public class Enemies extends MovieClip 
	{
		public var refM:MovieClip;
		
		public var randomAction:Number = 0;
		public var xSpeed:Number = 0;
		public var ySpeed:Number = 0;
		public var enemySpeed:Number = 4;
		
		public var leftBorder:Number;
		public var topBorder:Number;
		public var rightBorder:Number;
		public var botBorder:Number;
		
		public var minX:Number;
		public var minY:Number;
		public var maxX:Number;
		public var maxY:Number;
		
		public var velocityX:Number = 0;
		public var velocityY:Number = 0;
		
		public var myColor:uint = Math.random() * 0xFFFFFF;
		public var myColorTransform = new ColorTransform  ;
		
		public function Enemies(){
		}
		
		public function EnemyLoop():void
		{
			this.addEventListener(Event.ENTER_FRAME, Loop);
			refM = MovieClip (this.parent);  
			
			getDirectionSpeed()
			
			leftBorder = (this.width/2);
			topBorder = (this.height/2);
			rightBorder = stage.stageWidth-(this.width/2);
			botBorder = stage.stageHeight-(this.height/2);
			
			minX = leftBorder;
			minY = topBorder;
			maxX = rightBorder;
			maxY = botBorder;
		}
		
		public function Loop(myEvent:Event):void
		{   
			updateMovement()
			
			if(this.x <= leftBorder)
			{
				xSpeed = Math.abs(xSpeed);
				changeColor()
			}
			else if(this.x >= rightBorder)
			{
				xSpeed = -xSpeed;
				changeColor()
			}
			this.x += xSpeed;
			
			if(this.y <= topBorder)
			{
				ySpeed = Math.abs(ySpeed);
				changeColor()
			}
			else if(this.y >= botBorder)
			{
				ySpeed = -ySpeed;
				changeColor()
			}
			this.y += ySpeed;
		}
		function getDirectionSpeed()
		{
			randomAction = refM.randomRange(0,1);
			
			if(randomAction == 0)
			{
				xSpeed = Math.random()*enemySpeed;
				ySpeed = Math.random()*enemySpeed;
			}
			if(randomAction == 1)
			{
				xSpeed = -Math.random()*enemySpeed;
				ySpeed = -Math.random()*enemySpeed;
			}
		}
		
		public function updateMovement():void 
		{	
			
			var tempBall1:MovieClip;			
			var tempBall2:MovieClip;
			
			for (var i:uint = 0; i < refM.enemyArray.length; i++)
			{
				
				tempBall1 = refM.enemyArray[i] as MovieClip;
				
				for (var k:uint = 0; k < refM.enemyArray.length; k++)
				{
					tempBall2 = refM.enemyArray[k] as MovieClip;
					
					if (tempBall1 == tempBall2) continue;
					
					if(refM.circularCollision(tempBall1,tempBall2))
					{
						var temp1ColorTransform = new ColorTransform  ;
						var temp2ColorTransform = new ColorTransform  ;
						temp1ColorTransform.color = Math.random() * 0xFFFFFF;
						temp2ColorTransform.color = Math.random() * 0xFFFFFF;
						tempBall1.transform.colorTransform = temp1ColorTransform;
						tempBall2.transform.colorTransform = temp2ColorTransform;
						
						refM.EnemyGlow();
						collideBalls(tempBall1, tempBall2);
						
						//tempBall1.alpha = Math.random()*2;
						//tempBall2.alpha = Math.random()*2;
						
						if(refM.circularCollision(tempBall1,tempBall2))
						{
							xSpeed *= -1
							ySpeed *= -1
							
							tempBall1.x += tempBall1.xSpeed;
							tempBall1.y += tempBall1.ySpeed;
							
							tempBall2.x -= tempBall1.xSpeed
							tempBall2.y -= tempBall1.ySpeed
						}
					}
				}
			
			}
			
		}
		public function collideBalls(circle1:MovieClip, circle2:MovieClip):void
		{
			var dx:Number = circle1.x - circle2.x;
			var dy:Number = circle1.y - circle2.y;
			var collisionAngle:Number = Math.atan2(dy, dx);
		
			var speed1:Number = Math.sqrt(circle1.xSpeed * circle1.xSpeed + circle1.ySpeed * circle1.ySpeed)
			var speed2:Number = Math.sqrt(circle2.xSpeed * circle2.xSpeed + circle2.ySpeed * circle2.ySpeed)
			
			var direction1:Number = Math.atan2(circle1.ySpeed, circle1.xSpeed);
			var direction2:Number = Math.atan2(circle2.ySpeed, circle2.xSpeed);
			
			var velocityX1:Number = speed1 * Math.cos(direction1 - collisionAngle);
			var velocityY1:Number = speed1 * Math.sin(direction1 - collisionAngle);			
			var velocityX2:Number = speed2 * Math.cos(direction2 - collisionAngle);
			var velocityY2:Number = speed2 * Math.sin(direction2 - collisionAngle);
			
			var mass1:Number = (circle1.width/2)
			var mass2:Number = (circle2.width/2)
			
			var finalVelocityX1:Number = ((mass1 - mass2) * velocityX1 + (mass2 + mass2) * velocityX2) / (mass1 + mass2);
			var finalVelocityX2:Number = ((mass1 + mass1) * velocityX1 + (mass2 - mass1) * velocityX2) / (mass1 + mass2);
			
			var finalVelocityY1:Number = velocityY1;
			var finalVelocityY2:Number = velocityY2;
			
			circle1.xSpeed = Math.cos(collisionAngle) * finalVelocityX1 + Math.cos(collisionAngle + Math.PI / 2) * finalVelocityY1;
			circle1.ySpeed = Math.sin(collisionAngle) * finalVelocityX1 + Math.sin(collisionAngle + Math.PI / 2) * finalVelocityY1;
			circle2.xSpeed = Math.cos(collisionAngle) * finalVelocityX2 + Math.cos(collisionAngle + Math.PI / 2) * finalVelocityY2;
			circle2.ySpeed = Math.sin(collisionAngle) * finalVelocityX2 + Math.sin(collisionAngle + Math.PI / 2) * finalVelocityY2;
			
			circle1.x += circle1.xSpeed;
			circle1.y += circle1.ySpeed			
			circle2.x += circle2.xSpeed
			circle2.y += circle2.ySpeed;
		}
		
		function changeColor()
		{
			myColor = Math.random() * 0xFFFFFF;
			myColorTransform.color = myColor;
			this.transform.colorTransform = myColorTransform;
		}

	}
	
}
