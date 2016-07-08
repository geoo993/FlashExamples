package 
{
	import flash.display.*;

	public class Particle extends Shape
	{
		var loc:Vector3D;
		var vel:Vector3D;
		var acc:Vector3D;
		var r:Number;
		var timer:Number;

		public function Particle(l:Vector3D)
		{
			acc = new Vector3D(0,0.06,0);
			vel = new Vector3D((Math.random() * -2.0 + Math.random() * 2.0),(Math.random() * -5.0 + Math.random() * 0.0),0);
			loc = l.Constructor();
			r = 20;
			timer = 1.0;
		}
		public function MainParticle(a:Vector3D,v:Vector3D,l:Vector3D,r1:Number)
		{
			acc = a.Constructor();
			vel = v.Constructor();
			loc = l.Constructor();
			r = r1;
			timer = 100.0;
		}
		
		public function run():void
		{
			update();
			render();
		}

		public function update():void
		{
			vel.AddVector(acc);
			loc.AddVector(vel);
			timer -= 0.005;
		}
		
		public function render():void
		{
			graphics.clear();
			graphics.beginFill(0xffffff,timer);
			graphics.lineStyle(0,0xffffff,timer);
			graphics.drawEllipse(loc.x,loc.y,r*timer,r*timer);
			graphics.endFill();
		}
		
		public function dead():Boolean
		{
			if (timer <= 0.0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
	}
}