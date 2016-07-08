package 
{

	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.filters.*;


	public class TurretTwoBarrel extends MovieClip
	{
		public var refM:MovieClip;

		public var myColorTransform = new ColorTransform  ;

		public var gravity:Number = .68;

		public var playerCos:Number;
		public var playerSin:Number;

		public var startX:Number;
		public var startY:Number;

		public var bulletSpeed:Number = 5;
		public var bulletMaxDistance:Number = 200;
		public var maxDistance:Number;

		public var isLoaded2:Boolean = true;
		public var isFiring2:Boolean = false;

		public var counttt:Number = 0;
		public var _barrelLength:Number = 40;
		public var _bulletSpread:Number = 2;
		public var _reloadSpeed:Number = 10;//milliseconds

		public var countState:Boolean = false;
		public var tTwoState:Boolean = false;

		public var whereBulletEndsX:Number;
		public var whereBulletEndsY:Number;
		public var bulletXPos:Number;
		public var bulletYPos:Number;


		public function TurretTwoBarrel()
		{
			stage.addEventListener(MouseEvent.CLICK,mClick);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, MouseUp);
			this.addEventListener(Event.ENTER_FRAME,gameLoop);

			refM = MovieClip(this.parent);

			refM.turretsArray.push(this);
			refM.turretTwoArray.push(this);
		}

		function gameLoop(event:Event):void
		{


			//turret2Health();
			updateBullets();
			fire();
			
			refM.text2.text = refM.t2healthNum.toFixed(0);

			if (tTwoState == false)
			{
				refM.frontBoxArray[1].alpha = 0;

				if (isFiring2 == true)
				{
					refM.t2healthNum -=  .1;
				}
			}
			if (tTwoState == true)
			{
				if (isFiring2 == false)
				{
					refM.t2healthNum +=  .005;
				}
				refM.frontBoxArray[1].alpha = .1;
			}
			

		}
		public function turret2Health()
		{
			for (var i:uint = 0; i < refM.turretTwoArray.length; i += 1)
			{
				if ((refM.t2healthNum <= 20))
				{
					refM.turretTwoArray[i].filters = [refM.filter_glow];
				}
				else
				{
					refM.turretTwoArray[i].filters = [];
				}

				if ((refM.t2healthNum >= 100))
				{
					refM.t2healthNum = 100;
				}
				if ((refM.t2healthNum <= 0))
				{
					refM.t2healthNum = 0;
				}

				if ((refM.t2healthNum <= 0))
				{
					myColorTransform.color = 0xff0000;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t2healthNum <= 5))
				{
					myColorTransform.color = 0xff0000;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t2healthNum <= 10))
				{
					myColorTransform.color = 0xff0000;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t2healthNum <= 15))
				{
					myColorTransform.color = 0xFF3400;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t2healthNum <= 20))
				{
					myColorTransform.color = 0xFF5700;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t2healthNum <= 25))
				{
					myColorTransform.color = 0xFF6900;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t2healthNum <= 30))
				{
					myColorTransform.color = 0xFF7B00;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t2healthNum <= 35))
				{
					myColorTransform.color = 0xFF8C00;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t2healthNum <= 40))
				{
					myColorTransform.color = 0xFF9E00;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t2healthNum <= 45))
				{
					myColorTransform.color = 0xFFAF00;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t2healthNum <= 50))
				{
					myColorTransform.color = 0xFFC100;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t2healthNum <= 55))
				{
					myColorTransform.color = 0xFFD300;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t2healthNum <= 60))
				{
					myColorTransform.color = 0xFFE400;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t2healthNum <= 65))
				{
					myColorTransform.color = 0xFFF600;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t2healthNum <= 70))
				{
					myColorTransform.color = 0xF7FF00;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t2healthNum <= 75))
				{
					myColorTransform.color = 0xE5FF00;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t2healthNum <= 80))
				{
					myColorTransform.color = 0xD4FF00;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t2healthNum <= 85))
				{
					myColorTransform.color = 0xC2FF00;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t2healthNum <= 90))
				{
					myColorTransform.color = 0xB0FF00;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t2healthNum <= 95))
				{
					myColorTransform.color = 0x9FFF00;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
				}
				else if ((refM.t2healthNum <= 100))
				{
					myColorTransform.color = 0x7CFF00;
					refM.turretTwoArray[i].transform.colorTransform = myColorTransform;
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

			var tempBullet:MovieClip = new BulletTwo();

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

			if (! isFiring2)
			{
				return;
			}

			if (! isLoaded2)
			{
				return;
			}
			if ((refM.shootingState == "Fire" || tTwoState == false))
			{
				createBullet();
			}
			countState = true;

			isLoaded2 = false;
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
			isLoaded2 = true;
		}

		public function MouseUp(event:MouseEvent):void
		{
			if ((refM.shootingState == "Fire"))
			{
				if (tTwoState == false)
				{
					isFiring2 = false;
				}
			}
		}

		public function MouseDown(event:MouseEvent):void
		{
			if ((refM.shootingState == "Fire"))
			{
				if (tTwoState == false)
				{
					isFiring2 = true;
				}
			}
		}
		public function mClick(event:MouseEvent):void
		{
			if (event.target == refM.frontBoxArray[1])
			{
				tTwoState = ! tTwoState;
			}

		}



	}

}