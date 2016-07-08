package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;	import flash.geom.*;	import flash.text.*;	public class Main extends MovieClip	{		public var targett:MovieClip;		public var targett2:MovieClip;		public var myFormat:TextFormat = new TextFormat  ;		public var myText:TextField = new TextField();
				public var keyPress:String = "idle";
		public var thisView:String = "sideView";
		public var indexNum:Number = 0;
		public var carsArray:Array = new Array ();
		
		public var xSpeed:Number = 0;
		public var speedMax:Number = 10;
		public var speedAcceleration:Number = 0.5;
	
		var groundFriction2:Number = 1;
		var speeed2:Number = 0;
		var speedMax2:Number = 8;
		var speedMaxReverse2:Number = -4;
		var speedAcceleration2:Number = .20;
		var speedDeceleration2:Number = .9;
		var steering2:Number = 0;
		var steeringMax2:Number = 2;
		var steeringAcceleration2:Number = .15;
		var steeringFriction2:Number = .95;

		var velocityX:Number = 0;
		var velocityY:Number = 0;
		
		var Up:Boolean = false;
		var Down:Boolean = false;
		var Left:Boolean = false;
		var Right:Boolean = false;
		
		var doorFramesNum:Number = 10;
		var opening:Boolean = false;		public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseD);
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseU);			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);			stage.addEventListener(KeyboardEvent.KEY_UP,kUp);			stop();
			buss2.door.stop();
						targett = buss1;			targett2 = car1;
			
			carsArray[0] = buss1;
			carsArray[1] = car1;
			carsArray[2] = car2;
			carsArray[3] = car3;
			carsArray[4] = car4;
			carsArray[5] = car5;
			carsArray[6] = car6;
			carsArray[7] = car7;
			carsArray[8] = buss2;
			carsArray[9] = car8;
			carsArray[10] = car9;
			carsArray[11] = car10;
					}		public function gL(myEvent:Event):void		{
						buss2.door.gotoAndStop(doorFramesNum);
			
			if(opening == false)
			{
				doorFramesNum += 1;
				
				if(doorFramesNum >= 19)
				{
					doorFramesNum = 19;
				}
			}
			if(opening == true)
			{
				doorFramesNum -= 1;
				
				if(doorFramesNum <= 1)
				{
					doorFramesNum = 1;
				}
			}
			
			if(keyPress == "Left")
			{
				AllCar2(carsArray[indexNum],true,false,true);
			}
			if(keyPress == "Right")
			{
				AllCar2(carsArray[indexNum],true,true,false)
			}
			
			if(keyPress == "idle")
			{
				AllCar2(carsArray[indexNum],false,false,false);
			}
					for (var i:Number = 0; i <2; i += 1)			{				var tempParticle:Circle = new Circle(this);				this.addChild(tempParticle);				tempParticle.x = targett.x + 8;				tempParticle.y = targett.y + 104;			}			for (var o:Number = 0; o <2; o += 1)			{				var tempParticle2:Circle = new Circle(this);				this.addChild(tempParticle2);				tempParticle2.x = targett2.x + 8;				tempParticle2.y = targett2.y + 40;			}
			
				if (Up == true)
				{
					
					if ((speeed2 < speedMax2))
					{
						speeed2 +=  speedAcceleration2;

						if ((speeed2 > speedMax2))
						{

							speeed2 = speedMax2;
						}
					}
				}

				if (Down == true)
				{
					
					if ((speeed2 > speedMaxReverse2))
					{

						speeed2 -=  speedAcceleration2;

						if ((speeed2 < speedMaxReverse2))
						{
							speeed2 = speedMaxReverse2;
						}
					}
				}
				if (Left == true)
				{
					
					steering2 -=  steeringAcceleration2;

					if ((steering2 > steeringMax2))
					{

						steering2 = steeringMax2;
					}
				}


				if (Right == true)
				{
				
					steering2 +=  steeringAcceleration2;

					if ((steering2 <  -  steeringMax2))
					{ 
						steering2 =  -  steeringMax2;
					}
				}

				speeed2 *=  groundFriction2;

				if ((speeed2 > 0) && speeed2 < 0.05)
				{
					speeed2 = 0;
				}

				velocityX = Math.sin(carsArray[8].rotation * Math.PI / 180) * speeed2;
				velocityY = Math.cos(carsArray[8].rotation * Math.PI / 180) *  -  speeed2;


				carsArray[8].x +=  velocityX;
				carsArray[8].y +=  velocityY;


				if (steering2 > 0)
				{
					if (steering2 < 0.05)
					{
						steering2 = 0;
					}
				}
				else if (steering2 < 0)
				{
					if (steering2 > -0.05)
					{
						steering2 = 0;
					}
				}

				steering2 = steering2 * steeringFriction2;

				steering2 -=  (steering2 * 0.1);

				carsArray[8].rotation +=  steering2 * speeed2;
			
		}
		public function AllCar2(newCar:MovieClip,MovingState:Boolean,Right:Boolean,Left:Boolean):void
		{
			
			if (MovingState == true)
			{
				if (Right == true)
				{
					
					xSpeed +=  speedAcceleration;
					wRight();

					if (xSpeed > speedMax)
					{
						xSpeed = speedMax;
					}
				}

				if (Left == true)
				{
					xSpeed -=  speedAcceleration;
					wLeft();

					if (xSpeed < -speedMax)
					{
						xSpeed =  -  speedMax;

					}
				}
				
			}
			if (MovingState == false)
			{
				if (xSpeed > 0 + speedAcceleration)
				{
					xSpeed -=  speedAcceleration;
					wRight();
				}
				else if (xSpeed < 0 - speedAcceleration)
				{
					xSpeed +=  speedAcceleration;
					wLeft();
				}
				else
				{
					xSpeed = 0;
				}
			}
		
			newCar.x +=  xSpeed;
			
		}
		public function wRight()
		{	
			if(indexNum == 0)
			{
			buss1.wheel1.rotation +=  10;
			buss1.wheel2.rotation +=  10;
			buss1.wheel3.rotation +=  10;
			}
			if(indexNum == 1)
			{
			car1.rWheel.rotation +=  10;
			car1.lWheel.rotation +=  10;
			}
			if(indexNum == 2)
			{
			car2.rWheel.rotation +=  10;
			car2.lWheel.rotation +=  10;
			}
			if(indexNum == 3)
			{
			car3.rWheel.rotation +=  10;
			car3.lWheel.rotation +=  10;
			}
			if(indexNum == 4)
			{
			car4.rWheel.rotation +=  10;
			car4.lWheel.rotation +=  10;
			}
			if(indexNum == 5)
			{
			car5.rWheel.rotation +=  10;
			car5.lWheel.rotation +=  10;
			}
			if(indexNum == 6)
			{
			car6.rWheel.rotation +=  10;
			car6.lWheel.rotation +=  10;
			}
			if(indexNum == 7)
			{
			car7.rWheel.rotation +=  10;
			car7.lWheel.rotation +=  10;
			}
			if(indexNum == 9)
			{
			car8.rWheel.rotation +=  10;
			car8.lWheel.rotation +=  10;
			}
			if(indexNum == 10)
			{
			car9.rWheel.rotation +=  10;
			car9.lWheel.rotation +=  10;
			}
			if(indexNum == 11)
			{
			car10.rWheel.rotation +=  10;
			car10.lWheel.rotation +=  10;
			}
			
			
		}
		public function wLeft()
		{
			if(indexNum == 0)
			{
			buss1.wheel1.rotation -=  10;
			buss1.wheel2.rotation -=  10;
			buss1.wheel3.rotation -=  10;
			}
			
			if(indexNum == 1)
			{
			car1.rWheel.rotation -=  10;
			car1.lWheel.rotation -=  10;
			}
			if(indexNum == 2)
			{
			car2.rWheel.rotation -=  10;
			car2.lWheel.rotation -=  10;
			}
			if(indexNum == 3)
			{
			car3.rWheel.rotation -=  10;
			car3.lWheel.rotation -=  10;
			}
			if(indexNum == 4)
			{
			car4.rWheel.rotation -=  10;
			car4.lWheel.rotation -=  10;
			}
			if(indexNum == 5)
			{
			car5.rWheel.rotation -=  10;
			car5.lWheel.rotation -=  10;
			}
			if(indexNum == 6)
			{
			car6.rWheel.rotation -=  10;
			car6.lWheel.rotation -=  10;
			}
			if(indexNum == 7)
			{
			car7.rWheel.rotation -=  10;
			car7.lWheel.rotation -=  10;
			}
			if(indexNum == 9)
			{
			car8.rWheel.rotation -=  10;
			car8.lWheel.rotation -=  10;
			}
			if(indexNum == 10)
			{
			car9.rWheel.rotation -=  10;
			car9.lWheel.rotation -=  10;
			}
			if(indexNum == 11)
			{
			car10.rWheel.rotation -=  10;
			car10.lWheel.rotation -=  10;
			}
			

		}
		public function mouseD(event:MouseEvent):void
		{
			if(event.target == buss1.bbody)
			{
				carsArray[0].startDrag();
			}
		}
		public function mouseU(event:MouseEvent):void
		{
			if(event.target == buss1.bbody)
			{
				carsArray[0].stopDrag();
			}
		}		function Destroy(temp:MovieClip):void		{			this.removeChild(temp);			temp = null;		}		public function kDown(event:KeyboardEvent):void		{
			if (event.keyCode == 32)
				{
					opening = !opening;
				}
			
				if (event.keyCode == 81)
				{
					indexNum = 0;
				}
				if (event.keyCode == 87)
				{
					indexNum = 1;
				}
				if (event.keyCode == 69)
				{
					indexNum = 2;
				}
				if (event.keyCode == 82)
				{
					indexNum = 3;
				}
				if (event.keyCode == 84)
				{
					indexNum = 4;
				}
				if (event.keyCode == 89)
				{
					indexNum = 5;
				}
				if (event.keyCode == 85)
				{
					indexNum = 6;
				}
				if (event.keyCode == 73)
				{
					indexNum = 7;
				}
				if (event.keyCode == 79)
				{
					indexNum = 8;
				}
				if (event.keyCode == 80)
				{
					indexNum = 9;
				}
				if (event.keyCode == 65)
				{
					indexNum = 10;
				}
				if (event.keyCode == 83)
				{
					indexNum = 11;
				}
				
				if (event.keyCode == 39)
				{
					if(indexNum == 8)
					{
						Right = true;
					}
					else
					{
						keyPress = "Right";
					}
				}
				if (event.keyCode == 37)
				{
					if(indexNum == 8)
					{
						Left = true;
					}
					else
					{
						keyPress = "Left";
					}
				}
				if (event.keyCode == 38)
				{
					if(indexNum == 8)
					{
						Up = true;
					}
					else
					{
						keyPress = "Up";
					}
				}
				if (event.keyCode == 40)
				{
					if(indexNum == 8)
					{
						Down = true;
					}
					else
					{
						keyPress = "Down";
					}
				}
					}		public function kUp(event:KeyboardEvent):void		{			
				if (event.keyCode == 39)
				{
					if(indexNum == 8)
					{
						Right = false;
					}
					else
					{
						keyPress = "idle";
					}
				}
				if (event.keyCode == 37)
				{
					if(indexNum == 8)
					{
						Left = false;
					}
					else
					{
						keyPress = "idle";
					}
				}
				if (event.keyCode == 38)
				{
					if(indexNum == 8)
					{
						Up = false;
					}
					else
					{
						keyPress = "idle";
					}
				}
				if (event.keyCode == 40)
				{
					if(indexNum == 8)
					{
						Down = false;
					}
					else
					{
						keyPress = "idle";
					}
				}
					}	}}