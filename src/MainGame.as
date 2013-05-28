package  
{
	import Configure.Config;
	import Configure.ConfigManager;
	import Debug.LogInfo;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.PerspectiveProjection;
	import flash.utils.ByteArray;
	import Loader.BaseLoader;
	import Page.SpringPage;
	import Page.StartPage;
	import Sound.SoundManager;
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
			SoundManager.instance().play(Config.ASSERT_SOUND + "sunshine.mp3");
			LoadConfig();
			
		}
		
		private function startGame() : void {
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
		
		private function LoadConfig() : Boolean {
			// Load SpringPage.xml
			//loadConfigResult();
			var page : SpringPage = new SpringPage();
			addChild(page);
			return true;
		}
		
		private function loadConfigResult(ret : Boolean = true) : Boolean {
			if (!ret) {
				LogInfo.warn("Load config files failed");
				return false;
			}
			ConfigManager.instance().Init(function callBack() : void {});
			//startGame();
			LogInfo.log("Load Config files successed");
			return true;
		}
	}

}