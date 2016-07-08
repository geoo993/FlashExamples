/**
 * Enemy Manager
 * 
 * - Create Enemies - does a check to make sure enemies don't start on top of each other
 * - Update Enemies - can be used to update enemy movement
 * - Get Closest Enemy - gets closest enemy to mouse
 * - Destroy Enemies - removes enemy
 * 
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
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	
	import com.freeactionscript.ai.Enemy;
	import com.freeactionscript.utils.MathTools;
	
	public class EnemyManager extends MovieClip
	{
		// container
		private var _container:DisplayObjectContainer;
		
		// shared vars
		private var _tempEnemy:Enemy;
		private var _colorTint:ColorTransform;
		
		// array that stores enemies
		private var _enemies:Array = [];
		
		/**
		 * Constructor
		 */
		public function EnemyManager(container:DisplayObjectContainer) 
		{
			// save a reference to container
			_container = container;
		}
		
		//////////////////////////////////////
		// Public API 
		//////////////////////////////////////
		
		/**
		 *  Creates default number of randomly positioned enemies
		 * @param	numberOfEnemies	Number of enemies to create
		 */
		public function createRandomEnemies(numberOfEnemies:Number):void
		{
			// while _enemies.length is less than numberOfEnemies
			// create enemies
			while (_enemies.length < numberOfEnemies)
			{
				// set random position based on stage width & height
				// without placing enemies outside of stage
				var newX:Number = Math.random() * 400 + 50;
				var newY:Number = Math.random() * 300 + 50;
				
				// create enemy
				createEnemy(newX, newY, "Default Enemy " + _enemies.length + "00");
			}
		}
		
		/**
		 * /**
		 * Use this to create an enemy at X & Y position
		 * 
		 * @param	x	Starting X position
		 * @param	y	Starting Y position
		 * @param	name	Enemy name
		 */
		public function createEnemy(x:Number, y:Number, name:String):void
		{
			// create a temporary variable
			// attach Enemy movieclip from the fla library
			_tempEnemy = new Enemy(new EnemySkin());
			
			// position enemy
			_tempEnemy.x = x;
			_tempEnemy.y = y;
			
			// check starting position
			if (!canStartHere(_tempEnemy))
			{
				// if not abort enemy creation
				_tempEnemy = null;
				return;
			}
			
			// set name
			_tempEnemy.myName = name;
			
			// add event listener
			_tempEnemy.addEventListener(MouseEvent.CLICK, onEnemyClick);
			
			// use hand cursor
			_tempEnemy.buttonMode = true;
			
			// add to _enemies array
			_enemies.push(_tempEnemy);
			
			// add to display list
			container.addChild(_tempEnemy);
		}
		
		/**
		 * Use this to destoy an enemy
		 * @param	whichEnemy
		 */
		public function destroyEnemy(whichEnemy:Enemy):void
		{
			var i:int;
			
			trace("whichEnemy " + whichEnemy);
			
			// loop thru enemies array to find whichEnemy
			for (i = 0; i < _enemies.length; i++)
			{
				// save a reference to enemy clip
				_tempEnemy = _enemies[i] as Enemy;
				
				// if enemy found
				if (_tempEnemy == whichEnemy)
				{
					trace("found enemy: " + _tempEnemy);
					// remove from array
					_enemies.splice(i, 1);
					
					// remove from display list
					container.removeChild(whichEnemy);
				}
			}
		}
		
		/**
		 * This function updates the enemy manager
		 */
		public function update():void
		{
			updateEnemies();
		}
		
		//////////////////////////////////////
		// Private Methods 
		//////////////////////////////////////
		
		/**
		 * Makes sure enemies are not created inside other enemies
		 * @param	targetClip	Takes enemy movieclip
		 * @return	true/false
		 */
		private function canStartHere(targetClip:MovieClip):Boolean
		{
			var retval:Boolean = true;
			
			for (var i:int = 0; i < _enemies.length; i++)
			{
				// don't test hit on self
				if (targetClip == _enemies[i] as MovieClip) continue;
				
				if (hitTestClips(targetClip, _enemies[i] as MovieClip))
				{
					retval = false;
				}
			}
			
			return retval;
		}
		
		/**
		 * Tests for collision between two MovieClip by calculating the distance between them
		 * @param	ball1
		 * @param	ball2
		 */
		private function hitTestClips(clip1:MovieClip, clip2:MovieClip):Boolean
		{
			var retval:Boolean = false;
			
			var distance:Number = MathTools.getDistance(clip1.x - clip2.x, clip1.y - clip2.y);
			
			if (distance <= (clip1.width / 2 + clip2.width / 2))
			{
				retval = true;
			}
			return retval;
		}
		
		/**
		 * Updates enemies
		 * Calculates their positions
		 * Sorts _enemies array based on distance
		 */
		private function updateEnemies():void 
		{
			var i:int;
			
			// loop thru enemies array to find whichEnemy
			for (i = 0; i < _enemies.length; i++)
			{
				// save a reference to movieclip
				_tempEnemy = _enemies[i] as Enemy;
				
				resetTint(_tempEnemy);
				
				// calculate distance from movieclip to target
				_tempEnemy.distanceToTarget = MathTools.getDistance(_tempEnemy.x - container.mouseX, _tempEnemy.y - container.mouseY);
				
				// sort array based on distanceToTarget
				_enemies.sortOn("distanceToTarget", Array.NUMERIC);
			}
			
			// if enemies array is empty, abort function
			if (_enemies.length == 0) return;
			
			_tempEnemy = _enemies[0] as Enemy;
			
			// apply green tint
			applyGreenTint(_tempEnemy);
		}
		
		/**
		 * Use this to reset tint on an enemy		 
		 * * @param	enemy
		 */
		private function resetTint(enemy:Enemy):void
		{
			_colorTint = enemy.transform.colorTransform;
			_colorTint.redOffset = 0;
			_colorTint.blueOffset = 0;
			_colorTint.greenOffset = 0;
			enemy.transform.colorTransform = _colorTint;
		}
		
		/**
		 * Use this to apply a tint to an enemy
		 * @param	enemy
		 */
		private function applyGreenTint(enemy:Enemy):void
		{
			_colorTint = enemy.transform.colorTransform;
			_colorTint.redOffset = 0;
			_colorTint.blueOffset = 0;
			_colorTint.greenOffset = 255;
			enemy.transform.colorTransform = _colorTint;
		}
		
		//////////////////////////////////////
		// Event Handlers
		//////////////////////////////////////
		
		/**
		 * Enemy click handler
		 * @param	e	Uses MouseEvent
		 */
		private function onEnemyClick(e:MouseEvent):void 
		{
			// save a reference to clicked enemy
			_tempEnemy = e.currentTarget as Enemy;
			
			// run destroy enemy function
			destroyEnemy(_tempEnemy);
		}
		
		//////////////////////////////////////
		// Getters and Setters
		//////////////////////////////////////
		
		public function get enemies():Array 
		{
			return _enemies;
		}
		
		public function set enemies(value:Array):void 
		{
			_enemies = value;
		}
		
		public function get container():DisplayObjectContainer 
		{
			return _container;
		}
		
		public function set container(value:DisplayObjectContainer):void 
		{
			_container = value;
		}
		
	}
}