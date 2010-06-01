package com.cascade.base.selector
{
	import com.cascade.base.element.base.ICascadeElement;
	
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
			statuses.shift();
			
			return new CascadeSelectorWord(name, statuses);
		}
	}
}