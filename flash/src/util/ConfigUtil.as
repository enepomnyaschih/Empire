package util
{
	import mx.controls.Alert;
	
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
		
		public static function config(host:Object, config:Object, defaults:Object = null):Object
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
		
		public static function map(data:Object, config:Object):Object
		{
			var result:Object = new Object();
			for (var key:* in data)
			{
				if (config[key] === null)
					continue;
				
				result[key] = (config[key] === undefined) ? data[key] : data[config[key]];
			}
			
			return result;
		}
		
		public static function sub(data:Object, keys:Array):Object
		{
			var result:Object = new Object();
			for (var key:* in data)
			{
				if (keys.indexOf(key) == -1)
					continue;
				
				result[key] = data[key];
			}
			
			return result;
		}
	}
}