package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;	import flash.geom.*;	import flash.text.*;	import fl.motion.*;	import com.greensock.*;	import com.greensock.easing.*;	public class Main extends MovieClip	{
		public var sColor:uint = Math.random()*0xffffff;
		
		public const Scaler:uint = 4;
		public const columns:uint = 10;
		public const xOffset:uint = 90;
		public const yOffset:uint = 90;
		public const NumOfSprites:uint = 60;
	  
		public var points:Array = new Array();
		public var squaresArray:Array = new Array();
		
		public var holder:Sprite;
		public var TextColor:uint = Math.random() * 0xffffff;
		
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		public var color1:uint;
		public var color2:uint;
			public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gL);
			clickZoom();		}		public function gL(myEvent:Event):void		{
			backgroundColorTransition()		}
		
		public function createSprite(w:Number, h:Number, colour:uint, alphaa:Number):Sprite
		{
		   var s:Sprite = new Sprite();
		   s.graphics.beginFill(colour, alphaa);
		   s.graphics.drawRect(0,0,w,h);
		   s.graphics.endFill();
		   return s;
		 
		}
		public function clickZoom()
		{
			var bg:Sprite = createSprite(stage.stageWidth, stage.stageHeight, 0x000000, 0);
			bg.addEventListener(MouseEvent.CLICK, bgClicked);
			addChild(bg);
			
			holder = new Sprite();
			holder.addEventListener(MouseEvent.CLICK, clickHandler);
			addChild(holder);
			
			for (var i:uint = 0; i < NumOfSprites; i++) 
			{
				var s:Sprite = createSprite(60, 50, sColor,.5);
				s.x = 50 + xOffset * (i % columns);
				s.y = 50 + yOffset * int(i / columns);
				s.buttonMode = true;
				holder.addChildAt(s,0);
				squaresArray.push(s);
				
				var TextOneText:TextField = new TextField();
				var TextOneFormat:TextFormat = new TextFormat  ;
				holder.addChildAt(TextOneText,0);
				
				TextOneText.text = String(i+1);
				TextOneText.textColor = TextColor;  
				TextOneText.width = 20;
				TextOneText.height = 20;
				TextOneText.selectable = false;
				TextOneText.setTextFormat(TextOneFormat);
				TextOneFormat.italic = true; 
				TextOneFormat.size = 12;
				TextOneFormat.font = "Comic Sans MS";
				TextOneFormat.align = TextFormatAlign.CENTER;
				TextOneText.x = s.x+23;
				TextOneText.y = s.y+20;
				
				
				var p:Point=new Point(); 
				p = holder.localToGlobal( new Point(squaresArray[i].x, squaresArray[i].y) );
				points.push(new Point(p.x, p.y))
			}
		
		}
		private function clickHandler(e:MouseEvent):void 
		{
			var index:int = squaresArray.indexOf(e.target);
		
			var xPos:Number = stage.stageWidth/2 - (points[index].x + squaresArray[index].width/2) * Scaler; 
			var yPos:Number = stage.stageHeight/2 - (points[index].y + squaresArray[index].height/2) * Scaler;
		
			if(squaresArray[index].hitTestPoint(mouseX,mouseY))
			{
				TweenNano.to(holder, 1, {x: xPos, y: yPos, scaleX: Scaler, scaleY: Scaler, ease:Sine.easeOut});
			}
			
			trace(xPos+" "+yPos)
		}
		private function bgClicked(e:MouseEvent):void
		{
			TweenNano.to(holder, 1, {scaleX: 1, scaleY: 1, x:0, y:0});
		}
		
		public function backgroundColorTransition()
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
			
		}			}}