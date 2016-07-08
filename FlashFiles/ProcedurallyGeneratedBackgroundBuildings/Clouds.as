package 
{		import flash.display.*;
	import flash.events.*;	import flash.geom.*;	import fl.motion.*;		public class Clouds extends Sprite 
	{		
		public var stageW:Number = 5000; //stage width*2
		public var stageH:Number = 700; //stage height
		
		public var cloudsSpeed:Number = 1;
		
		public var cloudsWith:Number = 200; // The width of clouds
		public var cloudsHeight:Number = 100; // The height of clouds
		
		public var cloudLayers:Number = 6; // The number of layers of noise
		public var seeds:Number = Math.random()*1000 // randomSeed
		
		public var cloudyNum:int = 15;
		
		public var clouds:BitmapData;
		public var cloudsBitmap:Bitmap;	
		public function Clouds()
		{
			// Make the bitmap data for the clouds
			clouds = new BitmapData(stageW,stageH);
			// Draw perlin noise onto the clouds bitmap data
			clouds.perlinNoise(cloudsWith, cloudsHeight, cloudLayers, seeds, false, true, cloudyNum, true);
			// Adjust the alpha of clouds with a colour transform
			var colTrans:ColorTransform = new ColorTransform();
			colTrans.alphaOffset = -120;
			clouds.colorTransform(new Rectangle(0,0,stageW,stageH), colTrans);
			// Make the bitmap object to display the clouds
			cloudsBitmap = new Bitmap(clouds);
			addChild(cloudsBitmap);
			cloudsBitmap.alpha = 1;
			// Using the add blend mode enhances colours underneath
			cloudsBitmap.blendMode = "add"; // Optional line...
			this.addEventListener(Event.ENTER_FRAME, updateClouds);
		
		}
		
		function updateClouds(e:Event):void
		{
			this.x -= cloudsSpeed;
			
			if(this.x < -4000)
			{
				cloudsSpeed *= -1;
			}
			if(this.x > 0)
			{
				cloudsSpeed *= -1;
			}
			
		}
			}}