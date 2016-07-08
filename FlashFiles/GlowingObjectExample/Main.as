package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;	import flash.geom.*;
	import flash.utils.*;
	import fl.motion.Color;
	import com.greensock.*;	public class Main extends MovieClip	{
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		public var color1:uint;
		public var color2:uint;
		
		public var repeatNum:Number = 10;
		
		public var myAngle:int = 0;
		public var myDistance:Number = 0;
		
		public var myBlurX:Number = 0;
		public var myBlurY:Number = 0;
		public var myAlpha:Number = 0;
		
		public var myStrength:Number = 0;
		public var myQuality:int = 0;
		
		public var innerr:Boolean = false;
		public var knockOut:Boolean = false;
		
		public var myColor:uint = Math.random() * 0xFFFFFF;
		public var myColorTransform:ColorTransform = new ColorTransform  ;
		
		public var timer:int = 0;
		public var countingState:Boolean = false;
		
		public var buttonsArray:Array = new Array();
		public var filterType:String = "Blur";		public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gameL);	
			stage.addEventListener(MouseEvent.CLICK,mClick);
			
			createButtons() ;
		}
		public function gameL(myEvent:Event):void
		{
			angleT.text = String("Angle:  "+myAngle);
			alphaT.text = String("Alpha:  "+myAlpha.toFixed(2))
			blurxT.text = String("BlurX:  "+myBlurX);
			bluryT.text = String("BlurY:  "+myBlurY);
			distT.text = String("Distance:   "+myDistance);
			strenghtT.text = String("Strength:   "+myStrength);
			qualityT.text = String("Quality:   "+myQuality);
			filterT.text = filterType;
			innerT.text = String("Inner:  "+innerr);
			knockT.text = String("Knockout:   "+knockOut);
			
			timerT.text = String(timer);
			
			timer++
			if(timer>=120)
			{
				mcFilter(ob1,0,false,myColor,0,0,0,0,0,0,0,innerr,knockOut)	
				countingState = false;
				timer = 0;
			}
			if(countingState == false)
			{
				mcFilter(ob1,repeatNum,true,myColor,myAngle,myAlpha,myBlurX,myBlurY,myDistance,myStrength,myQuality,innerr,knockOut)		
				countingState = true;
			}
			
			colorTransition(ob1,myColor);
		}	
		public function mcFilter(mc:MovieClip,repeatt:Number,yoyoo:Boolean, colour:uint,anglee:Number,alphaa:Number,blurrX:Number,blurrY:Number,dist:Number,strengt:Number,quali:Number,inn:Boolean,knock:Boolean):void 
		{
			mc.filters = [];
			
			if(filterType == "Blur")
			{
				TweenMax.to(mc, .5, {repeat: repeatt, yoyo: yoyoo, blurFilter: {blurX: blurrX, blurY: blurrY,quality:quali}});
			}
			if(filterType == "Glow")
			{
				TweenMax.to(mc, .5, {repeat: repeatt, yoyo: yoyoo, glowFilter: {color: colour, alpha: alphaa, blurX: blurrX, blurY: blurrY, strength: strengt,quality: quali,inner: inn,knockout: knock}});
			}
			if(filterType == "DropShadow")
			{
				TweenMax.to(mc, .5, {repeat: repeatt, yoyo: yoyoo, dropShadowFilter: {color: colour, alpha: alphaa, angle:anglee,blurX: blurrX, blurY: blurrY, distance:dist,strength: strengt,quality:quali,inner:inn,knockout:knock}});
			}
			if(filterType == "None")
			{
				mc.filters = [];
			}
		}
		public function createButtons() 
		{
			for (var i:int = 0; i < 10; i++) 
			{    
				buttonsArray[i] = new myButtons();
				buttonsArray[i].buttonMode = true;
				buttonsArray[i].x = (i) * (buttonsArray[i].width);
				buttonsArray[i].y = 580;
				buttonsArray[i].alpha = 0;
				addChild(buttonsArray[i]);
			}
		}
		public function colorTransition(mc:MovieClip,colour:uint)
		{
			if(colorTransSwitch == "goingUp")
			{
				colorTransNum += 1.5;
			}
			if(colorTransSwitch == "goingDown")
			{
				colorTransNum -= 1.5; 
			}
			if(curVal <= 0)
			{   
				colorTransSwitch = "goingUp";
				color2 = Math.random() * 0xFFFFFF;
			}
			if(curVal >= 1)
			{
				color1 = Math.random() * 0xFFFFFF;
				colorTransSwitch = "goingDown"
			}
			
			curVal = colorTransNum/255;
			
			colour = Color.interpolateColor(color1,color2,curVal);
			
			myColorTransform.color = colour;
			mc.transform.colorTransform = myColorTransform;
		}
		public function mClick(event:MouseEvent):void
		{
			if(event.target == buttonsArray[0])
			{
				if(filterType == "Blur")
				{
					filterType = "Glow";
				}
				else if(filterType == "Glow")
				{
					filterType = "DropShadow";
				}
				else if(filterType == "DropShadow")
				{
					filterType = "None";
				}
				else if(filterType == "None")
				{
					filterType = "Blur";
				}
			}
			if(event.target == buttonsArray[1])
			{
				myAngle += 5;
				if(myAngle >360)
				{
					myAngle = 0;
				}
			}
			if(event.target == buttonsArray[2])
			{
				myAlpha += .1
				if(myAlpha >1)
				{
					myAlpha = 0;
				}
			}
			if(event.target == buttonsArray[3])
			{
				myBlurX += 2;
				if(myBlurX >50)
				{
					myBlurX = 0;
				}
			}
			if(event.target == buttonsArray[4])
			{
				myBlurY += 2;
				if(myBlurY >50)
				{
					myBlurY = 0;
				}
			}
			if(event.target == buttonsArray[5])
			{
				myDistance += 2;
				if(myDistance >40)
				{
					myDistance = 0;
				}
			}
			if(event.target == buttonsArray[6])
			{
				myStrength += 1;
				if(myStrength>5)
				{
					myStrength = 0;
				}
			}
			if(event.target == buttonsArray[7])
			{
				myQuality += 1
				if(myQuality>5)
				{
					myQuality = 0;
				}
			}
			if(event.target == buttonsArray[8])
			{
				innerr = !innerr;
			}
			if(event.target == buttonsArray[9])
			{
				knockOut = !knockOut;
			}
		}	}}