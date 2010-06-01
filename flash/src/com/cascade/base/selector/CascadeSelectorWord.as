package com.cascade.base.selector
{
	import com.cascade.base.element.base.ICascadeElement;
	
	import util.ErrorUtil;
	
	public class CascadeSelectorWord implements ICascadeSelectorWord
	{
		private var _name:String;
		private var _statuses:Array;
		
		public function CascadeSelectorWord(name:String, statuses:Array)
		{
			_name = name;
			_statuses = statuses;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get statuses():Array
		{
			return _statuses;
		}
		
		public function fits(element:ICascadeElement):Boolean
		{
			if (_name && _name.length && element.name != _name)
				return false;
			
			return element.areStatuses(_statuses);
		}
		
		public static function createByString(source:String):CascadeSelectorWord
		{
			var statuses:Array = source.split(".");
			var name:String = statuses[0];
			if (!isElementName(name))
				return ErrorUtil.throwMsg("Can't parse '", name, "' as CSS element name.");
			
			statuses.shift();
			for (var i:int = 0; i < statuses.length; ++i)
			{
				if (!isElementStatus(statuses[i]))
					return ErrorUtil.throwMsg("Can't parse '", statuses[i], "' as CSS element status.");
			}
			
			return new CascadeSelectorWord(name, statuses);
		}
		
		private static function isElementName(value:String):Boolean
		{
			for (var i:int = 0; i < value.length; ++i)
			{
				var c:int = value.charCodeAt(i);
				if (c >= ("a").charCodeAt(0) &&
					c <= ("z").charCodeAt(0))
					continue;
				
				if (c >= ("A").charCodeAt(0) &&
					c <= ("Z").charCodeAt(0))
					continue;
				
				if (c >= ("0").charCodeAt(0) &&
					c <= ("9").charCodeAt(0) &&
					i != 0)
					continue;
				
				if (c == ("_").charCodeAt(0))
					continue;
				
				return false;
			}
			
			return true;
		}
		
		private static function isElementStatus(value:String):Boolean
		{
			for (var i:int = 0; i < value.length; ++i)
			{
				var c:int = value.charCodeAt(i);
				if (c >= ("a").charCodeAt(0) &&
					c <= ("z").charCodeAt(0))
					continue;
				
				if (c >= ("A").charCodeAt(0) &&
					c <= ("Z").charCodeAt(0))
					continue;
				
				if (c >= ("0").charCodeAt(0) &&
					c <= ("9").charCodeAt(0) &&
					i != 0)
					continue;
				
				if (c == ("_").charCodeAt(0) ||
					c == ("-").charCodeAt(0))
					continue;
				
				return false;
			}
			
			return true;
		}
	}
}