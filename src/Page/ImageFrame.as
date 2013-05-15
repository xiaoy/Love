package Page 
{
	import Animate.MoveTo;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author lfwu
	 */
	public class ImageFrame extends Sprite
	{
		private var _textfield : TextField = new TextField();
		
		public function ImageFrame() 
		{
			var text : String = "那年我们相聚到哈尔滨.............................................................";
			
			_textfield = new TextField();
			_textfield.text = text;
			_textfield.autoSize = TextFieldAutoSize.LEFT;
			addChild(_textfield);
			//textfield.cacheAsBitmap = true;
			_textfield.x = 100;
			_textfield.y = 100;
			
			var textMask : Sprite = new Sprite();
			textMask.graphics.lineStyle(1);
			textMask.graphics.beginFill(0xff0000, 0.5);
			textMask.graphics.drawEllipse(100, 100, 500, 300);
			textMask.graphics.endFill();
			addChild(textMask);
			this.mask = textMask;
			textMask.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener);
			textMask.addEventListener(MouseEvent.MOUSE_UP, mouseUpListener);
			
			var urlLoader : Loader = new Loader();
			urlLoader.load(new URLRequest("http://images6.fanpop.com/image/photos/33600000/beautiful-flowers-flowers-33623954-500-500.jpg"));
			addChild(urlLoader);
			var moveto : MoveTo = new MoveTo(new Point(0, 500), 10, textMask);
			moveto.Play();			
		}
		private function mouseDownListener(e : MouseEvent) : void {
			Sprite(e.target).removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener);
			Sprite(e.target).startDrag();
		}
		
		private function mouseUpListener(e : MouseEvent) : void {
			Sprite(e.target).removeEventListener(MouseEvent.MOUSE_UP, mouseUpListener);
			Sprite(e.target).stopDrag();
			this.mask = Sprite(e.target);
		}	
	}

}