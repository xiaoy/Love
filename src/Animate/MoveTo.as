package Animate 
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.utils.*;
	import Utility.Tween;
	/**
	 * ...
	 * @author lfwu
	 */
	public class MoveTo
	{
		private static const FRAME_TIME : Number = 0.01;
		private var _runTimes : Number = 0;
		private var _to : Point = null;
		private var _callBack : Function = null;
		private var _disaply : DisplayObject = null;
		private var _velicityX : Number = 0;
		private var _velicityY : Number = 0;
		private var _timer : Timer = null;
		
		public function MoveTo(to : Point, delay : Number, display : DisplayObject, callBack : Function = null) 
		{
			// Init the argument
			_to = new Point(to.x, to.y);
			_runTimes = delay;
			_disaply = display;
			_callBack = callBack;
			Init();
		}
		
		private function Init() : void {
			_velicityX = (_to.x - _disaply.x) / _runTimes;
			_velicityY = (_to.y - _disaply.y) / _runTimes;
		}
		
		private function Update() : void {
			// Check the sprite get distance pos
			if (_disaply.x - _to.x > Number.MIN_VALUE || _disaply.y - _to.y > Number.MIN_VALUE) {
				Stop();
				return;
			}
			// Caculate the det pos
			var detX : Number = _velicityX * FRAME_TIME;
			var detY : Number = _velicityY * FRAME_TIME;
			// Update the sprite pos
			_disaply.x += detX;
			_disaply.y += detY;
		}
		
		public function Play() : void {
			if (_timer != null) {
				return;
			}
			_timer = Tween.delayCall(FRAME_TIME, Update);
		}
		
		public function Stop() : void {
			if (_callBack != null) {
				Tween.killTween(_timer);
				_callBack();
			}
			Dipose();
		}
		
		public function Dipose() : void {
			_runTimes = 0;
			_to = null;
			_disaply = null;
			_callBack = null;
		}
	}

}