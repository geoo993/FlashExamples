package {	import flash.display.*;	import flash.events.*;	import flash.geom.*;	import flash.text.*;
	import fl.motion.*;	public class Main extends MovieClip	{
		public var textsColor:uint = 0xffffff;
		public var textsOutlineColor:uint = Math.random()*0xffffff;
		public var textBackgroundColor:uint = Math.random()*0xffffff;
		
		public var inputField:TextField = new TextField();
		public var myTextFormat:TextFormat = new TextFormat  ;
		
		public var getText:String;
			public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gL);			stage.addEventListener(MouseEvent.CLICK,mouseClick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
					}		public function gL(myEvent:Event):void		{
			
				addChild(inputField);
				
				inputField.type = "input";
				inputField.width = 500;
				inputField.height = 40;
				inputField.x = 50;
				inputField.y = 100;
				inputField.textColor = textsColor;
				inputField.border = true;
				inputField.borderColor = textsOutlineColor;
				inputField.background = true;    
				inputField.backgroundColor = textBackgroundColor; 
				inputField.selectable = true;
				inputField.maxChars = 24;
				inputField.restrict = "A-Z a-z";
				inputField.multiline = false;
				stage.focus = inputField;
				
				inputField.setTextFormat(myTextFormat);
				myTextFormat.italic = true; 
				myTextFormat.size = 20;
				myTextFormat.font = "Comic Sans MS";
				myTextFormat.align = TextFormatAlign.CENTER;
				
				trace(inputField.length)
				getText = inputField.text;   
			
					}
		private function labelText(str:String, x:int, y:int):void
        {
            var tf:TextField = new TextField();
            tf.text = str; tf.x = x; tf.y = y; tf.autoSize = "left";
            tf.setTextFormat(new TextFormat("verdana", 10));
            addChild(tf);
        }
		
		public function kDown(event:KeyboardEvent):void
		{
			if(event.keyCode == 32)
			{
				
			}
			
		}		public function mouseClick(event:MouseEvent):void
		{
			if(event.target == muButton)
			{
				resultText.text = String(getText)
			}
		}
			}}