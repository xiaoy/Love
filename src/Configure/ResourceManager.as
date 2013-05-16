package Configure 
{
	import Debug.LogInfo;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author lfwu
	 */
	public class ResourceManager
	{
		private static var _instance : ResourceManager = null;
		private var _loadingResDic : Dictionary = null;
		private var _loadedResDic : Dictionary = null;
		private var _isLoading : Boolean = false;
		private var _loadingUrl : String = null;
		private var _loader : URLLoader = null;
		private var _callBack : Function = null;
		public function ResourceManager() 
		{
			init();
		}
		
		private function init() : void {
			_loadingResDic = new Dictionary();
			_loadedResDic = new Dictionary();
			_loader = new URLLoader();
			//addChild(_loader);
		}
		
		public function loadRes(url : String, callBack : Function = null) : void {
			if (_isLoading) {
				_loadingResDic[url] = callBack;				
			}
			_loadingUrl = url;
			_callBack = callBack;
			_isLoading = true;
			_loader.addEventListener(Event.COMPLETE, loadedListener);
			_loader.addEventListener(ProgressEvent.PROGRESS, loadHandle);
			_loader.load(new URLRequest(url));
		}
		
		private function loadHandle(e : ProgressEvent) : void {
			LogInfo.log("the file " + _loadingUrl + "is loading" + e.bytesLoaded / e.bytesTotal);
			if (e.bytesTotal == e.bytesLoaded) {
				_loader.removeEventListener(ProgressEvent.PROGRESS, loadHandle);
			}
		}
		
		public function loadedListener(e : Event) : void {	
			_loader.removeEventListener(Event.COMPLETE, loadedListener);
			_isLoading = false;
			_loadingResDic[_loadingUrl] = null;
			delete _loadingResDic[_loadingUrl];
			var urlKey : String = _loadingUrl.slice(0, _loadingUrl.indexOf("."));
			_loadedResDic[urlKey] = _loader.data;
			if (_callBack != null) {
				_callBack(true);
			}
			for (var key : String in _loadingResDic) {
				loadRes(key, _loadingResDic[key]);
				break;
			}
		}
		
		public static function instance() : ResourceManager {
			if (_instance == null) {
				_instance = new ResourceManager();
			}
			return _instance;
		}
		public function getXmlConfig(url : String) : XML {
			//var xml : XML = null;
			//for (var key : String in _loadedResDic) {
				//if (key == url) {
					//xml = _loadedResDic[key] as XML;
					//break;
				//}
			//}
			return new XML(_loadedResDic[url]);
		}
		public function dispose() : void {
			_loadedResDic = null;
			_loadingResDic = null;
			_loader = null;
		}
	}

}