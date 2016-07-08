package 
{ 
	public class Vector3D
	{
		public var x:Number, y:Number, z:Number = 0.0;
		

		public function Vector3D(... args) 
		{
			if(args.length == 3) 
			{
				x = args[0]; 
				y = args[1]; 
				z = args[2];
			} 
			else if(args.length == 2) 
			{
				x = args[0]; 
				y = args[1];
				z = 0;
			} 
			else 
			{
				x = 0; 
				y = 0; 
				z = 0;		
			}
		}
		
		public function Constructor():Vector3D
		{
			return new Vector3D(this.x, this.y, this.z);
		}
		
	
		public function AddVector(v:Vector3D):Vector3D
		{
			this.x += v.x;
			this.y += v.y;
			this.z += v.z;
			return this;
		}
		
	}
}