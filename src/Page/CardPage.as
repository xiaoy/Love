package Page 
{
	import Animate.EasyAphla;
	import Animate.MoveTo;
	import Configure.Config;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
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
		private var _callBack : Function = null;
		
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
		
		public function play(callBack : Function) : void {
			_callBack = callBack;
			var targetPos : Point = new Point(Config.getSceneWidth() / 2, _title.y);
			var moveTo : MoveTo = new MoveTo(targetPos, 5, _title, function moveToHandle() : void {
				hide();
			});
			moveTo.Play();
		}
		
		private function hide() : void {
			var alphaTo : EasyAphla = new EasyAphla(_display, 5, 0.1, function alphaTo() : void {
				if (_callBack != null) {
					_callBack();
				}
			});
			alphaTo.play();
		}
	}

}