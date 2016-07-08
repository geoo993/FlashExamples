package 
{
	import flash.events.*;
	import flash.display.*;


	public class FrontBox extends MovieClip
	{
		public var refM:MovieClip;


		public function FrontBox()
		{
			this.addEventListener(Event.ENTER_FRAME,gameLoop);
			stage.addEventListener(MouseEvent.MOUSE_OVER,mOver);

			refM = MovieClip(this.parent);
			refM.frontBoxArray.push(this);

		}

		function gameLoop(myEvent:Event):void
		{

			for (var i:uint = 0; i < refM.frontBoxArray.length; i += 1)
			{
				refM.frontBoxArray[i].buttonMode = true;
				
			}


		}
		public function mOver(event:MouseEvent):void
		{
			if(event.target == refM.frontBoxArray[0])
			{
				refM.fBoxInd.x = refM.frontBoxArray[0].x
			}
			else if(event.target == refM.frontBoxArray[1])
			{
				refM.fBoxInd.x = refM.frontBoxArray[1].x
			}
			else if(event.target == refM.frontBoxArray[2])
			{
				refM.fBoxInd.x = refM.frontBoxArray[2].x
			}
			else if(event.target == refM.frontBoxArray[3])
			{
				refM.fBoxInd.x = refM.frontBoxArray[3].x
			}
			else
			{
				refM.fBoxInd.x = 2000;
			}
			
		}




	}

}