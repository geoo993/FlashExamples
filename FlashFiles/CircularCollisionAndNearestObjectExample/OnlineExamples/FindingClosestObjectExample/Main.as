
package  
{
	import com.freeactionscript.ai.EnemyManager;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Main extends MovieClip
	{
		// vars
		private var _enemyManager:EnemyManager;
		
		/**
		 * Constructor
		 */
		public function Main() 
		{
			// add listeners
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			
			// create new istance of enemy manager
			_enemyManager = new EnemyManager(this);
			
			// create 5 random enemies
			_enemyManager.createRandomEnemies(5);
		}
		
		//////////////////////////////////////
		// Document Methods
		//////////////////////////////////////
		
		/**
		 * Updates information text fields on stage
		 */
		private function updateDisplay():void 
		{
			if (_enemyManager.enemies.length == 0)
			{
				closestEnemyText.htmlText = "Closest Enemy: <b>None</b>";
				totalEnemiesText.htmlText = "Total Enemies: <b>0</b>";
			}
			else
			{
				closestEnemyText.htmlText = "Closest Enemy: <b>" + _enemyManager.enemies[0].myName + "</b>";
				totalEnemiesText.htmlText = "Total Enemies: <b>" + _enemyManager.enemies.length + "</b>";
			}
		}
		
		//////////////////////////////////////
		// Event Handlers
		//////////////////////////////////////
		
		/**
		 * Enter Frame handler
		 * @param	event	Uses Event
		 */
		private function enterFrameHandler(event:Event):void
		{
			_enemyManager.update();
			updateDisplay();
		}
		
		/**
		 * Mouse Up handler
		 * @param	e	Uses MouseEvent
		 */
		private function onMouseUpHandler(event:MouseEvent):void 
		{
			//
		}
		
		/**
		 * Mouse Down handler
		 * @param	e	Uses MouseEvent
		 */
		private function onMouseDownHandler(event:MouseEvent):void 
		{
			// create new enemy at mouse X & Y
			_enemyManager.createEnemy(event.stageX, event.stageY, "New Enemy");
		}
	}
}