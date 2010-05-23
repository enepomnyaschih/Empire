package com.collections
{
	import flash.utils.Dictionary;
	
	public class BaseSet implements ISet
	{
		private var _weak	:Boolean;
		private var _map	:Dictionary;
		
		public function BaseSet(weakReferences:Boolean = false)
		{
			_weak = weakReferences;
			
			clear();
		}
		
		public function isItem(item:*):Boolean
		{
			return !!_map[item];
		}
		
		public function addItem(item:*):void
		{
			_map[item] = true;
		}
		
		public function removeItem(item:*):void
		{
			if (_map[item])
				delete _map[item];
		}
		
		public function setItem(item:*, value:Boolean):void
		{
			if (value)
				addItem(item);
			else
				removeItem(item)
		}
		
		public function clear():void
		{
			_map = new Dictionary(_weak);
		}
		
		public function isWeakReferences():Boolean
		{
			return _weak;
		}
	}
}