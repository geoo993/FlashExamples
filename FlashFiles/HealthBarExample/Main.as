package 
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.text.*;
	import flash.geom.*;
	import fl.motion.Color;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	public class Main extends MovieClip
	{
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		public var color1:uint;
		public var color2:uint;
		
		public var hText:TextField = new TextField();
		public var hTextFormat:TextFormat = new TextFormat  ;
		public var TextColor:uint = Math.random() * 0xffffff;
		public var healthTransition:Number;
		public var healthTransitionCount:Number = 255;
		public var healthColor1:uint = 0xFF0000;
		public var healthColor2:uint = 0x00FF00;
		public var healthColorTransform = new ColorTransform  ;
		
		public var maxHP:int = 100;
		public var currentHP:int = maxHP;
		public var percentHP:Number = currentHP / maxHP;

		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gameLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			stage.addEventListener(MouseEvent.CLICK,mouseClick);
		}
		public function gameLoop(myEvent:Event)
		{
			backgroundColorTransition();
			
			//trace(currentHP)
			//trace(255/100)//2.55 1%
			//trace(255/100*2)//5.1 2% 
			trace(healthTransitionCount)
			updateHealthBar();
			HealthBarText();
			
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
			
		}
		public function HealthBarText()
		{
			
			addChild(hText);
			hText.text = currentHP+" %"+"  Health".toString();
			hText.textColor = TextColor;
			hText.width = 200;
			hText.height = 50;
			hText.selectable = false;
			hText.setTextFormat(hTextFormat);
			hTextFormat.italic = true; 
			hTextFormat.size = 25;
			hTextFormat.font = "Comic Sans MS";
			hTextFormat.align = TextFormatAlign.CENTER;
			
			hText.x = 500;
			hText.y = 300;
		}
		public function updateHealthBar():void
		{
			percentHP = currentHP / maxHP;
			//healthBar.barColor.scaleX = percentHP;
			
			TweenNano.to(healthBar.barColor, 1, {scaleX:percentHP});
			//TweenLite.to(healthBar.barColor, 1, {scaleX:percentHP});
			
			if(currentHP <= 0)
			{
				currentHP = 0;
				//trace("You died! :P");
			}
			
			healthTransition = healthTransitionCount/255;
			healthColorTransform.color = Color.interpolateColor(healthColor1,healthColor2,healthTransition);
			healthBar.barColor.transform.colorTransform = healthColorTransform;
		}
	
		function kDown(event:KeyboardEvent):void
		{  
			if (event.keyCode == 32)
			{
				currentHP = 100;
				healthTransitionCount = 255;
			}
		}
		public function mouseClick(event:MouseEvent):void
		{
			if(currentHP > 0)
			{
				if(event.target == sAttackButton)
				{
					currentHP -= 2;
					healthTransitionCount -= 5.1;
				}
				if(event.target == bAttackButton)
				{
					currentHP -= 10;
					healthTransitionCount -= 25.5;
				}
			}
		}


	}

}