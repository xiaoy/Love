package Configure 
{
	import flash.automation.ActionGenerator;
	import flash.desktop.ClipboardTransferMode;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.globalization.StringTools;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import Loader.BaseLoader;
	/**
	 * ...
	 * @author lfwu
	 */
	public class ConfigManager 
	{
		private static var _instance : ConfigManager = null;
		
		private var _configDic : Dictionary = null;
		private var _resDic : Dictionary = null;
		private var _waitingLoadArr : Array = null;
		private var _callBack : Function = null;
		private var _isLoading : Boolean = false;
		private var _timer : Timer = null;
		
		public function ConfigManager() 
		{
			_configDic = new Dictionary();
			_resDic = new Dictionary();
			_waitingLoadArr = new Array();
			_timer = new Timer(0.1, 0);
			_timer.addEventListener(TimerEvent.TIMER, loadImageRes);
		}
		
		public static function instance() : ConfigManager {
			if (_instance == null) {
				_instance = new ConfigManager();
			}
			return _instance;
		}
		
		public function Init(callBack : Function) : void {
			_callBack = callBack;
			var loader : BaseLoader = new BaseLoader("Images.xml", function loadRet(data : Object) : void {
				var url : String = Config.ASSERT_CONFIG + "Images.xml";
				var xml : XML = new XML(data[url]);
				for each(var xmlList : XML in xml.*) {
					var imageUrl : String = xmlList[0];
					_waitingLoadArr.push(imageUrl);
					if (_waitingLoadArr.length == 1) {
						_timer.start();						
					}
				}
			});
			loader.load();
		}
		
		private function loadImageRes(e : Event) : void {
			if (_waitingLoadArr.length == 0 && !_isLoading) {
				// stop
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER, loadImageRes);
				return;
			}
			
			if (_isLoading) {
				return;
			}
			var path : String = _waitingLoadArr[0] + ".png";
			var url : String = Config.ASSRET_IMAGES + path;
			var loader : BaseLoader = new BaseLoader(path, function loadRet(obj : Object) : void {
				_waitingLoadArr = _waitingLoadArr.splice(0, 1);
				_isLoading = false;
				_resDic[url] = obj.url;
			});
			loader.load();
		}
		public function getResData(url : String) : * {
			return _resDic[url];
		}
		
		public function getConfig(key : String) : * {
			return _configDic[key];
		}
	}

}