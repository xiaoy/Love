package Page 
{
	import Configure.ConfigManager;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import Text.Word;
	import Utility.Tween;
	/**
	 * ...
	 * @author lfwu
	 */
	public class SpringPage extends Sprite
	{
		public static const CONFIG_URL : String = "SpringPage";
		private var _configXml : XML = null;
		private var _imagesCount : int = 0;
		private var _imagesArr : Array = new Array();
		private	var _text : Word = new Word();
		private var _imageTitle : Word = new Word();
		private var _lastDisplay : DisplayObject = null;
		private var _finishCallBack : Function = null;
		
		public function SpringPage(func : Function) 
		{
			_configXml = new XML(ConfigManager.instance().getResData(CONFIG_URL));
			_finishCallBack = func;
			init();
		}
		
		
		private function init() : void {
			var pageXml : XML = _configXml.PageSpring[0];
			
			var titleXml : XMLList = pageXml.Title;		
			var title : Word = new Word();
			title.initByXml(titleXml);
			addChild(title);
			
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
				var bitmap : Bitmap = ConfigManager.instance().getResData(name);
				bitmap.x = imagesXml.@posX;
				bitmap.y = imagesXml.@posY;
				var obj : Object = new Object();
				obj.img = bitmap;
				var words : Word = new Word();
				words.init(24, imageXml.toString(), 0x00ff00, "Arial");
				obj.text = words;
				_imagesArr.push(obj);

			}
			_imagesCount = imagesXml.children().length();
			createCard();
		}
		
		private function createCard() : void {
			if (_lastDisplay != null) {
				this.removeChild(_lastDisplay);
				_lastDisplay = null;
			}
			if (_imagesArr.length == 0) {
				if (_finishCallBack != null) {
					_finishCallBack();
				}
				return;
			}
			var index : int = Math.random() * _imagesArr.length;
			var obj : Object = _imagesArr[index];
			var card : CardPage = new CardPage(obj.text, obj.img);
			addChild(card);
			card.play(40, createCard);			
			_lastDisplay = card;
			_imagesArr.splice(index, 1);
		}
		
	}

}