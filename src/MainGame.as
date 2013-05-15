package  
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import Page.SpringPage;
	import Page.StartPage;
	/**
	 * ...
	 * @author lfwu
	 */
	public class MainGame extends Sprite
	{
		static private var _instance : MainGame = null;
		
		private var _stage : Stage = null;
		private var _isInit : Boolean = false;
		
		public function MainGame() 
		{
		}
		
		private function Update(e : Event) : void {
			
		}
		
		public function init(stage : Stage) : void {
			if (_isInit) {
				trace("Error:Init twice");
				return;
			}
			// Init the main game layer
			_isInit = true;
			_stage = stage;
			_stage.addChild(this);
			
			// add first page
			//var startPage : StartPage = new StartPage();
			//addChild(startPage);
			
			var springPage : SpringPage = new SpringPage();
			addChild(springPage);
			
			_stage.addEventListener(Event.ENTER_FRAME, Update);
		}
		
		public static function instance() : MainGame {
			if (_instance == null) {
				_instance = new MainGame();
			}
			return _instance;
		}
		
		public function getStage() : Stage {
			return _stage;
		}
	}

}