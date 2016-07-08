package {	import flash.display.*;	import flash.events.*;	import flash.geom.*;	import flash.text.*;	import flash.filters.*;	public class Main extends MovieClip	{		public var myColor1:uint = Math.random() * 0xffffff;		
		public var speeed:Number = 5;		public var flashLightType:Boolean = false; 
		
		public var up:Boolean = false;
		public var down:Boolean = false;
		public var left:Boolean = false;
		public var right:Boolean = false;		public var rotationDirection:Number = 0;		public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,kUp);		}		public function gL(myEvent:Event):void		{       
			
			rotationDirection = Math.round(180 - ((Math.atan2(stage.mouseX - player.x, stage.mouseY - player.y)) * 180/Math.PI));
	
			player.rotation = rotationDirection;	
			filter.rotation = rotationDirection;
			filter2.rotation = rotationDirection;
			maskk.rotation = rotationDirection;	
			
			if(flashLightType == false)
			{
				//mapp.alpha = 1;
				filter.visible = true;
				filter2.visible = false;
			}
			if(flashLightType == true)
			{
				//mapp.alpha = 0;
				filter.visible = false;
				filter2.visible = true;
			}
			
			if(up == true)
			{
				player.y -= speeed;
				filter.y -= speeed;
				filter2.y -= speeed;
				maskk.y -= speeed;
			}
			if(down == true)
			{
				player.y += speeed;
				filter.y += speeed;
				filter2.y += speeed;
				maskk.y += speeed;
			}
			if(left == true)
			{
				player.x -= speeed;
				filter.x -= speeed;
				filter2.x -= speeed;
				maskk.x -= speeed;
			}
			if(right == true)
			{
				player.x += speeed;
				filter.x += speeed;
				filter2.x += speeed;
				maskk.x += speeed;
			}					}
		function kDown(event:KeyboardEvent):void
		{  
			if (event.keyCode == 32)
			{
				flashLightType = !flashLightType;
			}
			
			if (event.keyCode == 38)
			{
				up = true;
			}
			if (event.keyCode == 40)
			{
				down = true;
			}
			
			if (event.keyCode == 37)
			{
				left = true
			}
			if (event.keyCode == 39)
			{
				right = true;
			}
		}
		function kUp(event:KeyboardEvent):void
		{
			if (event.keyCode == 38)
			{
				up = false;
			}
			if (event.keyCode == 40)
			{
				down = false;
			}
			if (event.keyCode == 37)
			{
				left = false;
			}
			if (event.keyCode == 39)
			{
				right = false;
			}
		}			}}
