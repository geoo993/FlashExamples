package 
{

	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.filters.*;


	public class TurretFourBarrel extends MovieClip
	{
		public var refM:MovieClip;

		public var myColorTransform = new ColorTransform  ;

		public var gravity:Number = .68;

		public var playerCos:Number;
		public var playerSin:Number;

		public var startX:Number;
		public var startY:Number;

		public var bulletSpeed:Number = 5;
		public var bulletMaxDistance:Number = 1000;
		public var maxDistance:Number;

		public var xDistFour:Number = 0;
		public var yDistFour:Number = 0;
		public var getDistanceFour:Number = 0;

		public var isLoaded4:Boolean = true;
		public var isFiring4:Boolean = false;

		public var counttt:Number = 0;
		public var _barrelLength:Number = 40;
		public var _bulletSpread:Number = 2;
		public var _reloadSpeed:Number = 10;//milliseconds

		public var countState:Boolean = false;
		public var tFourState:Boolean = false;

		public var whereBulletEndsX:Number;
		public var whereBulletEndsY:Number;
		public var bulletXPos:Number;
		public var bulletYPos:Number;


		public function TurretFourBarrel()
		{
			stage.addEventListener(MouseEvent.CLICK,mClick);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, MouseUp);
			this.addEventListener(Event.ENTER_FRAME,gameLoop);

			refM = MovieClip(this.parent);
			refM.turretsArray.push(this);
			refM.turretFourArray.push(this);
		}

		function gameLoop(event:Event):void
		{
			turret4Health();
			updateBullets();
			fire();

			refM.text4.text = refM.t4healthNum.toFixed(0);

			if (tFourState == false)
			{


				refM.frontBoxArray[2].alpha = 0;

				if (isFiring4 == true)
				{
					refM.t4healthNum -=  .1;
				}
			}
			if (tFourState == true)
			{
				refM.frontBoxArray[2].alpha = .1;
				refM.t4healthNum +=  .005;
			}

			if ((refM.t4healthNum == 0))
			{
				tFourState = true;
			}

		}
		public function turret4Health()
		{
			if ((refM.t4healthNum >= 100))
			{
				refM.t4healthNum = 100;
			}
			if ((refM.t4healthNum <= 0))
			{
				refM.t4healthNum = 0;
			}

			for (var i:uint = 0; i < refM.turretFourArray.length; i += 1)
			{

				if ((refM.t4healthNum <= 20))
				{
					refM.turretFourArray[i].filters = [refM.filter_glow];
				}
				else
				{
					refM.turretFourArray[i].filters = [];
				}

				if ((refM.t4healthNum <= 0))
				{
					myColorTransform.color = 0xff0000;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t4healthNum <= 5))
				{
					myColorTransform.color = 0xff0000;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t4healthNum <= 10))
				{
					myColorTransform.color = 0xff0000;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t4healthNum <= 15))
				{
					myColorTransform.color = 0xFF3400;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t4healthNum <= 20))
				{
					myColorTransform.color = 0xFF5700;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t4healthNum <= 25))
				{
					myColorTransform.color = 0xFF6900;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t4healthNum <= 30))
				{
					myColorTransform.color = 0xFF7B00;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t4healthNum <= 35))
				{
					myColorTransform.color = 0xFF8C00;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t4healthNum <= 40))
				{
					myColorTransform.color = 0xFF9E00;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t4healthNum <= 45))
				{
					myColorTransform.color = 0xFFAF00;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t4healthNum <= 50))
				{
					myColorTransform.color = 0xFFC100;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t4healthNum <= 55))
				{
					myColorTransform.color = 0xFFD300;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t4healthNum <= 60))
				{
					myColorTransform.color = 0xFFE400;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t4healthNum <= 65))
				{
					myColorTransform.color = 0xFFF600;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t4healthNum <= 70))
				{
					myColorTransform.color = 0xF7FF00;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t4healthNum <= 75))
				{
					myColorTransform.color = 0xE5FF00;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t4healthNum <= 80))
				{
					myColorTransform.color = 0xD4FF00;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t4healthNum <= 85))
				{
					myColorTransform.color = 0xC2FF00;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t4healthNum <= 90))
				{
					myColorTransform.color = 0xB0FF00;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t3healthNum <= 95))
				{
					myColorTransform.color = 0x9FFF00;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t4healthNum <= 100))
				{
					myColorTransform.color = 0x7CFF00;
					refM.turretFourArray[i].transform.colorTransform = myColorTransform;
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

			var tempBullet:MovieClip = new BulletFour();

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

			if (! isFiring4)
			{
				return;
			}

			if (! isLoaded4)
			{
				return;
			}
			if ((refM.shootingState == "Fire" || tFourState == false))
			{
				createBullet();
			}

			countState = true;

			isLoaded4 = false;
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

				xDistFour = startX - tempBullet.x;
				yDistFour = startY - tempBullet.y;

				getDistanceFour = Math.sqrt((xDistFour * xDistFour) + (yDistFour * yDistFour));

				if (getDistanceFour > maxDistance + _barrelLength)
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
			isLoaded4 = true;
		}

		public function MouseUp(event:MouseEvent):void
		{
			if ((refM.shootingState == "Fire"))
			{
				if (tFourState == false)
				{
					isFiring4 = false;
				}
			}

		}

		public function MouseDown(event:MouseEvent):void
		{
			if (event.target == refM.mouseTarg)
			{

				if ((refM.shootingState == "Fire"))
				{
					if (tFourState == false)
					{

						isFiring4 = true;
					}
				}
			}

		}
		public function mClick(event:MouseEvent):void
		{
			if (event.target == refM.frontBoxArray[2])
			{
				tFourState = ! tFourState;
			}

		}


	}

}