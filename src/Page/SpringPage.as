package Page 
{
	import Configure.ResourceManager;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.globalization.StringTools;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import Text.Word;
	/**
	 * ...
	 * @author lfwu
	 */
	public class SpringPage extends Sprite
	{
		public static const CONFIG_URL : String = "Res/Configs/SpringPage";
		private var _configXml : XML = null;
		private var _imagesCount : int = 0;
		private var _imagesArr : Array = new Array();
		private var _lastDisplay : DisplayObject = null;
		public function SpringPage() 
		{
			_configXml = new XML(ResourceManager.instance().getResourceData(CONFIG_URL));
			init();
		}
		
		
		private function init() : void {
			var pageXml : XML = _configXml.PageSpring[0];
			
			var titleXml : XMLList = pageXml.Title;		
			var title : Word = new Word();
			title.initByXml(titleXml);
			addChild(title);
		
			var textXml : XMLList = pageXml.Text;
			var text : Word = new Word();
			text.initByXml(textXml);
			addChild(text);
			
			var imagesXml : XMLList = pageXml.Images;
			for each(var imageXml : XML in imagesXml.*) {
				var name : String = imageXml.@url;
				var path : String = "Res/Images/" + name;
				var loader : Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadImagesHandle);
				loader.load(new URLRequest(path));
				loader.x = imagesXml.@posX;
				loader.y = imagesXml.@posY;
			}
			var timer : Timer = new Timer(imagesXml.@delay * 1000);
			timer.addEventListener(TimerEvent.TIMER, Update);
			timer.start();
			//_imagesCount = imagesXml.length;
		}
		
		private function loadImagesHandle(e : Event) : void {
			var targetLoader : Loader = e.currentTarget.loader as Loader;
			targetLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadImagesHandle);
			_imagesArr.push(targetLoader);
			addChild(targetLoader);
			if (_imagesArr.length == 1) {
				targetLoader.visible = true;
				_imagesCount += 1;
				_lastDisplay = targetLoader;
			}else {
				targetLoader.visible = false;
			}
		}
		
		private function Update(e : Event) : void {
			if (_imagesArr.length == 0) {
				return;
			}
			if (_imagesCount >= _imagesArr.length) {
				_imagesCount = 0;
			}
			if (_lastDisplay != null) {
				_lastDisplay.visible = false;
			}
			var dispaly : DisplayObject = _imagesArr[_imagesCount];
			dispaly.visible = true;
			_lastDisplay = dispaly;
			_imagesCount += 1;
		}
		
	}

}