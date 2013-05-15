package Animate 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.*;
	/**
	 * ...
	 * @author lfwu
	 */
	public class MoveTo
	{
		private var _delay : Number = 0;
		private var _to : Point = null;
		private var _from : Point = null;
		private var _callBack : Function = null;
		private var _isStart : Boolean = false;
		private var _disaply : DisplayObject = null;
		private var _velicityX : Number = 0;
		private var _velicityY : Number = 0;
		private var _lastTime : Number = 0;
		private var _allUsedTime : Number = 0;
		private var _timer : Timer = null;	
		public function MoveTo(to : Point, delay : Number, display : DisplayObject, callBack : Function = null) 
		{
			// Init the argument
			_to = new Point(to.x, to.y);
			_from = new Point(display.x, display.y);
			_delay = delay;
			_disaply = display;
			_callBack = callBack;
			Init();
		}
		
		private function Init() : void {
			_velicityX = (_to.x - _from.x) / _delay;
			_velicityY = (_to.y - _from.y) / _delay;
			_timer = new Timer(0.01);
			_timer.addEventListener(TimerEvent.TIMER, enterListener);
			_timer.start();
		}
		
		private function enterListener(e : Event) : void {
			Update();
		}
		private function Update() : void {
			if (!_isStart) {
				return;
			}
			// Get elapsed time
			var now : Number = getTimer();
			var elapsedTime : Number = (now - _lastTime)/1000;
			_allUsedTime += elapsedTime;
			// Check the sprite get distance pos
			if (_allUsedTime > _delay) {
				Stop();
				return;
			}
			// Caculate the det pos
			var detX : Number = _velicityX * elapsedTime;
			var detY : Number = _velicityY * elapsedTime;
			// Update the sprite pos
			_disaply.x += detX;
			_disaply.y += detY;
			_lastTime = now;
		}
		
		public function Play() : void {
			_isStart = true;
			_lastTime = getTimer();
			Update();
		}
		
		public function Stop() : void {
			if (_callBack != null) {
				_callBack();
			}
			_timer.stop();
			_isStart = false;
			Dipose();
		}
		
		public function Dipose() : void {
			_timer = null;
			_delay = 0;
			_to = null;
			_from = null
			_disaply = null;
			_callBack = null;
		}
	}

}