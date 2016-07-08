package 
{		import flash.display.*;
	import flash.events.*;	import flash.geom.*;	import fl.motion.*;		public class Moon extends Sprite 
	{				public var Layers:Number = 10;
		public var stageW:Number = 1200; //stage width
		public var stageH:Number = 600; //stage height
		
		public var moonArray:Array = new Array();
		public var moonSpeed:Number = 1;				public function Moon(size:uint) 
		{			// Make the bitmapData match the size passed in			var bitmapData:BitmapData = new BitmapData(size,size);
						// Draw some perlin noise (for a change)			bitmapData.perlinNoise(size/2,size/2, Layers, Math.random()*1000,true,true,1,true);			// Tint the bitmap data			var tint:Color = new Color();			tint.setTint(0xFFFFFF, 0.6); // 60% to white			bitmapData.colorTransform(new Rectangle(0,0,size,size), tint);			blendMode="add"; // Optional blend mode change			// Make a Shape object to draw the gradient in			var alphaMask:Shape = new Shape();			// Set up the required elements of a gradient			var colours = [ 0xFFFFFF, 0xFFFFFF ]; // White to white			var alphas = [ 1, 0 ]; // Fully opaque to fully transparent			var ratios = [ 200, 255 ]; // About 4/5 start point, fade out from there			var matrix:Matrix = new Matrix(); // Make a Matrix for the gradient			// Tell the Matrix to make a gradient box the full size of the moon			matrix.createGradientBox(size,size); // Rotation is unnecessary			// Draw the radial gradient to the alphaMask's graphics			alphaMask.graphics.beginGradientFill(GradientType.RADIAL, colours, alphas, ratios, matrix);			// Draw a rectangle shape so all pixels of the BitmapData are covered			// Drawing a circle or ellipse would result in opaque corners of the moon			alphaMask.graphics.drawRect(0,0,size,size);			alphaMask.graphics.endFill();			// draw the alphaMask to the BitmapData			bitmapData.draw(alphaMask, null, null, "alpha");
			
			var moonBitmap:Bitmap = new Bitmap(bitmapData);
			addChild(moonBitmap);
			
			moonBitmap.x = Math.random()*stageW - moonBitmap.width/2;
			moonBitmap.y = Math.random()*stageH/2 - moonBitmap.height/2;
			
			moonArray.push(moonBitmap);
			moonBitmap.addEventListener(Event.ENTER_FRAME, updateMoon);
					}
		
		function updateMoon(e:Event):void
		{
			//trace(moonArray.length+"  "+moonArray[0].width+"   "+moonArray[0].x+"   "+moonSpeed)
			moonArray[0].x += moonSpeed;
			
			if (moonArray[0].x > (stageW + moonArray[0].width))
			{				
				moonArray[0].x = 0 - moonArray[0].width-100;
				moonArray[0].y = Math.random()*stageH/2 - moonArray[0].height/2;
				var scalee:int =  randomRange(100,350);
				moonArray[0].width = scalee;
				moonArray[0].height = scalee;
				moonSpeed = Math.random();
			}
		}
		function randomRange(minNum:int,maxNum:int)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}	}}