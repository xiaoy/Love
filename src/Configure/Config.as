package Configure 
{
	import flash.display.Stage;
	import Debug.LogInfo;
	/**
	 * ...
	 * @author lfwu
	 */
	public class Config 
	{
		private static var _stage : Stage = MainGame.instance().getStage();
		public function Config() 
		{
			
		}
		
		public static function getSceneWidth() : Number {
			if (_stage == null) {
				LogInfo.error("Main stage is not inited");
				return 0;
			}
			return _stage.stageWidth;
		}
		
		public static function getSceneHeight() : Number {
			if (_stage == null) {
				LogInfo.error("Main stage is not inited");
				return 0;				
			}
			return _stage.stageHeight;
		}
	}

}