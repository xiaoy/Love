package Page 
{
	import Configure.Config;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import Text.Word;
	import Utility.Tween;
	/**
	 * ...
	 * @author lfwu
	 */
	public class CardPage extends Sprite
	{
		private var _title : Word = null;
		private var _display : DisplayObject = null;
		
		public function CardPage(title : Word, display : DisplayObject) 
		{
			_display = display;
			_display.x = Config.getSceneWidth()/2 - 250;
			_display.y = Config.getSceneHeight()/2 - 175;
			addChild(_display);
			
			_title = title;
			_title.x = 0;
			_title.y = 100;
			addChild(_title);
		}
		
		public function play(delay : int, callBack : Function) : void {
			var timer : Timer = Tween.delayCall(delay, function Tick() : void {
				if (_title.x > Config.getSceneWidth() / 2) {
					_display.alpha -= 0.01;
				}else {
					_title.x += 2;					
				}
				if (_display.alpha <= 0) {
					timer.stop();
					var event : TimerEvent = new TimerEvent(TimerEvent.TIMER_COMPLETE);
					timer.dispatchEvent(event);
					callBack();
				}
			});
		}
	}

}