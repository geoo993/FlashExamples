package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Car1 extends MovieClip
	{
		var refM:MovieClip;


		var moveSpeedMax:Number = 2000;
		var rotateSpeedMax:Number = 15;
		var decay:Number = .98;

		var isTrue:Boolean = true;
		var isTrue22:Boolean = true;
		var startMove2:Boolean = false;
		var carRandomPos:Number = 0;


		var _dx:Number = 0;
		var _dy:Number = 0;

		var _vx:Number = 0;
		var _vy:Number = 0;

		var trueRotation:Number = 0;


		var xDist:Number = 0;
		var yDist:Number = 0;
		var directDist:Number = 0;


		var car1Count:Number = 0;


		var issActive:Boolean = false;

		public function Car1()
		{
			stage.addEventListener(Event.ENTER_FRAME,gLoop);
			stage.addEventListener(MouseEvent.CLICK, onClick);
			refM = MovieClip(this.parent);

			refM.carsArray.push(this);
		}


		function gLoop(event:Event):void
		{

			refM.car1Text.text = "Car1 " + car1Count;

			for (var e:Number = 0; e < refM.carsArray.length; e += 1)
			{

				xDist = refM.carsArray[1].x - refM.carsArray[0].x;
				yDist = refM.carsArray[1].y - refM.carsArray[0].y;

				directDist = Math.sqrt((xDist * xDist) + (yDist * yDist));
			}




			if (issActive == false)
			{

				if (isTrue22 == true)
				{
					carRandomPos = Math.random() * 1;
					carRandomPos = Math.round(carRandomPos);

					isTrue22 = false;
				}

				if (startMove2 == false)
				{
					if (carRandomPos == 0)
					{

						this.x = 100;
						this.y = -50;
						this.rotation = -90;
					}
					if (carRandomPos == 1)
					{
						this.x = 400;
						this.y = -50;
						this.rotation = -90;
					}

					car1Count += 1
					
					if (car1Count > 100)
					{

						car1Count = 0;
						startMove2 = true;
					}

				}

				if (startMove2 == true)
				{
					
					issActive = true;
				}

			}


			if (issActive == true)
			{




				_dx = this.x - refM.destinationX;
				_dy = this.y - refM.destinationY;

				var rotateTo:Number = getDegrees(getRadians(_dx,_dy));

				if ((rotateTo > this.rotation + 180))
				{
					rotateTo -=  360;
				}
				if ((rotateTo < this.rotation - 180))
				{
					rotateTo +=  360;
				}

				trueRotation = (rotateTo - this.rotation) / rotateSpeedMax;

				this.rotation +=  trueRotation;


				_vx +=  (refM.destinationX - this.x) / moveSpeedMax;
				_vy +=  (refM.destinationY - this.y) / moveSpeedMax;

				_vx *=  decay;
				_vy *=  decay;

				if ((getDistance(_dx,_dy) < 50))
				{
					trueRotation *=  .5;
				}

				this.x +=  _vx;
				this.y +=  _vy;



				function getDistance(delta_x:Number, delta_y:Number):Number
				{
					return Math.sqrt((delta_x*delta_x)+(delta_y*delta_y));
				}

				function getRadians(delta_x:Number, delta_y:Number):Number
				{
					var r:Number = Math.atan2(delta_y,delta_x);

					if (delta_y < 0)
					{
						r +=  (2 * Math.PI);
					}
					return r;
				}

				function getDegrees(radians:Number):Number
				{
					return Math.floor(radians/(Math.PI/180));
				}


				if (this.y < -80)
				{
					this.y = 680;
				}

				if (this.y > 680)
				{
					this.y = -80;
				}

				if (this.x > 880)
				{
					this.x = -80;
				}

				if (this.x < -80)
				{
					this.x = 880;
				}




			}


		}
		function onClick(myEvent:Event)
		{


		}

	}

}