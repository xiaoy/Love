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
		private var _callBack : Function = null;
		private var _resCount : int = 0;
		public function ConfigManager() 
		{
			_configDic = new Dictionary();
			_resDic = new Dictionary();
		}
		
		public static function instance() : ConfigManager {
			if (_instance == null) {
				_instance = new ConfigManager();
			}
			return _instance;
		}
		
		public function Init(callBack : Function) : void {
			_callBack = callBack;
			var loader : BaseLoader = new BaseLoader("Resource.xml", function loadRet(data : *) : void {
				var xml : XML = new XML(data);
				_resCount = xml.children().length();
				for each(var xmlList : XML in xml.*) {
					var imageUrl : String = xmlList[0];
					var key : String = imageUrl.slice(0, imageUrl.indexOf("."));
					var res : Resource = new Resource(imageUrl, loadImageRes);
					_resDic[key] = res;
				}
			});
			loader.load();
		}
		
		private function loadImageRes() : void {
			_resCount -= 1;
			if (_resCount == 0) {
				_callBack();
			}
		}
		public function getResData(url : String) : * {
			return _resDic[url].getData();
		}
		
		public function getConfig(key : String) : * {
			return _configDic[key];
		}
	}

}