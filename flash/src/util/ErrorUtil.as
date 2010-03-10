package util
{
	import flash.external.ExternalInterface;
	
	public class ErrorUtil
	{
		public static const MUST_OVERRIDE:String = "Method is not implemented in superclass and must be overridden";
		
		public static function log(msg:*):void
		{
			ExternalInterface.call("console.log", msg);
		}
		
		public static function throwMsg(msg:*):void
		{
			log(msg);
			throw new Error(msg);
		}
	}
}