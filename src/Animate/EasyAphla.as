package Animate 
{
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import Utility.Tween;
	/**
	 * ...
	 * @author lfwu
	 */
	public class EasyAphla 
	{
		private static const FRAME_TIMER : Number = 0.01;
		private var _callBack : Function = null;
		private var _timer : Timer = null;
		private var _targetAlpha : Number = 0;
		private var _displayObject : DisplayObject = null;
		private var _usedTime : Number = 0;
		private var _runedTime : Number = 0;
		private var _velociy : Number = 0;
		
		public function EasyAphla(displayObject : DisplayObject, usedTime : Number, targetAlpha : Number, callBack : Function = null) 
		{
			_targetAlpha = targetAlpha;
			_callBack = callBack;
			_displayObject = displayObject;
			_usedTime = usedTime;
			var sourceAlpha : Number = _displayObject.alpha;
			_velociy = (_targetAlpha - sourceAlpha) / _usedTime;
		}
		
		public function play() : void {
			_timer = Tween.delayCall(FRAME_TIMER, update);		
		}
		
		private function update() : void {
			var alphaTemp : Number = _velociy * FRAME_TIMER;
			_displayObject.alpha += alphaTemp;
			if (_displayObject.alpha - _targetAlpha < Number.MIN_VALUE) {
				Tween.killTween(_timer);
				if (_callBack != null) {
					_callBack();
				}
			}
		}
		
	}

}