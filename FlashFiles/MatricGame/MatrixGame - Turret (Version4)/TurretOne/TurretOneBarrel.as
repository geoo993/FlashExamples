package 
{

	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.filters.*;


	public class TurretOneBarrel extends MovieClip
	{
		public var refM:MovieClip;

		public var myColorTransform = new ColorTransform  ;

		public var gravity:Number = .68;

		public var playerCos:Number;
		public var playerSin:Number;

		public var startX:Number;
		public var startY:Number;

		public var bulletSpeed:Number = 3;
		public var bulletMaxDistance:Number = 1000;
		public var maxDistance:Number;

		public var xDistOne:Number = 0;
		public var yDistOne:Number = 0;
		public var getDistanceOne:Number = 0;

		public var isLoaded1:Boolean = true;
		public var isFiring1:Boolean = false;

		public var counttt:Number = 0;
		public var _barrelLength:Number = 40;
		public var _bulletSpread:Number = 2;
		public var _reloadSpeed:Number = 10;//milliseconds

		public var countState:Boolean = false;
		public var tOneState:Boolean = false;

		public var whereBulletEndsX:Number;
		public var whereBulletEndsY:Number;
		public var bulletXPos:Number;
		public var bulletYPos:Number;

		public function TurretOneBarrel()
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
			stage.addEventListener(MouseEvent.CLICK,mClick);
			stage.addEventListener(MouseEvent.MOUSE_UP, MouseUp);
			stage.addEventListener(Event.ENTER_FRAME,gameLoop);

			refM = MovieClip(this.parent);

			refM.turretsArray.push(this);
			refM.turretOneArray.push(this);

		}

		function gameLoop(event:Event):void
		{

			turret1Health();
			updateBullets();
			fire();

			refM.text1.text = refM.t1healthNum.toFixed(0);

			if (tOneState == false)
			{

				refM.frontBoxArray[0].alpha = 0;
				if (isFiring1 == true)
				{
					refM.t1healthNum -=  .1;
				}
			}
			if (tOneState == true)
			{
				refM.frontBoxArray[0].alpha = .1;

				refM.t1healthNum +=  .01;
			}

			if ((refM.t1healthNum == 0))
			{
				tOneState = true;
			}

		}
		public function turret1Health()
		{
			if ((refM.t1healthNum >= 100))
			{
				refM.t1healthNum = 100;
			}

			if ((refM.t1healthNum <= 0))
			{
				refM.t1healthNum = 0;
			}

			for (var i:uint = 0; i < refM.turretOneArray.length; i += 1)
			{

				if ((refM.t1healthNum <= 20))
				{
					refM.turretOneArray[i].filters = [refM.filter_glow];
				}
				else
				{
					refM.turretOneArray[i].filters = [];
				}

				if ((refM.t1healthNum <= 0))
				{
					myColorTransform.color = 0xff0000;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t1healthNum <= 5))
				{
					myColorTransform.color = 0xff0000;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t1healthNum <= 10))
				{
					myColorTransform.color = 0xff0000;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t1healthNum <= 15))
				{
					myColorTransform.color = 0xFF3400;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t1healthNum <= 20))
				{
					myColorTransform.color = 0xFF5700;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t1healthNum <= 25))
				{
					myColorTransform.color = 0xFF6900;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t1healthNum <= 30))
				{
					myColorTransform.color = 0xFF7B00;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t1healthNum <= 35))
				{
					myColorTransform.color = 0xFF8C00;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t1healthNum <= 40))
				{
					myColorTransform.color = 0xFF9E00;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t1healthNum <= 45))
				{
					myColorTransform.color = 0xFFAF00;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t1healthNum <= 50))
				{
					myColorTransform.color = 0xFFC100;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t1healthNum <= 55))
				{
					myColorTransform.color = 0xFFD300;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t1healthNum <= 60))
				{
					myColorTransform.color = 0xFFE400;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t1healthNum <= 65))
				{
					myColorTransform.color = 0xFFF600;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t1healthNum <= 70))
				{
					myColorTransform.color = 0xF7FF00;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t1healthNum <= 75))
				{
					myColorTransform.color = 0xE5FF00;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t1healthNum <= 80))
				{
					myColorTransform.color = 0xD4FF00;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t1healthNum <= 85))
				{
					myColorTransform.color = 0xC2FF00;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t1healthNum <= 90))
				{
					myColorTransform.color = 0xB0FF00;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t1healthNum <= 95))
				{
					myColorTransform.color = 0x9FFF00;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t1healthNum <= 100))
				{
					myColorTransform.color = 0x7CFF00;
					refM.turretOneArray[i].transform.colorTransform = myColorTransform;
				}
			}

		}

		private function createBullet():void
		{

			playerCos = Math.cos(this.rotation * Math.PI / 180);
			playerSin = Math.sin(this.rotation * Math.PI / 180);

			bulletXPos = this.x - _barrelLength * playerCos;
			bulletYPos = this.y - _barrelLength * playerSin;

			whereBulletEndsX = this.x - 50 * playerCos + Math.random() * _bulletSpread - _bulletSpread * .5;
			whereBulletEndsY = this.y - 50 * playerSin + Math.random() * _bulletSpread - _bulletSpread * .5;

			var tempBullet:MovieClip = new BulletOne();

			tempBullet.vx = (whereBulletEndsX - bulletXPos) / bulletSpeed;
			tempBullet.vy = (whereBulletEndsY - bulletYPos) / bulletSpeed;

			tempBullet.x = bulletXPos;
			tempBullet.y = bulletYPos;

			startX = bulletXPos;
			startY = bulletYPos;
			maxDistance = bulletMaxDistance;
			refM.bulletsArray.push(tempBullet);

			stage.addChild(tempBullet);


		}

		public function fire():void
		{
			if (countState == true)
			{
				counttt +=  1;

				if (counttt >= _reloadSpeed)
				{
					counttt = 0;
					reloadWeapon();
					countState = false;
				}
			}

			if (! isFiring1)
			{
				return;
			}

			if (! isLoaded1)
			{
				return;
			}
			if ((refM.shootingState == "Fire" || tOneState == false))
			{
				createBullet();
			}

			countState = true;

			isLoaded1 = false;
		}
		public function updateBullets():void
		{
			var i:int;
			var tempBullet:MovieClip;

			for (i = 0; i < refM.bulletsArray.length; i++)
			{
				tempBullet = refM.bulletsArray[i];

				tempBullet.x +=  tempBullet.vx;
				tempBullet.y +=  tempBullet.vy;

				xDistOne = startX - tempBullet.x;
				yDistOne = startY - tempBullet.y;
				
				getDistanceOne = Math.sqrt((xDistOne * xDistOne) + (yDistOne * yDistOne));

				if (getDistanceOne > maxDistance + _barrelLength)
				{
					destroyBullet(tempBullet);
				}
			}
		}
		public function destroyBullet(bullet:MovieClip):void
		{
			var i:int;
			var tempBullet:MovieClip;

			for (i = 0; i < refM.bulletsArray.length; i++)
			{
				tempBullet = refM.bulletsArray[i];

				if (tempBullet == bullet)
				{
					refM.bulletsArray.splice(i, 1);

					bullet.parent.removeChild(bullet);

					return;
				}
			}

		}
		public function reloadWeapon():void
		{
			isLoaded1 = true;
		}

		public function MouseUp(event:MouseEvent):void
		{
			if ((refM.shootingState == "Fire"))
			{
				if (tOneState == false)
				{
					isFiring1 = false;
				}
			}
		}

		public function MouseDown(event:MouseEvent):void
		{
			if (event.target == refM.mouseTarg)
			{
				if ((refM.shootingState == "Fire"))
				{
					if (tOneState == false)
					{
						isFiring1 = true;
					}
				}
			}

		}
		public function mClick(event:MouseEvent):void
		{

			if (event.target == refM.frontBoxArray[0])
			{
				tOneState = ! tOneState;
			}


		}


	}

}