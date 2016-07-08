﻿package {	import flash.display.MovieClip;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.events.KeyboardEvent;	import flash.ui.Keyboard;	import flash.events.TimerEvent;	import flash.filters.BlurFilter;	import flash.utils.Timer;		public class Main extends MovieClip	{		var playerSpeed:Number = 4;		var movingUp:Boolean = false;		var movingDown:Boolean = false;		var movingLeft:Boolean = false;		var movingRight:Boolean = false;				public var gravity:Number = .68;		public var rotationSpeedMax:Number = 20;				public var xPos:Number;		public var yPos:Number;				public var playerCos:Number;		public var playerSin:Number;						public var bulletSpeed:Number = 4;				public var bulletMaxDistance:Number = 200;				public var _reloadSpeed:Number = 100; //milliseconds		public var _barrelLength:Number = 20;		public var _bulletSpread:Number = 5;				public var _isLoaded:Boolean = true;				public var _isFiring:Boolean = false;		public var _reloadTimer:Timer;				public var whereBulletEndsX:Number;		public var whereBulletEndsY:Number;		public var bulletXPos:Number;		public var bulletYPos:Number;		public var _bullets:Array = [];		public var trueRotation:Number;		public function Main()		{			this.addEventListener(Event.ENTER_FRAME, gLoop);			stage.addEventListener(MouseEvent.MOUSE_DOWN, mDown);			stage.addEventListener(MouseEvent.MOUSE_UP, mUp);			stage.addEventListener(KeyboardEvent.KEY_DOWN,onMyPress);			stage.addEventListener(KeyboardEvent.KEY_UP,onMyRelease);		}		public function createBullet():void		{						playerCos = Math.cos(peanut.rotation * Math.PI / 180);			playerSin = Math.sin(peanut.rotation * Math.PI / 180);						bulletXPos = peanut.x - _barrelLength * playerCos;			bulletYPos = peanut.y - _barrelLength * playerSin;						whereBulletEndsX = peanut.x - 50 * playerCos + Math.random() * _bulletSpread - _bulletSpread * .5;			whereBulletEndsY = peanut.y - 50 * playerSin + Math.random() * _bulletSpread - _bulletSpread * .5;												// attach bullet from library			var tempBullet:MovieClip = new NutSeeds();						// calculate velocity			tempBullet.vx = (whereBulletEndsX - bulletXPos) / bulletSpeed;			tempBullet.vy = (whereBulletEndsY - bulletYPos) / bulletSpeed;						// set position			tempBullet.x = bulletXPos;			tempBullet.y = bulletYPos;						// save starting location			tempBullet.startX = bulletXPos;			tempBullet.startY = bulletYPos;			tempBullet.maxDistance = bulletMaxDistance;			_bullets.push(tempBullet);						// add to display list			stage.addChild(tempBullet);					}				public function updateRotation():void		{			// calculate rotation based on mouse X & Y			xPos = peanut.x - stage.mouseX;			yPos = peanut.y - stage.mouseY;									var rotateTo:Number = getDegrees(getRadians(xPos, yPos));							// keep rotation positive, between 0 and 360 degrees			if (rotateTo > peanut.rotation + 180) rotateTo -= 360;			if (rotateTo < peanut.rotation - 180) rotateTo += 360;						trueRotation = (rotateTo - peanut.rotation) / rotationSpeedMax;						peanut.rotation += trueRotation;					}		public function updateBullets():void		{			var i:int;			var tempBullet:MovieClip;						for (i = 0; i < _bullets.length; i++)			{								tempBullet = _bullets[i];								tempBullet.x += tempBullet.vx;				tempBullet.y += tempBullet.vy;								// check if bullet went too far				//if (getDistance(tempBullet.startX - tempBullet.x, tempBullet.startY - tempBullet.y) > tempBullet.maxDistance + _barrelLength)//				{//					destroyBullet(tempBullet);//				}											}		}		public function destroyBullet(bullet:MovieClip):void		{			var i:int;			var tempBullet:MovieClip;									for (i = 0; i < _bullets.length; i++)			{				tempBullet = _bullets[i];								if (tempBullet == bullet)				{					// remove from array					_bullets.splice(i, 1);										// remove from display list					bullet.parent.removeChild(bullet);										return;				}			}		}		public function reloadWeapon():void		{			_isLoaded = true;		}		public function fire():void		{			// check if firing			if (!_isFiring) return;						// check if reloaded			if (!_isLoaded) return;						// create bullet			createBullet();						// start reload timer			_reloadTimer = new Timer(_reloadSpeed);			_reloadTimer.addEventListener(TimerEvent.TIMER, reloadTimerHandler);			_reloadTimer.start();									// set reload flag to false			_isLoaded = false;		}		public function reloadTimerHandler(e:TimerEvent):void 		{			// stop timer			e.target.stop();						// clear timer var			_reloadTimer = null;						reloadWeapon();		}		public function gLoop(event:Event):void		{			updateRotation();			updateBullets();			fire();									moverr.visible = false;			if ((movingLeft && ! movingRight))			{				moverr.x -=  playerSpeed;				moverr.rotation = 270;			}			if ((movingRight && ! movingLeft))			{				moverr.x +=  playerSpeed;				moverr.rotation = 90;			}			if ((movingUp && ! movingDown))			{				moverr.y -=  playerSpeed;				moverr.rotation = 0;			}			if ((movingDown && ! movingUp))			{				moverr.y +=  playerSpeed;				moverr.rotation = 180;			}			// Move diagonally			if (((movingLeft && movingUp) && ! movingRight) && ! movingDown)			{				moverr.rotation = 315;			}			if (((movingRight && movingUp) && ! movingLeft) && ! movingDown)			{				moverr.rotation = 45;			}			if (((movingLeft && movingDown) && ! movingRight) && ! movingUp)			{				moverr.rotation = 225;			}			if (((movingRight && movingDown) && ! movingLeft) && ! movingUp)			{				moverr.rotation = 135;			}		}		public function getRadians(delta_x:Number, delta_y:Number):Number		{			var r:Number = Math.atan2(delta_y, delta_x);						if (delta_y < 0)			{				r += (2 * Math.PI);			}			return r;		}						public function getDegrees(radians:Number):Number		{			return Math.floor(radians/(Math.PI/180));		}				public function mUp(event:MouseEvent):void		{			_isFiring = false;		}		public function mDown(event:MouseEvent):void		{			_isFiring = true;		}				function onMyPress(event:KeyboardEvent):void		{			//trace("Key Code Pressed: " + event.keyCode);			if (event.keyCode == 32)			{			}			switch (event.keyCode)			{				case Keyboard.UP :					movingUp = true;					break;				case Keyboard.DOWN :					movingDown = true;					break;				case Keyboard.LEFT :					movingLeft = true;					break;				case Keyboard.RIGHT :					movingRight = true;					break;			}		}		function onMyRelease(event:KeyboardEvent):void		{			switch (event.keyCode)			{				case Keyboard.UP :					movingUp = false;					break;				case Keyboard.DOWN :					movingDown = false;					break;				case Keyboard.LEFT :					movingLeft = false;					break;				case Keyboard.RIGHT :					movingRight = false;					break;			}		}	}}