/**
 * Enemy Manager - Enemy Class
 * ---------------------
 * VERSION: 1.1.0
 * DATE: 8/23/2011
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.FreeActionScript.com
 **/
package com.freeactionscript.ai 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	public class Enemy extends MovieClip
	{
		// vars
		private var _myName:String;
		private var _skin:DisplayObjectContainer;
		private var _distanceToTarget:Number;
		
		/**
		 * Constructor
		 */
		public function Enemy(skin:DisplayObjectContainer) 
		{
			_skin = skin
			
			addChild(skin);
		}
		
		//////////////////////////////////////
		// Getters and Setters
		//////////////////////////////////////
		public function get myName():String 
		{
			return _myName;
		}
		
		public function set myName(value:String):void 
		{
			_myName = value;
		}
		
		public function get skin():DisplayObjectContainer 
		{
			return _skin;
		}
		
		public function set skin(value:DisplayObjectContainer):void 
		{
			_skin = value;
		}
		
		public function get distanceToTarget():Number 
		{
			return _distanceToTarget;
		}
		
		public function set distanceToTarget(value:Number):void 
		{
			_distanceToTarget = value;
		}
		
	}

}