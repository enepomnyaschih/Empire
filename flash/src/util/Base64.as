package util
{
	import flash.utils.Dictionary;
	
	public class Base64
	{
		private static var _instance:Base64;
		
		private var _symbols:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
		private var _indexes:Dictionary = new Dictionary();
		
		public function Base64()
		{
			for (var i:int = 0; i < _symbols.length; ++i)
				_indexes[_symbols.charAt(i)] = i;
		}
		
		public static function get instance():Base64
		{
			if (!_instance)
				_instance = new Base64();
			
			return _instance;
		}
		
		public function getBaseSymbol(index:int):String
		{
			return _symbols.charAt(index);
		}
		
		public function getBaseIndex(symbol:String):int
		{
			return _indexes[symbol];
		}
	}
}