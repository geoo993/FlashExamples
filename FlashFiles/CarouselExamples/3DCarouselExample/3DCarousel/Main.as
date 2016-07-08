package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;	import flash.geom.*;
	import fl.motion.*;
	import flash.text.*;
	import com.greensock.*;
	import com.greensock.easing.*;	public class Main extends MovieClip
	{
		var pp:PerspectiveProjection=new PerspectiveProjection();
		
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		public var color1:uint;
		public var color2:uint;
		
		public var rotationValue:Number;
		public var shapesColor:uint = Math.random() * 0xFFFFFF;
		public var shapesColor2:uint = Math.random() * 0xFFFFFF;
		
		public var numOfShapes:uint = 10;
		public var myShapesArray:Array = new Array  ;
		
		public var textArray:Array = new Array();
		public var container:MovieClip =  new MovieClip();;
		public var outline:Sprite = new Sprite();
		public var thisShape:Sprite;
		
		public var currentShapeIndex:uint;
		public var selectedShape:MovieClip;
		
		public var rotateTo:Number = 0;
		public var radius:Number = 300;
		public var rota:Number = 99.5;
		
		public var currentItem:Number = 0;
		
		public var sWidth:Number = 100;
		public var sHeight:Number = 130;
		
		public var camera:Number = 90;
		public var xView:Number = 450;
		public var yView:Number = 400;
		
		public var cameraLeft:Boolean = false;
		public var cameraRight:Boolean = false;
		
		public var xViewLeft:Boolean = false;
		public var xViewRight:Boolean = false;
		
		public var yViewLeft:Boolean = false;
		public var yViewRight:Boolean = false;
				public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gloop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,kUp);
			stage.addEventListener(MouseEvent.MOUSE_OVER,mOver);
			stage.addEventListener(MouseEvent.MOUSE_OUT,mOut);
			
			containerr();
            allShapes();
		}
				public function gloop(myEvent:Event):void		{
			backgroundColorTransition();
			pp.fieldOfView= camera;
			pp.projectionCenter=new Point(xView,yView);
			container.transform.perspectiveProjection=pp;
			if(xViewRight){xView += 20;}
			if(xViewLeft){xView -= 20;}
			if(yViewRight){yView += 20;}
			if(yViewLeft){yView -= 20;}
			if(cameraRight){if(camera<178){camera += 2;}}
			if(cameraLeft){if(camera>2){camera -= 2;}}
			
			tex1.text = String("Z/X: cameraX("+xView+")")
			tex2.text = String("C/V: cameraY("+yView+")")
			tex3.text = String("Left/Right: FieldView("+camera+")")
			
			//trace(myShapesArray[currentShapeIndex].rotationX+"  "+myShapesArray[currentShapeIndex].rotationZ+"  "+myShapesArray[currentShapeIndex].rotationY)
			//trace("outline "+outline.rotationX+"  "+outline.rotationZ+"  "+outline.rotationY)
			//trace("out2 "+posOutline.rotationX+"  "+posOutline.rotationY+"  "+posOutline.rotationZ)
			
			//trace(myShapesArray[currentShapeIndex].x+"  "+myShapesArray[currentShapeIndex].y+"   "+myShapesArray[currentShapeIndex].z)
			//trace("outline "+outline.x+"  "+outline.y+"  "+outline.z)
			//trace("out2 "+posOutline.x+"  "+posOutline.y+"  "+posOutline.z)
			
			outline.x = myShapesArray[currentShapeIndex].x;
			outline.y = myShapesArray[currentShapeIndex].y;
			outline.z = myShapesArray[currentShapeIndex].z;
			outline.rotationY =  myShapesArray[currentShapeIndex].rotationY;
			
			//trace("cont "+container.rotationX+"  "+container.rotationY+"  "+container.rotationZ)
			//trace(rota)
			//alpa();
		}
		
		public function containerr()
		{
			addChild(container);
			container.x = stage.stageWidth/2;
			container.y = stage.stageHeight/2;
			
			container.rotationY = rota;
			
		}
		
		public function allShapes()
		{
			
			//if (myShapesArray.length< numOfShapes)
			for (var i:uint = 0; i < numOfShapes; i++)
			{
				shapesColor = Math.random()*0xffffff
				thisShape = new Sprite();
				
				thisShape.graphics.clear();
				thisShape.graphics.beginFill(shapesColor,1);
				thisShape.graphics.drawRoundRect(0,-(sHeight/2),sWidth,sHeight,5,5);
				thisShape.graphics.endFill();
				
				container.addChild(thisShape);
				myShapesArray.push(thisShape);
				
			
				var angle:Number = Math.PI * 2 / numOfShapes * i;
				outline.x = myShapesArray[i].x = Math.cos(angle) * radius ;
				outline.z = myShapesArray[i].z = Math.sin(angle) * radius;
				
				myShapesArray[i].rotationY = -360 / numOfShapes * i - 90;
			}
			
			
			outline.graphics.clear();
			outline.graphics.lineStyle(2,0x000000,1);
			outline.graphics.drawRoundRect(0,-(sHeight/2),sWidth,sHeight,5,5);
			outline.graphics.endFill();
			container.addChild(outline);
			
		}
		
		public function orbitCreatedShapes()
		{
			rotateTo = (-360 / numOfShapes) * currentItem + rota;
			TweenLite.to(container, 1, { rotationY:rotateTo, ease:Quint.easeInOut });
			
		}
		public function alpa()
		{
			for (var i:uint = 0; i < myShapesArray.length; i++)
			{
				
			//	if(mc1.hitTestObject(myShapesArray[i]))
			//	{
			//		//trace(myShapesArray.indexOf(myShapesArray[i])+"   "+currentShapeIndex)
			//		TweenLite.to(myShapesArray[i], .2, { alpha:1, ease:Quint.easeInOut });
			//	}
			//	else
			//	{
			//		TweenLite.to(myShapesArray[i], .2, { alpha:0, ease:Quint.easeInOut });
			//	}
			}
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
				
				shapesColor2 = Math.random() * 0xFFFFFF;
			}
			if(curVal >= 1)
			{
				color1 = Math.random() * 0xFFFFFF;
				colorTransSwitch = "goingDown"
				
				shapesColor  = Math.random() * 0xFFFFFF;
			}
			
			curVal = colorTransNum/255;
			stage.color = Color.interpolateColor(color1,color2,curVal);
			
			for (var i:uint = 0; i < myShapesArray.length; i++)
			{
				//normalColorTransition(myShapesArray[i],(curVal*100),shapesColor2,shapesColor);
			}
		}
	
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
		public function changeColor(mc:MovieClip,color:uint)
		{ 
			var thisColorTransform:ColorTransform = new ColorTransform; 
			thisColorTransform.color = color;
			mc.transform.colorTransform = thisColorTransform;
		}
		
		public function percentageNumber(value:Number, percentage:Number):Number 
		{
			var myNum:Number;
			myNum =  (value*percentage)/100;
			return Math.round(myNum);
		}
		public function normalColorTransition(mc:MovieClip,colorTransNum:Number,color1:uint,color2:uint)
		{
			var transitionValue = percentageNumber(255,colorTransNum)/255;
			var colorTransitionTrans:ColorTransform = new ColorTransform;
			
			colorTransitionTrans.color = Color.interpolateColor(color2,color1,transitionValue);
			mc.transform.colorTransform = colorTransitionTrans;
			
		}		public function kDown(event:KeyboardEvent):void
		{
			if (event.keyCode == 40)
			{   
				currentItem ++;
				orbitCreatedShapes()
				
			}
			if (event.keyCode == 38)
			{
				currentItem --;
				orbitCreatedShapes()
			}
			
			if (event.keyCode == 37)
			{
				cameraRight = true;
			}
			if (event.keyCode == 39)
			{
				cameraLeft = true;
			}
			
			if (event.keyCode == 90)
			{
				xViewLeft = true;
			}
			if (event.keyCode == 88)
			{
				xViewRight = true;
			}
			if (event.keyCode == 67)
			{
				yViewLeft = true;
			}
			if (event.keyCode == 86)
			{
				yViewRight = true;
			}
			
		}
		public function kUp(event:KeyboardEvent):void
		{
			if (event.keyCode == 37)
			{
				cameraRight = false;
			}
			if (event.keyCode == 39)
			{
				cameraLeft = false;
			}
			
			if (event.keyCode == 90)
			{
				xViewLeft = false;
			}
			if (event.keyCode == 88)
			{
				xViewRight = false;
			}
			if (event.keyCode == 67)
			{
				yViewLeft = false;
			}
			if (event.keyCode == 86)
			{
				yViewRight = false;
			}
		}
		public function mOver(event:MouseEvent):void
		{
			for (var i:uint = 0; i < myShapesArray.length; i++)
			{
				if(event.target == myShapesArray[i])
				{
					//if(mc1.hitTestObject(myShapesArray[i]))
					//{
						myShapesArray[i].buttonMode = true;
						
						//trace(currentShapeIndex)
						//selectedShape = e.currentTarget as Sprite;
						currentShapeIndex = myShapesArray.indexOf(myShapesArray[i]);
					//}
				}
			}

		}
		public function mOut(event:MouseEvent):void
		{
			/*for (var i:uint = 0; i < myShapesArray.length; i++)
			{
				if(event.target == myShapesArray[i])
				{
					
				}
			}*/
		}	}}