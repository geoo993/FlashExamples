package Graph
{
    import flash.display.*;
	import flash.events.*;
    import flash.geom.*;
	import flash.text.*;
 
    public class Node extends Sprite
    {
		
		public var graph:Graph = new Graph();
		
        public var pos:Vector3D;
        public var indexx:int;
		
		public var myText:TextField = new TextField();
		public var TexFormat:TextFormat = new TextFormat  ;
		public var TextColor:uint = Math.random() * 0xffffff;
		
		public var thisColorTransform = new ColorTransform  ;
		
		
        public function Node(idx:int,n_Pos:Vector3D)
        {
			
			thisColorTransform.color = graph.allNodesColor;
			this.transform.colorTransform = thisColorTransform;
			myText.x = -27;
			myText.y = -20;
			
            indexx = idx;
            pos = n_Pos;
            this.x = n_Pos.x;
            this.y = n_Pos.y+10;
            //idx_txt.text = String(idx)
			this.buttonMode = true;
			
			this.addChild(myText);
			myText.text = String(indexx);
			myText.textColor = TextColor;
			myText.width = 30;
			myText.height = 15;
			myText.selectable = false;
			myText.setTextFormat(TexFormat);
			TexFormat.italic = true; 
			TexFormat.size = 5;
			TexFormat.font = "Comic Sans MS";
			TexFormat.align = TextFormatAlign.RIGHT;
			
		}
		
        public function getIndex():int
        {
            return indexx;
        }
        public function setPos(n_Pos:Vector3D):void
        {
            pos=n_Pos;
        }
 
        public function getPos():Vector3D
        {
            return pos;
        }
    }
}