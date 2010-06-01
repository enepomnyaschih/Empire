package util
{
	import flash.external.ExternalInterface;
	
	public class ErrorUtil
	{
		public static const MUST_OVERRIDE:String = "Method is not implemented in superclass and must be overridden";
		
		public static function log(... args):void
		{
			ExternalInterface.call.apply(null, ["console.log"].concat(args));
		}
		
		public static function throwMsg(... args):*
		{
			log.apply(null, args);
			throw new Error(args.join(" "));
		}
		
		public static function throwMustOverride():*
		{
			return throwMsg(MUST_OVERRIDE);
		}
		
		public static function throwSingletonInstantiated(type:String):*
		{
			return throwMsg(type + " singleton is instantiated already.");
		}

	}
}