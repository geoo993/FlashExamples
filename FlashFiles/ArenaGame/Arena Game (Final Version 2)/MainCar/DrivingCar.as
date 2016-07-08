﻿package {	import flash.display.*;	import flash.events.*;	public class DrivingCar extends MovieClip	{		public var refM:MovieClip;		public var TmoveSpeedMax:Number = 400;		public var TrotateSpeedMax:Number = 15;		public var Tdecay:Number = .90;		public var TdestinationX:int = 0;		public var TdestinationY:int = 0;		public var Tdx:Number = 0;		public var Tdy:Number = 0;		public var Tvx:Number = 0;		public var Tvy:Number = 0;		public var TtrueRotation:Number = 0;		public var speeed:Number = 0;		public var speedMax:Number = 15;		public var speedMaxReverse:Number = -8;		public var speedAcceleration:Number = .50;		public var speedDeceleration:Number = 1;		public var groundFriction:Number = .92;		public var steering:Number = 0;		public var steeringMax:Number = 2.4;		public var steeringAcceleration:Number = .20;		public var steeringFriction:Number = .95;		public var velocityX:Number = 0;		public var velocityY:Number = 0;		public var up:Boolean = false;		public var down:Boolean = false;		public var left:Boolean = false;		public var right:Boolean = false;		public var leftSignal:Boolean = false;		public var rightSignal:Boolean = false;		public var mainCarSpawn:Boolean = false;		public var mainCarCount:Number = 0;		public var spawnX:Number = 0;		public var randomSpawn:Number = 0;		public var mCarIndRotation:Number;		public var healthControl:Boolean = false;		public function DrivingCar()		{			this.addEventListener(Event.ENTER_FRAME,gLoop);			stage.addEventListener(KeyboardEvent.KEY_DOWN,onMyPress);			stage.addEventListener(KeyboardEvent.KEY_UP,onMyRelease);			refM = MovieClip(this.parent);		}		function gLoop(myEvent:Event):void		{			if (refM.pausee == false)			{				mCarIndicatorRotate();				MainCarMovement();								if(refM.gameTimerS == 59)				{					refM.pointsNum +=  100;				}				if (this.x < refM.boundyLeft || this.x > refM.boundyRight || this.y < refM.boundyTop || this.y > refM.boundyBottom)				{					refM.mCarInd.alpha = .8;					refM.healthBar.healthState = true;					refM.healthBar.alphaControl = "dull";				}				else				{					refM.mCarInd.alpha = 0;					refM.healthBar.healthState = false;					refM.healthBar.alphaControl = "full";															for (var j:uint = 0; j < refM.MainCarBoxesArray.length; j ++)					{						for (var i:uint = 0; i < refM.carTwoBoxesArray.length; i ++)						{							if (! refM.MainCarBoxesArray[j].hitTestObject(refM.carTwoBoxesArray[i]))							{								refM.pointsNum +=  .0001;							}						}						for (var e:uint = 0; e < refM.carOneBoxesArray.length; e ++)						{							if (! refM.MainCarBoxesArray[j].hitTestObject(refM.carOneBoxesArray[e]))							{								refM.pointsNum +=  .0001;							}						}						for (var s:uint = 0; s < refM.carFourBoxesArray.length; s ++)						{							if (! refM.MainCarBoxesArray[j].hitTestObject(refM.carFourBoxesArray[s]))							{								refM.pointsNum +=  .0001;							}						}					}				}				if (refM.mainCarColour == false)				{					refM.myColor2 = Math.random() * 0xFFFFFF;					refM.myColorTransform.color = refM.myColor2;					this.body1.transform.colorTransform = refM.myColorTransform;					refM.mCarInd.transform.colorTransform = refM.myColorTransform;					refM.mTarg.transform.colorTransform = refM.myColorTransform;					refM.mainCarColour = true;				}			}		}		public function mCarTargetM()		{			Tvx +=  (TdestinationX - refM.mTarg.x) / TmoveSpeedMax;			Tvy +=  (TdestinationY - refM.mTarg.y) / TmoveSpeedMax;			Tvx *=  Tdecay;			Tvy *=  Tdecay;			refM.mTarg.x +=  Tvx;			refM.mTarg.y +=  Tvy;			TdestinationX = refM.thisTarg.x;			TdestinationY = refM.thisTarg.y;			Tdx = refM.mTarg.x - TdestinationX;			Tdy = refM.mTarg.y - TdestinationY;			var TrotateTo:Number = refM.getDegrees(refM.getRadians(Tdx,Tdy));			if ((TrotateTo > refM.mTarg.rotation + 180))			{				TrotateTo -=  360;			}			if ((TrotateTo < refM.mTarg.rotation - 180))			{				TrotateTo +=  360;			}			TtrueRotation = (TrotateTo - refM.mTarg.rotation) / TrotateSpeedMax;			refM.mTarg.rotation +=  TtrueRotation;			if ((refM.getDistance(Tdx,Tdy) < 50))			{				TtrueRotation *=  .5;			}		}		public function mCarIndicatorRotate()		{			mCarIndRotation = Math.round((180 - Math.atan2(this.x - refM.mCarInd.x,this.y - refM.mCarInd.y) * 180 / Math.PI));			refM.mCarInd.rotation = mCarIndRotation;		}		public function MainCarMovement()		{			randomSpawn = Math.round(Math.random() * 4);			if (refM.mainCarSpawn == false)			{				if (randomSpawn == 0)				{					spawnX = 150;				}				if (randomSpawn == 1)				{					spawnX = 250;				}				if (randomSpawn == 2)				{					spawnX = 350;				}				if (randomSpawn == 3)				{					spawnX = 450;				}				if (randomSpawn == 4)				{					spawnX = 550;				}				if (randomSpawn == 5)				{					spawnX = 650;				}				this.x = spawnX;				this.y = 700;				this.rotation = 0;				if (refM.gameTimerS > 1)				{					refM.currentFrameNum +=  5;				}				refM.mainCarSpawn = true;			}			for (var j:uint = 0; j < refM.MainCarBoxesArray.length; j ++)			{				for (var i:uint = 0; i < refM.carTwoBoxesArray.length; i ++)				{					if (refM.MainCarBoxesArray[j].hitTestObject(refM.carTwoBoxesArray[i]))					{						refM.mainCarSpawn = false;						healthControl = true;					}				}				for (var e:uint = 0; e < refM.carOneBoxesArray.length; e ++)				{					if (refM.MainCarBoxesArray[j].hitTestObject(refM.carOneBoxesArray[e]))					{						refM.mainCarSpawn = false;						healthControl = true;					}				}				for (var s:uint = 0; s < refM.carFourBoxesArray.length; s ++)				{					if (refM.MainCarBoxesArray[j].hitTestObject(refM.carFourBoxesArray[s]))					{						refM.mainCarSpawn = false;						refM.carFourHitState = false;						healthControl = true;					}				}			}			if (up)			{				if ((speeed < speedMax))				{					speeed +=  speedAcceleration;					if ((speeed > speedMax))					{						speeed = speedMax;					}				}			}			if (down)			{				if ((speeed > speedMaxReverse))				{					speeed -=  speedAcceleration;					if ((speeed < speedMaxReverse))					{						speeed = speedMaxReverse;					}				}			}			if (left)			{				steering -=  steeringAcceleration;				if ((steering > steeringMax))				{					steering = steeringMax;				}			}			if (right)			{				steering +=  steeringAcceleration;				if ((steering <  -  steeringMax))				{					steering =  -  steeringMax;				}			}			speeed *=  groundFriction;			if (((speeed > 0) && speeed < 0.05))			{				speeed = 0;			}			velocityX = Math.sin(this.rotation * Math.PI / 180) * speeed;			velocityY = Math.cos(this.rotation * Math.PI / 180) *  -  speeed;			this.x +=  velocityX;			this.y +=  velocityY;			if ((steering > 0))			{				if ((steering < 0.05))				{					steering = 0;				}			}			else if ((steering < 0))			{				if ((steering > -0.05))				{					steering = 0;				}			}			steering = steering * steeringFriction;			steering -=  (steering * 0.1);			this.rotation +=  steering * speeed;		}		function onMyPress(event:KeyboardEvent):void		{			if (event.keyCode == 32)			{				refM.mainCarColour = false;			}			if (event.keyCode == 87 || event.keyCode == 38)			{				up = true;				speeed +=  0.1;			}			if (event.keyCode == 83 || event.keyCode == 40)			{				down = true;			}			if (event.keyCode == 65 || event.keyCode == 37)			{				left = true;			}			if (event.keyCode == 68 || event.keyCode == 39)			{				right = true;			}			event.updateAfterEvent();		}		function onMyRelease(event:KeyboardEvent):void		{			if (event.keyCode == 87 || event.keyCode == 38)			{				up = false;			}			if (event.keyCode == 83 || event.keyCode == 40)			{				down = false;			}			if (event.keyCode == 65 || event.keyCode == 37)			{				left = false;			}			if (event.keyCode == 68 || event.keyCode == 39)			{				right = false;			}		}	}}