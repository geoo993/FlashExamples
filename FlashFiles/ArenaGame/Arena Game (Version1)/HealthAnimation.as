﻿package {	import flash.display.*;	import flash.events.*;	import flash.geom.*;	public class HealthAnimation extends MovieClip	{		public var refM:MovieClip;		public var healthBarColorTransform = new ColorTransform  ;		//public var myColor4:uint = Math.random() * 0xFFFFFF;		public var currentFrameNum:Number = 0;		public var healthState:Boolean = false;		public var alphaControl:String = "dull";		public function HealthAnimation()		{			stage.addEventListener(Event.ENTER_FRAME,gameL);			refM = MovieClip(this.parent);			this.stop();		}		public function gameL(myEvent:Event):void		{			this.gotoAndStop(Math.round(currentFrameNum));						if (healthState == true)			{				if (alphaControl == "full")				{					this.alpha = 1;				}				if (alphaControl == "dull")				{					this.alpha = 0;				}			}			if (healthState == false)			{				if (currentFrameNum > 35)				{					this.filters = [refM.filter_glow];				}				if (currentFrameNum <= 35)				{					this.filters = [];				}				if ((currentFrameNum >= 40))				{					healthBarColorTransform.color = 0xff0000;					this.transform.colorTransform = healthBarColorTransform;				}				else if ((currentFrameNum >= 38))				{					healthBarColorTransform.color = 0xFF3400;					this.transform.colorTransform = healthBarColorTransform;				}				else if ((currentFrameNum >= 36))				{					healthBarColorTransform.color = 0xFF5700;					this.transform.colorTransform = healthBarColorTransform;				}				else if ((currentFrameNum >= 34))				{					healthBarColorTransform.color = 0xFF5700;					this.transform.colorTransform = healthBarColorTransform;				}				else if ((currentFrameNum >= 32))				{					healthBarColorTransform.color = 0xFF6900;					this.transform.colorTransform = healthBarColorTransform;				}				else if ((currentFrameNum >= 30))				{					healthBarColorTransform.color = 0xFF7B00;					this.transform.colorTransform = healthBarColorTransform;				}				else if ((currentFrameNum >= 28))				{					healthBarColorTransform.color = 0xFF8C00;					this.transform.colorTransform = healthBarColorTransform;				}				else if ((currentFrameNum >= 26))				{					healthBarColorTransform.color = 0xFF9E00;					this.transform.colorTransform = healthBarColorTransform;				}				else if ((currentFrameNum >= 24))				{					healthBarColorTransform.color = 0xFF9E00;					this.transform.colorTransform = healthBarColorTransform;				}				else if ((currentFrameNum >= 22))				{					healthBarColorTransform.color = 0xFFAF00;					this.transform.colorTransform = healthBarColorTransform;				}				else if ((currentFrameNum >= 20))				{					healthBarColorTransform.color = 0xFFC100;					this.transform.colorTransform = healthBarColorTransform;				}				else if ((currentFrameNum >= 18))				{					healthBarColorTransform.color = 0xFFD300;					this.transform.colorTransform = healthBarColorTransform;				}				else if ((currentFrameNum >= 16))				{					healthBarColorTransform.color = 0xFFE400;					this.transform.colorTransform = healthBarColorTransform;				}				else if ((currentFrameNum >= 14))				{					healthBarColorTransform.color = 0xFFF600;					this.transform.colorTransform = healthBarColorTransform;				}				else if ((currentFrameNum >= 12))				{					healthBarColorTransform.color = 0xF7FF00;					this.transform.colorTransform = healthBarColorTransform;				}				else if ((currentFrameNum >= 10))				{					healthBarColorTransform.color = 0xE5FF00;					this.transform.colorTransform = healthBarColorTransform;				}				else if ((currentFrameNum >= 8))				{					healthBarColorTransform.color = 0xD4FF00;					this.transform.colorTransform = healthBarColorTransform;				}				else if ((currentFrameNum >= 6))				{					healthBarColorTransform.color = 0xC2FF00;					this.transform.colorTransform = healthBarColorTransform;				}				else if ((currentFrameNum >= 4))				{					healthBarColorTransform.color = 0xB0FF00;					this.transform.colorTransform = healthBarColorTransform;				}				else if ((currentFrameNum >= 2))				{					healthBarColorTransform.color = 0x9FFF00;					this.transform.colorTransform = healthBarColorTransform;				}				else if ((currentFrameNum >= 0))				{					healthBarColorTransform.color = 0x7CFF00;					this.transform.colorTransform = healthBarColorTransform;				}			}		}	}}