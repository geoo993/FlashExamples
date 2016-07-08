package {	import flash.display.*;	import flash.events.*;	import flash.filters.*;	import flash.geom.*;
	import flash.text.*;
	import fl.motion.*;
	import com.theflashblog.fp10.*;
	import com.greensock.*;	public class Main extends MovieClip
	{
		public var rotationValue:Number;
		
		public var containerArray:Array = new Array  ;
		public var sumTextArray:Array = new Array  ;
		
		public var container:MovieClip =  new MovieClip();;
		
		public var sumText:TextField = new TextField();
		public var sumtextFormat:TextFormat = new TextFormat  ;
				public function Main()		{			this.addEventListener(Event.ENTER_FRAME,gloop);
			
			containerr(); 
			createtext()
		}
				public function gloop(myEvent:Event):void		{
			//orbitCreatedShapes();
			
			sumTextArray[0].visible = false; 
			
			rotationValue = (stage.mouseX + stage.stageWidth / 2) * .5 ;
			TweenLite.to(container,1,{rotationY:rotationValue});
			
			for (var o:uint = 0; o < sumTextArray.length; o++)
			{
				TweenLite.to(sumTextArray[o],1,{rotationZ:rotationValue});
				
			}
			
			SimpleZSorter.sortClips(container);
			
			//trace(sumTextArray[1].y)
			sumTextArray[1].text = "yess"
		}
		
		public function containerr()
		{
			addChild(container);
			containerArray.push(container) 
			container.x = stage.stageWidth/2;
			container.y = stage.stageHeight/2;
			
			container.rotationX = 90;
		}
		public function createtext()
		{
			
			for (var i:uint = 0; i < 11; i++)
			{
				sumTextArray[i] = new TextField
				sumTextArray[i].text = "yessssss"+i;
				sumTextArray[i].textColor = 0x444444;
				sumTextArray[i].width = 80;
				sumTextArray[i].height = 40;
				sumTextArray[i].selectable = false;
				sumTextArray[i].setTextFormat(sumtextFormat);
				sumtextFormat.italic = true; 
				sumtextFormat.size = 12;
				sumtextFormat.font = "Comic Sans MS";
				sumtextFormat.align = TextFormatAlign.CENTER;
				
				container.addChild(sumTextArray[i]);
				var pos:Point = Point.polar(200, (i / 10) * Math.PI * 2);
				sumTextArray[i].x = pos.x;
				sumTextArray[i].y = pos.y;
				sumTextArray[i].rotationX = -90; 
			}
			
		}
			}}