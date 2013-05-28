package Debug 
{
	/**
	 * ...
	 * @author lfwu
	 */
	public class LogInfo 
	{
		
		public function LogInfo() 
		{
			
		}
		
		public static function error(info : String) : void {
			trace("Error:" + info);
		}
		
		public static function warn(info : String) : void {
			trace("Warn:" + info);
		}
		
		public static function log(info : String) : void {
			trace("Log:" + info);
		}
	}

}