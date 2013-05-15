package Page 
{
	import Animate.MoveTo;
	import flash.display.Sprite;
	import flash.geom.Point;
	import Text.Word;
	import Configure.Config;
	/**
	 * ...
	 * @author lfwu
	 */
	public class StartPage extends Sprite
	{
		
		public function StartPage() 
		{
			init();
		}
		
		public function init() : void {
			var birthdayStr : String = "生日快乐";
			var words : Word = new Word();
			words.init(50, birthdayStr,  0xff0000, "Arial");
			addChild(words);
			var targetX : Number = Config.getSceneWidth() / 2;
			var targetY : Number = Config.getSceneHeight() / 2;
			var fromPos : Point = new Point(0, 0);
			var toPos : Point = new Point(targetX, targetY);
			var moveTo : MoveTo = new MoveTo(fromPos, toPos, 2, words);
			moveTo.Play();
		}
	}

}