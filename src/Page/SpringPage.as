package Page 
{
	import Configure.ResourceManager;
	import flash.display.Sprite;
	import flash.geom.Point;
	import Text.Word;
	/**
	 * ...
	 * @author lfwu
	 */
	public class SpringPage extends Sprite
	{
		public static const CONFIG_URL : String = "Res/Configs/SpringPage";
		private var _configXml : XML = null;
		public function SpringPage() 
		{
			_configXml = ResourceManager.instance().getXmlConfig(CONFIG_URL);
			init();
		}
		
		private function init() : void {
			var pageXml : XML = _configXml.PageSpring[0];
			
			var titleXml : XMLList = pageXml.Title;		
			var title : Word = new Word();
			title.initByXml(titleXml);
			addChild(title);
		
			var textXml : XMLList = pageXml.Text;
			var text : Word = new Word();
			text.initByXml(textXml);
			addChild(text);
		}
		
	}

}