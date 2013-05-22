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
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	import flash.globalization.StringTools;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import Text.Word;
	import Utility.Tween;
	/**
	 * ...
	 * @author lfwu
	 */
	public class SpringPage extends Sprite
	{
		public static const CONFIG_URL : String = "Res/Configs/SpringPage";
		private var _configXml : XML = null;
		private var _imagesCount : int = 0;
		private var _timer : Timer = null;
		private var _imagesArr : Array = new Array();
		private	var _text : Word = new Word();
		private var _imageTitle : Word = new Word();
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
		
			//var textXml : XMLList = pageXml.Text;
			//_text.initByXml(textXml);
			//addChild(_text);
			
			_imageTitle.init(24, "", 0x00ff00, "Arial");
			_imageTitle.x = 400;
			_imageTitle.y = 100;
			addChild(_imageTitle);
			var alphaTimer : Timer = Tween.delayCall(100, function easyAlpha() : void {
				title.alpha -= 0.1;
				if (title.alpha <= 0) {
					alphaTimer.stop();
					var event : TimerEvent = new TimerEvent(TimerEvent.TIMER_COMPLETE);
					alphaTimer.dispatchEvent(event);
				}
			});
			
			var imagesXml : XMLList = pageXml.Images;
			for each(var imageXml : XML in imagesXml.*) {
				var name : String = imageXml.@url;
				var path : String = "Res/Images/" + name;
				var loader : Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadImagesHandle);
				loader.load(new URLRequest(path));
				loader.x = imagesXml.@posX;
				loader.y = imagesXml.@posY;
				loader.visible = false;
				var obj : Object = new Object();
				obj.img = loader;
				var words : Word = new Word();
				words.init(24, imageXml.toString(), 0x00ff00, "Arial");
				obj.text = words;
				_imagesArr.push(obj);

			}
			//_timer = new Timer(imagesXml.@delay * 1000);
			//_timer.addEventListener(TimerEvent.TIMER, Update);
			//_timer.start();
			//_imagesCount = imagesXml.length;
		}
		
		private function loadImagesHandle(e : Event) : void {
			var targetLoader : Loader = e.currentTarget.loader as Loader;
			targetLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadImagesHandle);
			addChild(targetLoader);
			//if (_imagesCount == 0) {
				//setModelVisible(_imagesCount, true);
				//_imagesCount += 1;
			//}
			_imagesCount += 1;
			if (_imagesCount == _imagesArr.length) {
				_imagesCount -= 1;
				createCard();
				function createCard() : void {
					var obj : Object = _imagesArr[_imagesCount];
					var card : CardPage = new CardPage(obj.text, obj.img);
					addChild(card);
					card.play(20, callback);			
				}

				function callback() : void {
					_imagesCount -= 1;
					if (_imagesCount >= 0) {
						createCard();
					}
				}
			}
		}
		
		private function Update(e : Event) : void {
			if (_imagesArr.length == 0) {
				return;
			}
			if (_imagesCount >= _imagesArr.length) {
				_imagesCount = 0;
				_timer.stop();
			}
			if (_lastDisplay != null) {
				_lastDisplay.visible = false;
			}
			_text.visible = false;
			setModelVisible(_imagesCount, true);
			_imagesCount += 1;
		}
		
		private function setModelVisible(index : int, visible : Boolean) : void {
			_imageTitle.setText(_imagesArr[index].text);
			var dispaly : DisplayObject = _imagesArr[index].img;
			dispaly.visible = visible;		
			_lastDisplay = dispaly;
		}
		
	}

}