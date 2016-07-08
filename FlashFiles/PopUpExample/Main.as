package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;
	import flash.text.*;	import flash.geom.*;	import fl.motion.*;	import com.greensock.*;	import com.greensock.easing.*;	public class Main extends MovieClip	{
		public var sColor:uint = Math.random()*0xffffff;
	
		public var numOfBoxes:uint = 45;
		public var cols:uint = 9;
		
		public var xOffset:Number = 100;
		public var yOffset:Number = 100;
		
		public var spriteArray:Array = new Array();
		public var sPosArray:Array = new Array();
		
		public var selectedSprite:Sprite;
		public var currentIndex:uint;
		public var TextColor:uint = Math.random() * 0xffffff;
		
		public var canvas:Sprite;
			public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gL);
			stage.color = Math.random()*0xFFFFFF;
			
			createBoxes();
			addListeners();		}
		public function gL(myEvent:Event):void
		{
			
		}
		
		function createBoxes()
		{
			for (var i:uint = 0; i < numOfBoxes; i++) 
			{
			   var s:Sprite = new Sprite();
			   s.graphics.beginFill(Math.random() * 0xffffff,1);
			   s.graphics.drawRect(0, 0, 60, 60);
			   s.graphics.endFill();
				addChildAt(s,0);
	
			   s.x = 50+xOffset * (i%cols);
			   s.y = 60+yOffset * int(i/cols);
			   
			   spriteArray.push(s);
			   sPosArray.push({xpos:spriteArray[i].x, ypos:spriteArray[i].y})    
			}
		}		function addListeners():void
		{
		  for (var i:uint = 0; i < spriteArray.length; i++) {
			  spriteArray[i].buttonMode = true;
			  spriteArray[i].addEventListener(MouseEvent.CLICK, clickHandler);
		  }
		}
		
		function removeListeners():void
		{
		  for (var i:uint = 0; i < spriteArray.length; i++) 
		{
			  spriteArray[i].buttonMode = false;
			  spriteArray[i].removeEventListener(MouseEvent.CLICK, clickHandler);
		  }
		}
		
		function clickHandler(e:MouseEvent):void
		{
		  selectedSprite = e.currentTarget as Sprite;
		  currentIndex = spriteArray.indexOf(e.currentTarget);
			
		  setChildIndex(selectedSprite, numChildren - 1);
		 
		  removeListeners();
			
			//for (var i:uint = 0; i < spriteArray.length; i++) 
			//{}
			//if(spriteArray[i] != spriteArray[currentIndex])
			//{}

				TweenNano.to(selectedSprite, 1, {
					   x:stage.stageWidth/2 - selectedSprite.width,
					   y:stage.stageHeight/2 - selectedSprite.height,
													   ease:Elastic.easeOut,
					   onComplete: onCenter});
			
		}
		function onCenter():void
		{
				TweenNano.to(selectedSprite, 0.5, {scaleX:3, scaleY:3});
				selectedSprite.buttonMode = true;
				selectedSprite.addEventListener(MouseEvent.CLICK, spriteClick);
				
		}
		
		
		function spriteClick(e:MouseEvent):void
		{
		  TweenNano.to(selectedSprite, 1, {scaleX:1,
					   scaleY:1,
					   x:sPosArray[currentIndex].xpos,
					   y:sPosArray[currentIndex].ypos,
													   ease:Elastic.easeIn,
					   onComplete:addListeners});
		 
		  selectedSprite.buttonMode = false;
		  selectedSprite.removeEventListener(MouseEvent.CLICK, spriteClick);
		}		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}			}}