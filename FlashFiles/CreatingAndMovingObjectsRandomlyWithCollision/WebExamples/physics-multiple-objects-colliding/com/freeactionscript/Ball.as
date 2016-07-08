/**
 * Simple Physics
 * ---------------------
 * VERSION: 1.1
 * DATE: 07/31/2011
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.FreeActionScript.com
 **/
package com.freeactionscript 
{
	import flash.display.MovieClip;
	
	public class Ball extends MovieClip
	{
		// data
		private var _velocityX:Number = 0;
		private var _velocityY:Number = 0;
		private var _speed:Number;
		private var _mass:Number;
		private var _radius:Number;
		private var _radians:Number;
		
		/**
		 * Ball Constructor
		 * @param	x
		 * @param	y
		 * @param	rotation
		 * @param	speed
		 * @param	radius
		 * @param	mass
		 */
		public function Ball(x:Number, y:Number, radius:Number, rotation:Number, speed:Number, mass:Number) 
		{
			// set parameters
			this.x = x;
			this.y = y;
			this.radius = radius;
			this.rotation = rotation;
			this.speed = speed;
			this.mass = mass;
			
			// calculate the other vars
			this.radians = this.rotation * Math.PI / 180;
			this.velocityX = Math.cos(this.radians) * this.speed;
			this.velocityY = Math.sin(this.radians) * this.speed;
			
			// draw ball
			this.graphics.lineStyle(1);
			this.graphics.beginFill(0xCCCCCC);
			this.graphics.drawCircle(0, 0, radius);
			this.graphics.endFill();
		}
		
		//////////////////////////////////////
		// Getters & Setters
		//////////////////////////////////////
		
		public function get speed():Number 
		{
			return _speed;
		}
		
		public function set speed(value:Number):void 
		{
			_speed = value;
		}
		
		public function get mass():Number 
		{
			return _mass;
		}
		
		public function set mass(value:Number):void 
		{
			_mass = value;
		}
		
		public function get radius():Number 
		{
			return _radius;
		}
		
		public function set radius(value:Number):void 
		{
			_radius = value;
		}
		
		public function get radians():Number 
		{
			return _radians;
		}
		
		public function set radians(value:Number):void 
		{
			_radians = value;
		}
		
		public function get velocityX():Number
		{
			return _velocityX;
		}
		
		public function set velocityX(value:Number):void 
		{
			_velocityX = value;
		}
		
		public function get velocityY():Number
		{
			return _velocityY;
		}
		
		public function set velocityY(value:Number):void 
		{
			_velocityY = value;
		}
		
	}
	
}