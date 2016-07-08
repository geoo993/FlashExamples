package {	import flash.display.*;	import flash.events.*;	import flash.geom.*;
	import flash.filters.*;
	import fl.motion.*;
	import com.greensock.*;
	import com.greensock.easing.*;
		public class Main extends Sprite
	{
		
		public var sArray:Array = new Array();;
		public var canvas:Sprite;
		public var s:Sprite;
		
		public var numberOfShapes:uint = 6;
		
		public var hoverArray:Array = new Array();
		public var currentShape:Sprite;
		public var currentIndex:uint;
		public var currentPoint:Point = new Point(0,0);
		//public var currentPoint:Object = {x:0,y:0}
		
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		public var color1:uint;
		public var color2:uint;
		
		//public var sColor:uint = Math.random() * 0xFFFFFF;
		public var myColor:uint = Math.random() * 0xFFFFFF;
		
		public var sColor:uint = Math.random() * 0xFFFFFF;
		public var sColor2:uint = Math.random() * 0xFFFFFF;
		public var shapesColorTransform = new ColorTransform  ;
				public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gloop);
			
			createCanvas();
			drawShapes()
			
			//createHov(); 
		}
		
		public function gloop(myEvent:Event):void
		{ 
			backgroundColorTransition()
		}
		public function createCanvas()
		{
			canvas = new Sprite()
			addChild(canvas); 
			
		}
		function createHov()
		{
			if(hoverArray.length<3)
			{
				for(var i:uint=0;i<3;i++)
				{
					hoverArray[i] = new Sprite();
					hoverArray[i].graphics.beginFill(myColor,1);
					hoverArray[i].graphics.drawCircle(0,0,40);
					hoverArray[i].graphics.endFill();
					canvas.addChildAt(hoverArray[i],0);
					
					//hoverArray[i].alpha = 0;
				}
			}
		}
		public function drawShapes()
		{
			
			for(var i:uint = 0; i< numberOfShapes; i++)
			{
				s = new Sprite();
				s.buttonMode = true;
				s.graphics.clear();
				s.graphics.lineStyle(4,sColor,1);
				s.graphics.beginFill(sColor,1);
				
				s.graphics.drawCircle(0, 0, 20);
				
				s.graphics.endFill();
			
				canvas.addChildAt(s,0);
				sArray.push(s);
				
				s.x += 100 +(i * 200);
				s.y = stage.stageHeight/2;
				
				s.addEventListener(MouseEvent.MOUSE_OVER, sOver);
				s.addEventListener(MouseEvent.MOUSE_OUT, sOut);
			}
		}
		function sOver(e:MouseEvent)
		{   
			//currentIndex = sArray.indexOf(e.currentTarget);
			currentIndex = sArray.indexOf(currentShape);
			
			currentShape = e.target as Sprite; 
			
			currentPoint.x = e.target.x;
			currentPoint.y = e.target.y;
			
			createHov(); 
			
			for(var i:uint=0;i<hoverArray.length;i++)
			{
				var startX = currentPoint.x + Math.random() *100-50;
				var startY = currentPoint.y + Math.random() *100-50;
					
				hoverArray[i].x = startX;
				hoverArray[i].y = startY;
					
				var size:Number = randomRange(0,10) + 100;
				hoverArray[i].width = size;
				hoverArray[i].height = size;
					
				TweenLite.to(hoverArray[i], 0.5, {width:size, alpha:1, height:size,x:currentPoint.x + randomRange(0,30),y:currentPoint.y+ randomRange(0,30), ease:Strong.easeOut, onComplete:continueTweening, onCompleteParams:[hoverArray[i]]  });
				
			}
		}
		
		function sOut(e:MouseEvent)
		{
			for(var i in hoverArray)
			{
				var startX = currentPoint.x + Math.random() *200-50;
				var startY = currentPoint.y + Math.random() *200-50;
				
				TweenLite.to( hoverArray[i], 0.2, {x:startX ,y:startY,alpha:0, onComplete:remover, onCompleteParams:[hoverArray[i]] });
			}
		}
		function continueTweening(mc:Sprite)
		{
			TweenLite.to(mc, 2, {x:currentPoint.x + randomRange(0,30) ,y:currentPoint.y+ randomRange(0,30),ease:Sine.easeInOut, onComplete:continueTweening, onCompleteParams:[mc] });
			
			//TweenMax.to(mc, .5, {repeat: 10, yoyo: true, blurFilter: {blurX: 20, blurY: 20,quality:2},onComplete:continueTweening,onCompleteParams:[mc] });	
			TweenMax.to(mc, .5, {repeat: 10, yoyo: true, glowFilter: {alpha: .8, blurX: 20, blurY: 20, strength: 3,quality: 3,inner: false,knockout: false},onComplete:continueTweening,onCompleteParams:[mc] });
			
		}
		
		function remover(mcChild:Sprite)
		{   
			hoverArray.splice(0);
			mcChild.parent.removeChild(mcChild);
			
		}
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
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
				sColor2  = Math.random() * 0xFFFFFF;
			}
			if(curVal >= 1)
			{
				colorTransSwitch = "goingDown"
				color1 = Math.random() * 0xFFFFFF;
				sColor  = Math.random() * 0xFFFFFF;
			}
			
			curVal = colorTransNum/255;
			stage.color = Color.interpolateColor(color1,color2,curVal);
			
			for (var i:uint = 0; i < hoverArray.length; i++)
			{
				shapesColorTransform.color = Color.interpolateColor(sColor,sColor2,curVal);
				hoverArray[i].transform.colorTransform = shapesColorTransform;
			}
			
		}	}}