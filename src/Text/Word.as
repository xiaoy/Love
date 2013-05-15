package Text 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author lfwu
	 */
	public class Word extends Sprite
	{
		private var textFiled : TextField = null;
		public function Word() 
		{
			
		}
		
		public function init(size : int, text : String, color : int, font : String = null) : void {
			textFiled = new TextField();
			textFiled.text = text;
			textFiled.autoSize = TextFieldAutoSize.LEFT;
			var textFormat : TextFormat = new TextFormat();
			textFormat.font = font;
			textFormat.size = size;
			textFormat.color = color;
			textFiled.setTextFormat(textFormat);
			addChild(textFiled);
			textFiled.x -= textFiled.width / 2;
			textFiled.y -= textFiled.height / 2;
		}
		
		public function dispose() : void {
			removeChild(textFiled);
			textFiled = null;
		}
		
	}

}