/**
 * Simple Physics with Friction
 * ---------------------
 * VERSION: 1.1
 * DATE: 07/31/2011
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.FreeActionScript.com
 **/
package com.freeactionscript
{
	import flash.display.DisplayObjectContainer;
	import com.freeactionscript.Ball;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class SimplePhysics
	{
		// reference to container (stage, movieclip or sprite)
		private var _canvas:DisplayObjectContainer;
		
		// boundries
		private var _minX:int;
		private var _minY:int;
		private var _maxX:int;
		private var _maxY:int;
		
		// balls array
		private var _ballArray:Array = [];
		
		// settings
		private var _friction:Number = .98;
		
		/**
		 * Constructor
		 * @param	$canvas	Takes DisplayObjectContainer (MovieClip, Sprite, Stage)
		 */
		public function SimplePhysics($canvas:DisplayObjectContainer)
		{
			trace("SimplePhysics");
			
			_canvas = $canvas;
			setBoundries(_canvas);
		}
		
		/**
		 * Enables physics engine
		 */
		public function enable():void
		{
			_canvas.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		/**
		 * Disables physics engine
		 */
		public function disable():void
		{
			_canvas.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		/**
		 * Sets container boundries
		 */
		public function setBoundries($container:DisplayObjectContainer):void
		{
			_minX = 0;
			_minY = 0;
			_maxX = $container.width;
			_maxY = $container.height;
		}
		
		/**
		 * Use this to create multiple balls
		 * @param	numberOfBalls	Number of balls to create
		 */
		public function createBalls(numberOfBalls:Number):void
		{
			trace("Create balls: " + numberOfBalls);
			
			for (var i:int = 0; i < numberOfBalls; i++)
			{
				createBall();
			}
		}
		
		/**
		 * Use this to create a single ball
		 */
		public function createBall():void
		{
			// Create new ball
			// precalculate ball properties
			var newX:Number = Math.random() * _maxX;
			var newY:Number = Math.random() * _maxY;
			var newSpeed:Number = 2;
			var newRadius:Number = Math.random() * 20 + 10;
			var newRotation:Number = Math.floor(Math.random() * 360);
			
			// Ball(x, y, radius, rotation, speed, mass) 
			var ball:Ball = new Ball(newX, newY, newRadius, newRotation, newSpeed, newRadius);
			
			// test if ball can start here
			if (canStartHere(ball))
			{
				// add to display list
				_canvas.addChild(ball);
				
				// save ball in balls array
				_ballArray.push(ball)
			}
			// ball can't start here, try again
			else
			{
				createBall();
				return;
			}
		}
		
		/**
		 * Makes sure balls are not created inside other balls
		 * or outside container boundries
		 * @param	ball	Uses Ball object
		 * @return	true/false
		 */
		private function canStartHere(ball:Ball):Boolean
		{
			var retval:Boolean = true;
			
			// loop thru balls array
			for (var i:int = 0; i < _ballArray.length; i++)
			{
				// don't test hit on self
				if (ball == _ballArray[i] as Ball) continue;
				
				// make sure we dont start inside another ball
				if (hitTestCircle(ball, _ballArray[i] as Ball))
				{
					retval = false;
				}
				
				// make sure we dont start outside the container
				if (ball.x + ball.radius > _maxX || ball.x - ball.radius < _minX)
				{
					retval = false;
				}
				else if (ball.y + ball.radius > _maxY || ball.y - ball.radius < _minY)
				{
					retval = false;
				}
			}
			
			return retval;
		}
		
		/**
		 * Tests for collision between two Ball objects
		 * by calculating the distance between them
		 * @param	ball1	Uses Ball object
		 * @param	ball2	Uses Ball object
		 */
		private function hitTestCircle(ball1:Ball, ball2:Ball):Boolean
		{
			var retval:Boolean = false;
			
			var distance:Number = getDistance(ball1.x - ball2.x, ball1.y - ball2.y);
			
			if (distance <= (ball1.radius + ball2.radius))
			{
				retval = true;
			}
			return retval;
		}
		
		/**
		 * Update function that updates ball
		 */
		private function update():void 
		{
			// define common vars
			var tempBall1:Ball;			
			var i:int;
			var tempBall2:Ball;
			var k:int;
			
			// loop thru balls array
			for (i = 0; i < _ballArray.length; i++)
			{
				// save a reference to ball
				tempBall1 = _ballArray[i] as Ball;
				
				// check for collision with other balls
				for (k = 0; k < _ballArray.length; k++)
				{
					// save a reference to ball 2
					tempBall2 = _ballArray[k] as Ball;
					
					// make sure we dont test for collision against itself
					if (tempBall1 == tempBall2) continue;
					
					// check if balls are colliding by checking the distance between them
					if(hitTestCircle(tempBall1, tempBall2))
					{
						// calculate collision reaction
						collideBalls(tempBall1, tempBall2);
						
						// if balls are still touching after collision reaction,
						// try to move them apart
						if(hitTestCircle(tempBall1, tempBall2))
						{
							tempBall1.x += tempBall1.velocityX;
							tempBall1.y += tempBall1.velocityY;
							tempBall2.x -= tempBall1.velocityX
							tempBall2.y -= tempBall1.velocityY
						}
					}
				}
				
				// Bounce off walls
				// Check if we hit top
				if (((tempBall1.x - tempBall1.radius) < _minX) && (tempBall1.velocityX < 0))
				{
					// reverse velocity
					tempBall1.velocityX = -tempBall1.velocityX;
				}
				// Check if we hit bottom
				else if ((tempBall1.x + tempBall1.radius) > _maxX && (tempBall1.velocityX > 0))
				{
					// reverse velocity
					tempBall1.velocityX = -tempBall1.velocityX;
				}
				// Check if we hit left side
				if (((tempBall1.y - tempBall1.radius) < _minY) && (tempBall1.velocityY < 0))
				{
					// reverse velocity
					tempBall1.velocityY = -tempBall1.velocityY
				}
				// Check if we hit right side
				else if (((tempBall1.y + tempBall1.radius) > _maxY) && (tempBall1.velocityY > 0))
				{
					// reverse velocity
					tempBall1.velocityY = -tempBall1.velocityY;
				}
				
				// apply friction to ball velocity
				//tempBall1.velocityX *= _friction;
				//tempBall1.velocityY *= _friction;
				
				// update position based on velocity
				tempBall1.x += tempBall1.velocityX;
				tempBall1.y += tempBall1.velocityY;
			}
		}
		
		/**
		 * Collision reaction
		 * @param	ball1	Takes Ball object
		 * @param	ball2	Takes Ball object
		 */
		private function collideBalls(ball1:Ball, ball2:Ball):void
		{
			// calculate the distance between center of balls with the Pytagorean theorem
			var dx:Number = ball1.x - ball2.x;
			var dy:Number = ball1.y - ball2.y;
			
			// calculate the angle of the collision in radians
			var collisionAngle:Number = Math.atan2(dy, dx);
			
			// calculate the velocity vector for each ball
			// using existing ball X & Y velocities
			var speed1:Number = Math.sqrt(ball1.velocityX * ball1.velocityX + ball1.velocityY * ball1.velocityY)
			var speed2:Number = Math.sqrt(ball2.velocityX * ball2.velocityX + ball2.velocityY * ball2.velocityY)
			
			// calculate the angle in radians for each ball using it's current velocities
			// Calculate the angle formed by vector velocity of each ball, knowing your direction.
			var direction1:Number = Math.atan2(ball1.velocityY, ball1.velocityX);
			var direction2:Number = Math.atan2(ball2.velocityY, ball2.velocityX);
			
			// rotate the vectors counterclockwise so we can
			// calculate the conservation of momentum next
			var velocityX1:Number = speed1 * Math.cos(direction1 - collisionAngle);
			var velocityY1:Number = speed1 * Math.sin(direction1 - collisionAngle);			
			var velocityX2:Number = speed2 * Math.cos(direction2 - collisionAngle);
			var velocityY2:Number = speed2 * Math.sin(direction2 - collisionAngle);
			
			// take the mass of each ball and update their velocities based
			// on the law of conservation of momentum
			var finalVelocityX1:Number = ((ball1.mass - ball2.mass) * velocityX1 + (ball2.mass + ball2.mass) * velocityX2) / (ball1.mass + ball2.mass);
			var finalVelocityX2:Number = ((ball1.mass + ball1.mass) * velocityX1 + (ball2.mass - ball1.mass) * velocityX2) / (ball1.mass + ball2.mass);
			
			// Y velocities stay constant
			// because this is an 1D environment collision
			var finalVelocityY1:Number = velocityY1;
			var finalVelocityY2:Number = velocityY2;
			
			// after we have our final velocities, we rotate the angles back
			// so that the collision angle is preserved
			ball1.velocityX = Math.cos(collisionAngle) * finalVelocityX1 + Math.cos(collisionAngle + Math.PI / 2) * finalVelocityY1;
			ball1.velocityY = Math.sin(collisionAngle) * finalVelocityX1 + Math.sin(collisionAngle + Math.PI / 2) * finalVelocityY1;
			ball2.velocityX = Math.cos(collisionAngle) * finalVelocityX2 + Math.cos(collisionAngle + Math.PI / 2) * finalVelocityY2;
			ball2.velocityY = Math.sin(collisionAngle) * finalVelocityX2 + Math.sin(collisionAngle + Math.PI / 2) * finalVelocityY2;
			
			// add velocity to ball positions
			ball1.x += ball1.velocityX;
			ball1.y += ball1.velocityY;			
			ball2.x += ball2.velocityX;
			ball2.y += ball2.velocityY;
		}
		
		//////////////////////////////////////
		// Event Handlers
		//////////////////////////////////////
		
		/**
		 * EnterFrame handler
		 * @param	e
		 */
		private function onEnterFrame(e:Event):void 
		{
			update();
		}
		
		//////////////////////////////////////
		// Utilities
		//////////////////////////////////////
		
		/**
		 * Get distance
		 * @param	delta_x
		 * @param	delta_y
		 * @return
		 */
		public function getDistance(delta_x:Number, delta_y:Number):Number
		{
			return Math.sqrt((delta_x*delta_x)+(delta_y*delta_y));
		}
		
		/**
		 * Get radians
		 * @param	delta_x
		 * @param	delta_y
		 * @return
		 */
		public function getRadians(delta_x:Number, delta_y:Number):Number
		{
			var r:Number = Math.atan2(delta_y, delta_x);
			
			if (delta_y < 0)
			{
				r += (2 * Math.PI);
			}
			return r;
		}
		
		/**
		 * Get degrees
		 * @param	radians
		 * @return
		 */
		public function getDegrees(radians:Number):Number
		{
			return Math.floor(radians/(Math.PI/180));
		}
	}
}