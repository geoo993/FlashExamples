package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import fl.motion.*;
	
	public class Main extends MovieClip
	{
		public var myColor:uint; // = Math.random()*0xB19210;
		public var colorTransSwitch:String;
		public var colorTransNum:Number = 0;
		public var curVal:Number;
		public var color1:uint;
		public var color2:uint;
		public var colorTransit:ColorTransform = new ColorTransform  ;
		
		public var player:Sprite = new Sprite();;
		public var playerSpeed:Number = 10;
		public var playerArray:Array = new Array();
		public var playerColor = Math.random() * 0xFFFFFF;
		
		public var particles:Array = new Array();;	// An arraylist for all the particles
		public var origin:Vector3D;	// An origin point for where particles are created
		
		public function Main()
		{
			this.addEventListener(Event.ENTER_FRAME,gLoop);
			
			stage.color = Math.random()* 0xFFFFFF;
			createPlayer();
			ParticleSystem(1,new Vector3D(0,0,0));
			
			
		}
		public function gLoop(myEvent:Event):void
		{
			addParticle();
			run();
			movePlayer(); 
			colorTransition();
			
			//trace(particles.length)
		}
		public function createPlayer():void
		{
			player.graphics.beginFill(playerColor,0);
			player.graphics.drawCircle(0,0,10);
			player.graphics.endFill();
			
			player.x = stage.stageWidth / 2;
			player.y = stage.stageHeight / 2;
			stage.addChild(player);
			playerArray.push(player);
			
		}
		private function movePlayer():void
		{
			var radians:Number = Math.atan2(mouseY - player.y, mouseX - player.x);
			var degrees:Number = radians / (Math.PI / 180) + 90;
			player.rotation = degrees;
			
			player.x += (mouseX - player.x) / playerSpeed;
			player.y += (mouseY - player.y) / playerSpeed;
		}
		public function ParticleSystem(num:int,v:Vector3D)
		{
			origin = v.Constructor();		// Store the origin point
			
			for (var i:uint=0; i < num; i++)
			{
				particles.push(new Particle(origin));	// Add "num" amount of emitters to the arraylist
			}
		}
		
		public function run()
		{
			// Cycle through the ArrayList backwards b/c we are deleting
			for (var i:uint=particles.length - 1 ; i > 0; i--)
			{
				particles[i].run();
				
				if (particles[i].dead())
				{
					removeChild(particles[i]);
					/*if(getChildByName(particles[i].name) == null)
					{
						trace("Object successfully disposed");
					}*/
					particles.splice(i,1);
				}
			}
		}
		public function addParticle()
		{
			var p:Particle = new Particle(origin);
			particles.push(p);
			addChild(p);
			
			p.x = player.x;
			p.y = player.y;
		}
		public function addParticle2(p:Particle)
		{
			particles.push(p);
		}
		
		public function dead():Boolean
		{
			if (particles.length <= 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		public function colorTransition()
		{
			if(colorTransSwitch == "goingUp")
			{
				colorTransNum += .5;
			}
			if(colorTransSwitch == "goingDown")
			{
				colorTransNum -= .5; 
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
			myColor = Color.interpolateColor(color1,color2,curVal);
			
			colorTransit.color = myColor;
			//player.transform.colorTransform = colorTransit;
			
			for (var i:uint = 0; i < particles.length; i++)
			{
				particles[i].transform.colorTransform = colorTransit;
			}
		}
		function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
	}
}