package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;	import flash.geom.*;	import flash.text.*;	import fl.motion.*;	import com.greensock.*;	import com.greensock.easing.*;	public class Main extends MovieClip	{
		public var sColor:uint = Math.random()*0xffffff;
		
		public var mArray:Array = new Array();
	    public var spreadArray:Array = new Array();
		public var points:Array = new Array();
		
		public var currentIndex:int = 0;
		public var selectedSprite:Sprite;
		
		public var state:Boolean = false
		public var isSpread:Boolean = false;
		
		public var s:Sprite;
		
		public var xOffset:Number = 40;
		public var yOffset:Number = 40;
		
		public var cols:Number = 20;
		public var spreadCount:Number = 0;
		
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		public var color1:uint;
		public var color2:uint;
		
		var now:int = 0;
		var thn:int = 0;
				public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(MouseEvent.CLICK,mClick);
						CreateS()		}		public function rotateS():void
		{
			for (var i:uint = 0; i < mArray.length; i++)
			{ 
				var rotationDirection:Number = Math.round(180 - ((Math.atan2(stage.mouseX - mArray[i].x, stage.mouseY - mArray[i].y)) * 180/Math.PI));
				mArray[i].rotation = rotationDirection;	
			}
		}		public function gL(myEvent:Event):void		{
			rotateS();
			backgroundColorTransition()
			//trace(isSpread+"  "+spreadCount+"  "+spreadArray.length+"  "+mArray.length)
			
			if(state == true)
			{   
				
				if(mArray[currentIndex].x == points[currentIndex].x && mArray[currentIndex].y == points[currentIndex].y)
				{
					//trace("yesss  "+spreadCount)  
					spreadCount++
				}
				else
				{
					//trace("noo  "+spreadCount)
					spreadCount = 0;
				}
				
				//spreadCount++
				for (var i:uint = 0; i < spreadArray.length; i++)
				{    
					//trace(i+"  "+spreadArray[i].x +"  "+exploArray[i].y)
					spreadArray[i].x -= (mArray[currentIndex].x - spreadArray[i].x) / 30;
					spreadArray[i].y -= (mArray[currentIndex].y - spreadArray[i].y) / 30;
				} 
				if(spreadCount> 20)
				{
					spreadCount = 0;
					state = false;
				}
				
			}
					}
		
		public function CreateS()
		{
			for (var i:uint = 0; i < 240; i++)
			{
				s = new Circ();
				s.graphics.clear();
				s.graphics.lineStyle(2,0x000000,1,true);
				s.graphics.beginFill(sColor,1);
				s.graphics.moveTo(0,0);
				
				for (var j:uint = 0; j <= 360; j++) 
				{
					s.graphics.lineTo(10 * Math.sin(j*Math.PI/180), -10 * Math.cos(j*Math.PI/180));
				}
				s.graphics.endFill();
			
				addChild(s);
				mArray.push(s);
				
				s.x = 140+xOffset * (i%cols);
				s.y = 100+yOffset * int(i/cols);
				s.buttonMode = true;
				
				points.push(new Point(s.x, s.y))
				
			}
		}		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}		public function backgroundColorTransition()
		{

			if(colorTransSwitch == "goingUp")
			{
				colorTransNum += 1;
			}
			if(colorTransSwitch == "goingDown")
			{
				colorTransNum -= 1; 
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
			stage.color = Color.interpolateColor(color1,color2,curVal);
			
		}
		public function mClick(e:MouseEvent)
		{
			if (e.target is Circ) 
			{  
				selectedSprite = e.target as Sprite; 
				currentIndex = mArray.indexOf(selectedSprite); 
				
				
				trace(currentIndex)
				now = currentIndex;
				
				for (var q:uint = 0; q < mArray.length; q++)
				{ 
					if(mArray[q].x != points[q].x || mArray[q].y != points[q].y)
					{
						if(now > thn)
						{
							backNormal();
							//trace("Got larger."+currentIndex);
						}
						else if(now < thn)
						{
							backNormal();
							//trace("Got smaller."+currentIndex);
						}
						else
						{
							//trace("Maintained value."+currentIndex);
						}
					
					}
				}
				thn = now;
				
				
				if(isSpread == false)
				{
					for (var i:uint = 0; i < mArray.length; i++)
					{  
						if(mArray[i] != mArray[currentIndex])
						{
							spreadArray.push(mArray[i])
							state = true;
						}
					}
					isSpread = true;
				}
				
				return; 
			}
			
			if(isSpread == true)
			{
				backNormal();
			}
			
		}
		public function backNormal()
		{
			spreadArray.splice(0);
			
			for (var a:uint = 0; a < mArray.length; a++)
			{ 
				TweenNano.to(mArray[a], .4, {x:points[a].x, y:points[a].y});
			}
			isSpread = false;
		}	}}
