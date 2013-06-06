package Utility 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author lfwu
	 */
	public class Tween 
	{
		private static var _timerArr : Array  = new Array();
		public function Tween() 
		{
			
		}
		
		public static function delayCall(delay : int, callBack : Function) : Timer {
			var timer : Timer = new Timer(delay);
			timer.addEventListener(TimerEvent.TIMER, tickListener);
			timer.start();
			function tickListener(e : TimerEvent) : void {
				callBack();
			}
			var element : Object = { "timer":timer, "fun":tickListener };
			_timerArr.push(element);
			return timer;
		}
		
		public static function killTween(timer : Timer) : void {
			var findElement : Object = null;
			var index : int = 0;
			for each(var element : Object in _timerArr) {
				if (element["timer"] == timer) {
					findElement = element;
					break;
				}
				index += 1;
			}
			_timerArr.splice(index, 1);
			if (index >= 0 && findElement != null) {
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, findElement["fun"]);	
				timer = null;
			}
		}
	}

}