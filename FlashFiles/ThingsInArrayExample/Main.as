package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;	import flash.geom.*;	import flash.text.*;	public class Main extends MovieClip	{		
		public var myArray:Array = new Array;
		
		public var myColor:uint = Math.random()*0xFFFFFF;
		public var myColorTransform:ColorTransform = new ColorTransform  ;
				public var numShapes:Number = 10;
				public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);			myShapess()
					}		public function gL(myEvent:Event):void		{
									trace(myArray.length)		}		public function myShapess()
		{
			for (var a:uint = 0; a < numShapes; a ++)
			{
				myArray[a] = new Sprite()
				myArray[a].graphics.clear()
				myArray[a].graphics.beginFill(myColor,1);
				myArray[a].graphics.drawCircle(0,0,18);
				myArray[a].graphics.endFill()
				addChild(myArray[a]);
				
				myArray[a].x = 50 +(a % 10) * (myArray[a].width+40);
				myArray[a].y = 50+ int(a / 10) * (myArray[a].height+20);
			}
			
		
		}		
		public function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.random() * (maxNum - minNum) + 1 + minNum;
		}
		public function kDown(event:KeyboardEvent):void
		{
			if (event.keyCode == 32)
			{   
				//myColor = Math.random() * 0xffffff;
				myColorTransform.color = Math.random() * 0xffffff;
				
				numShapes ++;if(numShapes>=80){numShapes=80};
				
				myShapess()
				
				/*for (var a:uint = 0; a < myArray.length-(myArray.length-3); a ++)
				{
					myArray[a].transform.colorTransform = myColorTransform;
				}
				for (var a:uint = 2; a < myArray.length-2; a ++)
				{
					myArray[a].transform.colorTransform = myColorTransform;
				}
				for (var a:uint = myArray.length-4; a < myArray.length; a ++)
				{
					myArray[a].transform.colorTransform = myColorTransform;
				}
				
				for (var a:uint = randomRange(0,myArray.length) ; a < myArray.length-randomRange(0,myArray.length); a ++)
				{
					myArray[a].transform.colorTransform = myColorTransform;
				}*/
				for (var a:uint = randomRange(0,(myArray.length/2)) ; a < myArray.length-randomRange(0,(myArray.length/2)); a ++)
				{
					myArray[a].transform.colorTransform = myColorTransform;
				}
				
				
			}
			
			
		}	}}