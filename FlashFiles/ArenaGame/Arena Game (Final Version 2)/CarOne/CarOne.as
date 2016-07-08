﻿package {	import flash.display.*;	import flash.events.*;	public class CarOne extends MovieClip	{		public var refM:MovieClip;		public var moveSpeedMax1:Number = 2000;		public var rotateSpeedMax1:Number = 15;		public var decay1:Number = .98;		public var destinationX1:int = 0;		public var destinationY1:int = 0;		public var _dx1:Number = 0;		public var _dy1:Number = 0;		public var _vx1:Number = 0;		public var _vy1:Number = 0;		public var trueRotation1:Number = 0;		public var xDist1:Number = 0;		public var yDist1:Number = 0;		public var directDist1:Number = 0;		public var carOneIndRotation:Number;		public function CarOne()		{			stage.addEventListener(Event.ENTER_FRAME,gLoop);			refM = MovieClip(this.parent);		}		function gLoop(event:Event):void		{			if (refM.pausee == false)			{				carOneIndicatorRotate();				refM.xDis1 = this.x - refM.cFour.x;				refM.yDis1 = this.y - refM.cFour.y;				refM.Dis1 = Math.sqrt((refM.xDis1 * refM.xDis1) + refM.yDis1 * refM.yDis1);				if (refM.Dis1 < 100)				{				}				else				{					carOneMovement();				}				refM.cOneTarg.visible = false;			}		}		public function carOneMovement()		{			if (refM.carOneHitState == false)			{				refM.carOneCount +=  1;				decay1 = 0.7;				rotateSpeedMax1 = 100;				moveSpeedMax1 = 1000;				if (refM.carOneCount > 15)				{					rotateSpeedMax1 = 10;					refM.cOneTarg.x = refM.mCar.x;					refM.cOneTarg.y = refM.mCar.y;				}				if (refM.carOneCount > 80)				{					refM.carOneHitState = true;					refM.carOneCount = 0;				}			}			if (refM.carOneHitState == true)			{				rotateSpeedMax1 = 20;				decay1 = .95;				refM.cOneTarg.x = refM.mCar.x;				refM.cOneTarg.y = refM.mCar.y;			}			for (var i:uint = 0; i < refM.carOneBoxesArray.length; i ++)			{				for (var j:uint = 0; j < refM.carTwoBoxesArray.length; j ++)				{					if (refM.carOneBoxesArray[i].hitTestObject(refM.carTwoBoxesArray[j]))					{						refM.carOneHitState = false;						this.x -=  _vx1;						this.y -=  _vx1;					}				}				for (var d:uint = 0; d < refM.MainCarBoxesArray.length; d ++)				{					if (refM.carOneBoxesArray[i].hitTestObject(refM.carFourBoxesArray[d]))					{						this.x -=  _vx1;						this.y -=  _vx1;						refM.carOneHitState = false;					}				}				for (var e:uint = 0; e < refM.MainCarBoxesArray.length; e ++)				{					if (refM.carOneBoxesArray[i].hitTestObject(refM.MainCarBoxesArray[e]))					{						refM.mainCarSpawn = false;						refM.carOneHitState = false;					}				}			}			if (this.x < refM.boundyLeft || this.x > refM.boundyRight || this.y < refM.boundyTop || this.y > refM.boundyBottom)			{				refM.carOneInd.alpha = .8;			}			else			{				refM.carOneInd.alpha = 0;			}			_vx1 +=  (destinationX1 - this.x) / moveSpeedMax1;			_vy1 +=  (destinationY1 - this.y) / moveSpeedMax1;			_vx1 *=  decay1;			_vy1 *=  decay1;			this.x +=  _vx1;			this.y +=  _vy1;			destinationX1 = refM.cOneTarg.x;			destinationY1 = refM.cOneTarg.y;			_dx1 = this.x - destinationX1;			_dy1 = this.y - destinationY1;			var rotateTo1:Number = refM.getDegrees(refM.getRadians(_dx1,_dy1));			if ((rotateTo1 > this.rotation + 180))			{				rotateTo1 -=  360;			}			if ((rotateTo1 < this.rotation - 180))			{				rotateTo1 +=  360;			}			trueRotation1 = (rotateTo1 - this.rotation) / rotateSpeedMax1;			this.rotation +=  trueRotation1;			if ((refM.getDistance(_dx1,_dy1) < 50))			{				trueRotation1 *=  .5;			}		}		public function carOneIndicatorRotate()		{			carOneIndRotation = Math.round((180 - Math.atan2(this.x - refM.carOneInd.x,this.y - refM.carOneInd.y) * 180 / Math.PI));			refM.carOneInd.rotation = carOneIndRotation;		}	}}