package utils
{
	public class IndexedPriorityQ
	{
		private var keys:Vector.<Number>;
		private var data:Vector.<int>;
		
		public function IndexedPriorityQ(n_keys:Vector.<Number>)
		{
			keys=n_keys;
			data = new Vector.<int>;
		}
		
		public function insert(idx:int):void
		{
				data[data.length] = idx;
				reorderUp();
		}
		
		public function pop():int
		{
			var rtn:int=data[0];
			data[0]=data[data.length-1];
			data.pop();
			reorderDown();
			return rtn;
		}
		
		public function reorderUp():void
		{
			for(var a:int = data.length-1;a>0;a--)
			{
				if(keys[data[a]]<keys[data[a-1]])
				{
					var tmp:int=data[a];
					data[a]=data[a-1];
					data[a-1]=tmp;
				}
				else return;
			}
		}
		
		public function reorderDown():void
		{
			for(var a:int=0;a<data.length-1;a++)
			{
				if(keys[data[a]]>keys[data[a+1]])
				{
					var tmp:int=data[a];
					data[a]=data[a+1];
					data[a+1]=tmp;
				}
				else return;
			}
		}
		public function isEmpty():Boolean
		{
			return (data.length==0);
		}
	}
}