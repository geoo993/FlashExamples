package {	import flash.display.*;	import flash.events.*;	import flash.geom.*;	import flash.text.*;	import flash.filters.*;	public class Main extends MovieClip	{		public var myColor1:uint = Math.random() * 0xffffff;		public var textt:String;		//public var myTextFormat:TextFormat = new TextFormat("Comic Sans MS",15,myColor1)  ;		public var myTextFormat:TextFormat = new TextFormat  ;		public var myText:TextField = new TextField();		public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gL);					}		public function gL(myEvent:Event):void		{       
			textt = "I would like to scroll.";			//addChild(myText);			//myText.border = true;			//myText.textColor = myColor1;			//myText.borderColor = 0xFF0000;			//myText.wordWrap = true;			//myText.width = 150;			//myText.height = 40;			//myText.x = 100;			//myText.y = 100;
			
			//Rectangle at x, y, width, height
			fBoxx.scrollRect = new Rectangle(0,0,200,20);
			fBoxx.newT.x -= 2;
			fBoxx.newT.text = textt;
			
			if (Math.abs(fBoxx.newT.x) >= fBoxx.newT.width)
			{
				fBoxx.newT.x = 200;
			}						mcText.multiline = false;			mcText.wordWrap = false;			mcText.text = textt;			mcText.setTextFormat(myTextFormat);			myTextFormat.color = myColor1;			myTextFormat.size = 15;			myTextFormat.align = TextFormatAlign.LEFT;			mcText.x -=  2;			if (Math.abs(mcText.x) <= mcText.width - 100)			{				myColor1 = Math.random() * 0xffffff;				mcText.x = 500;			}		}			}}