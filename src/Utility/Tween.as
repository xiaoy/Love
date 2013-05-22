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
		public function Tween() 
		{
			
		}
		
		public static function delayCall(delay : int, callBack : Function) : Timer {
			var timer : Timer = new Timer(delay);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, complateListener);
			timer.addEventListener(TimerEvent.TIMER, tickListener);
			timer.start();
			function tickListener(e : TimerEvent) : void {
				callBack();
			}
			function complateListener(e : TimerEvent) : void {
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, complateListener);
				timer.removeEventListener(TimerEvent.TIMER, tickListener);
			}
			return timer;
		}
	}

}