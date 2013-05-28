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
		
		public function CardPage(title : Word, display : DisplayObject) 
		{
			display.x = Config.getSceneWidth()/2 - 250;
			display.y = Config.getSceneHeight()/2 - 175;
			display.visible = true;
			addChild(display);
			
			title.x = 400;
			title.y = 100;
			addChild(title);
		}
		
		public function play(delay : int, callBack : Function) : void {
			var timer : Timer = Tween.delayCall(delay, function Tick() : void {
				alpha -= 0.01;
				if (alpha <= 0) {
					timer.stop();
					var event : TimerEvent = new TimerEvent(TimerEvent.TIMER_COMPLETE);
					timer.dispatchEvent(event);
					callBack();
					//this.parent.removeChild(this);
				}
			});
		}
	}

}