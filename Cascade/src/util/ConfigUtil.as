package util
{
	public class ConfigUtil
	{
		public static function apply(host:Object, server:Object):Object
		{
			if (!server)
				return host;
			
			for (var key:* in server)
				host[key] = server[key];
			
			return host;
		}
		
		public static function applyIf(host:Object, server:Object):Object
		{
			if (!server)
				return host;
			
			for (var key:* in server)
				if (host[key] === undefined || host[key] === null)
					host[key] = server[key];
			
			return host;
		}
		
		public static function config(host:Object, config:Object, defaults:Object):Object
		{
			if (defaults)
				for (var key:* in defaults)
					if (!config || config[key] === undefined || config[key] === null)
						host[key] = defaults[key];
			
			return ConfigUtil.apply(host, config);
		}
		
		public static function clone(server:Object):Object
		{
			return ConfigUtil.apply(new Object(), server);
		}
		
		/**
		 * Find element in host object.
		 * Returns host, if path == "" or null.
		 * Else, path must be an array of identifiers/indexes separated by ".".
		 * Example: getChild(host, "6.tada.0") returns host[6].tada[0].
		 */
		public static function getChild(host:Object, path:String):*
		{
			if (!path || path == "")
				return host;
			
			var fields:Array = path.split(".");
			for (var i:int = 0; i < fields.length; ++i)
			{
				if (!host)
					return null;
				
				host = host[fields[i]];
			}
			
			return host;
		}
	}
}