package Configure 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author lfwu
	 */
	public class ResourceManager extends Sprite
	{
		private static var _instance : ResourceManager = null;
		private var _loadingResDic : Dictionary = null;
		private var _loadedResDic : Dictionary = null;
		private var _isLoading : Boolean = false;
		private var _loadingUrl : String = null;
		private var _loader : Loader = null;
		private var _callBack : Function = null;
		public function ResourceManager() 
		{
			init();
		}
		
		private function init() : void {
			_loadingResDic = new Dictionary();
			_loadedResDic = new Dictionary();
			_loader = new Loader();
			addChild(_loader);
		}
		
		public function loadRes(url : String, callBack : Function = null) : void {
			if (_isLoading) {
				_loadingResDic[url] = callBack;				
			}
			_loadingUrl = url;
			_callBack = callBack;
			_isLoading = true;
			_loader.addEventListener(Event.COMPLETE, loadedListener);
			_loader.load(new URLRequest(url));
		}
		
		private function loadedListener(e : Event) : void {
			removeEventListener(Event.COMPLETE, loadedListener);
			_isLoading = false;
			_loadingResDic[_loadingUrl] = null;
			delete _loadingResDic[_loadingUrl];
			_loadedResDic[_loadingUrl] = e.target;
			if (_callBack != null) {
				_callBack();
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
		
		public function dispose() : void {
			_loadedResDic = null;
			_loadingResDic = null;
			removeChild(_loader);
			_loader = null;
		}
	}

}