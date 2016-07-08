package 
{
    import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import fl.motion.Color;
    
    public class Main extends Sprite
    {
        public var particlesTotal:Number = 500;
        public var particleSpeed:Number = 10;
        public var particleFadeoutSpeed:Number = .005;
        
        public var particlesArray:Array = new Array();      
        public var radians:Number;        
        public var dx:Number;
        public var dy:Number;
        public var distSQ:Number;
        public var forceX:Number;
        public var forceY:Number;
		
		public var circlesArray:Array = new Array();
		public var cColor:uint = Math.random() * 0xFFFFFF;
		public var colorCount:Number = 0;
		public var colorState:Number = 0;
		public var myColorTransform = new ColorTransform()  ;
		
		public var colorTransSwitch:String = "idle";
		public var colorTransNum:Number = 0;
		public var curVal:Number= 0;
		public var color1 = 0xFF0000;
		public var color2 = 0x0000FF;
		
        
        public function Main():void
        {
            radians = 180 / Math.PI;
			
            this.addEventListener(Event.ENTER_FRAME, onEnterFrameLoop);
            
            dispenserMc.addEventListener(MouseEvent.MOUSE_DOWN, onThingDown);
            pullerMc.addEventListener(MouseEvent.MOUSE_DOWN, onThingDown);
            deflectorMc.addEventListener(MouseEvent.MOUSE_DOWN, onThingDown);
            
			dispenserMc.addEventListener(MouseEvent.MOUSE_UP, onThingUp);
            pullerMc.addEventListener(MouseEvent.MOUSE_UP, onThingUp);
            deflectorMc.addEventListener(MouseEvent.MOUSE_UP, onThingUp);
			
        }
        
        public function onThingDown(event:MouseEvent):void
        {
            event.currentTarget.startDrag();
        }
        public function onThingUp(event:MouseEvent):void
        {
            event.currentTarget.stopDrag();
        }
        public function createCircles(mc1:MovieClip, mc2:MovieClip):void
        {
			var transparency:Number = Math.random() * 2;
			
			var tempParticle:MovieClip = new MovieClip() ;
			tempParticle.graphics.clear();
			tempParticle.graphics.beginFill(cColor,transparency);
			tempParticle.graphics.drawCircle(0,0,randomRange(1,5));
			tempParticle.graphics.endFill();
			
			tempParticle.x = (mc1.x - mc1.width / 2) + (Math.random() * mc1.width);
			tempParticle.y = (mc1.y - mc1.height / 2) + (Math.random() * mc1.height);
            tempParticle.rotation = Math.random()*360;
            
			tempParticle.rot = Math.atan2(mc1.y - mc2.y, mc1.x - mc2.x);
			tempParticle.xSpeed = Math.cos(tempParticle.rot) * radians / particleSpeed;
			tempParticle.ySpeed = Math.sin(tempParticle.rot) * radians / particleSpeed;
			tempParticle.mass = tempParticle.width / 2 + tempParticle.height / 2;

			circlesArray.push(tempParticle);
            stage.addChild(tempParticle);
			
			if(circlesArray.length >particlesTotal)
			{
				particleDestroyer(tempParticle)
			}
		}
        public function createParticle(target1:MovieClip, target2:MovieClip):void
        {   
            var tempParticle:MovieClip = new Particle();
			
            tempParticle.x = (target1.x - target1.width / 2) + (Math.random() * target1.width);
            tempParticle.y = (target1.y - target1.height / 2) + (Math.random() * target1.height);
			
            tempParticle.rotation = Math.random()*360;
            
			tempParticle.rot = Math.atan2(target1.y - target2.y, target1.x - target2.x);
			tempParticle.xSpeed = Math.cos(tempParticle.rot) * radians / particleSpeed;
			tempParticle.ySpeed = Math.sin(tempParticle.rot) * radians / particleSpeed;
			tempParticle.mass = tempParticle.width / 2 + tempParticle.height / 2;
            
            particlesArray.push(tempParticle);
            addChild(tempParticle);
			
			if(particlesArray.length >particlesTotal)
			{
				destroyParticle(tempParticle)
			}
        }
        
        public function updateParticle():void
        {
			
            for (var i = 0; i < circlesArray.length; i++)
            {
                var tempParticle:MovieClip = circlesArray[i];
               
				tempParticle.x -= tempParticle.xSpeed;
				tempParticle.y -= tempParticle.ySpeed;  
                tempParticle.alpha -= particleFadeoutSpeed;
                
                dx = tempParticle.x - deflectorMc.x;
                dy = tempParticle.y - deflectorMc.y;
                distSQ = ((dx * dx) + (dy * dy));
				
                forceX = tempParticle.mass * tempParticle.xSpeed;
                forceY = tempParticle.mass * tempParticle.ySpeed;
				
				var deflectorMass:Number = (deflectorMc.width / 2 + deflectorMc.height / 2);
				
                tempParticle.x += deflectorMass * (dx+forceX) / distSQ;
                tempParticle.y += deflectorMass * (dy+forceY) / distSQ;
                
                if(tempParticle.hitTestObject(pullerMc))
                {
                    destroyParticle(tempParticle);
					particleDestroyer(tempParticle);
                }
                else if (tempParticle.alpha <= 0 || tempParticle.x < 0 || tempParticle.x > stage.stageWidth ||tempParticle.y < 0||tempParticle.y > stage.stageHeight)
                {
					destroyParticle(tempParticle);
					particleDestroyer(tempParticle);
                }
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
			}
			if(curVal >= 1)
			{
				color1 = Math.random() * 0xFFFFFF;
				colorTransSwitch = "goingDown"
			}
			curVal = colorTransNum/255;
			stage.color = Color.interpolateColor(color1,color2,curVal);
			
		}
		public function changeColorOvertime()
		{
			colorCount++
			if(colorCount >1000)
			{
				colorState = randomRange(0,5);
				colorCount = 0;
			}
			if(colorState == 0)
			{
				cColor = 0xFFFFFF;
				
			}
			if(colorState == randomRange(1,4))
			{
				cColor = Math.random() * 0xFFFFFF;
				
				colorState = 10;
			}
			if(colorState == 5)
			{
				cColor = Math.random() * 0xFFFFFF;
			}
			else
			{
				myColorTransform.color = cColor;
				pullerMc.transform.colorTransform = myColorTransform;
			}
			for (var d:uint = 0; d < circlesArray.length; d++)
			{
				if(circlesArray[d].alpha <= 0)
				{
					myColorTransform.color = cColor;
					circlesArray[d].transform.colorTransform = myColorTransform;
				}
			} 
			
		}
		public function onEnterFrameLoop(event:Event):void
        {
			backgroundColorTransition();
			changeColorOvertime();
			dispenserMc2.visible = false;
			
			//createParticle(dispenserMc, pullerMc);
			createCircles(dispenserMc2, pullerMc)
            updateParticle();
        }
        function randomRange(minNum:Number,maxNum:Number)
		{
			return Math.floor(Math.random() * ((maxNum - minNum) + 1)) + minNum;
		}
        public function destroyParticle(particle:MovieClip):void
        {
            for (var i = 0; i < particlesArray.length; i++)
            {
                var tempParticle:MovieClip = particlesArray[i];
                if (tempParticle == particle)
                {
                    particlesArray.splice(i,1);
                    removeChild(tempParticle);
                }
            }
        }
		public function particleDestroyer(myMc:MovieClip):void
		{
			var thisMc:MovieClip;

			for (var i:uint = 0; i < circlesArray.length; i++)
			{
				thisMc= circlesArray[i];

				if (thisMc == myMc)
				{
					circlesArray.splice(i,1);	
					myMc.parent.removeChild(myMc) 
				}
			}
		}
        
    }   
}