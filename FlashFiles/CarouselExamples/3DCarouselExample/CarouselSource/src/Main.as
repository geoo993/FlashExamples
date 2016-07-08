package 
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.materials.BitmapFileMaterial;
	import away3d.primitives.Plane;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import gs.easing.Quint;
	import gs.TweenLite;
	
	/**
	 * ...
	 * @author Charlie Schulze, charlie[at]woveninteractive[dot]com
	 */
	
	public class Main extends Sprite 
	{
		protected var planes:Array = [];
		protected var numItems:Number = 14;
		protected var radius:Number = 500;
		protected var currentItem:Number = 0;
		
		protected var bitmapMaterial:BitmapFileMaterial;
		protected var planesHolder:ObjectContainer3D;
		protected var rightBtn:Sprite;
		protected var leftBtn:Sprite;
		protected var view:View3D;
		
		public function Main():void 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);	
		}
		
		protected function onAddedToStage(event:Event):void 
		{
			createChildren();
			createButtons();
			arrangePlanes();
			adjustCamera();
			startRendering();
		}
		protected function createChildren():void 
		{
			//Create your View3D
			view = new View3D({x:stage.stageWidth/2, y:stage.stageHeight/2});
			addChild(view);
			
			planesHolder = new ObjectContainer3D();
			
			//Create Material
			bitmapMaterial = new BitmapFileMaterial("images/drawing.png");
			bitmapMaterial.smooth = true;
			
			for (var i:int = 0; i < numItems; i++) 
			{
				var plane:Plane = new Plane({material:bitmapMaterial, width:150, height:234});
				planes.push(plane);
				
				//Add plane to the scene
				planesHolder.addChild(plane);
			}
			
			view.scene.addChild(planesHolder);
		}
		
		protected function arrangePlanes():void 
		{ 
			//Set properties of our planes
			for (var i:int = 0; i < planes.length; i++) 
			{
				var angle:Number = Math.PI * 2 / numItems * i;
				var plane:Plane = planes[i];
				plane.yUp = false;
				plane.bothsides = true;
				plane.x = Math.cos(angle) * radius;
				plane.z = Math.sin(angle) * radius;
				plane.rotationY = -360 / numItems * i - 90;
			}

			//Rotate once
			rotate();
		}
		
		protected function adjustCamera():void 
		{
			//Adjust camera
			view.camera.zoom = 10;
			view.camera.focus = 40;
			view.camera.y = 50;
		}

		//Rotates the carousel
		protected function rotate():void 
		{
			var rotateTo:Number = (-360 / numItems) * currentItem + 90;
			TweenLite.to(planesHolder, 1, { rotationY:rotateTo, ease:Quint.easeInOut } );
		}
		
		protected function startRendering():void 
		{
			addEventListener(Event.ENTER_FRAME, onRenderTick);
		}
		
		protected function onRenderTick(event:Event):void 
		{
			view.render();
		}
		
		/*
		 * Everything below this point is just for creating the buttons and
		 * setting button events for controlling the carousel. 
		 */

		protected function createButtons():void 
		{
			//Create Buttons
			rightBtn = createButton();
			leftBtn = createButton();
				
			addChild(leftBtn);
			addChild(rightBtn);
			
			//Add button listeners
			rightBtn.buttonMode = true;
			leftBtn.buttonMode = true;
			rightBtn.addEventListener(MouseEvent.CLICK, buttonClick);
			leftBtn.addEventListener(MouseEvent.CLICK, buttonClick);
						
			//Place buttons on stage
			rightBtn.x = stage.stageWidth - 110;
			leftBtn.x = 110;
			rightBtn.y = stage.stageHeight / 2;
			leftBtn.y = (stage.stageHeight / 2) + 20;
			leftBtn.rotation = 180;
		}
		
		//Button actions
		protected function buttonClick(event:MouseEvent):void 
		{
			switch (event.target)
			{
				case rightBtn:
				currentItem --;
				break;
				
				case leftBtn:
				currentItem ++;
				break;
			}
			rotate();
		}
		
		//Creates a simple arrow shape / returns the sprite
		protected function createButton():Sprite
		{
			var btn:Sprite = new Sprite();
			
			btn.graphics.beginFill(0x333333);
			btn.graphics.moveTo(0, 0);
			btn.graphics.lineTo(0, 20);
			btn.graphics.lineTo(10, 10);
			btn.graphics.lineTo(0, 0);
			btn.graphics.endFill();
			return btn;
		}
	}
}