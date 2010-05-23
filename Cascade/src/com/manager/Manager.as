package com.manager
{
	import com.ITyped;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import util.ErrorUtil;

	public class Manager extends EventDispatcher implements IManager
	{
		public static const EVENT_ITEM_REGISTERED:String = "itemRegistered";
		
		private var _types:Array = new Array();
		private var _items:Dictionary = new Dictionary();
		
		public function register(item:ITyped):void
		{
			if (_items[item.type])
				ErrorUtil.throwMsg("Item with type '" + item.type + "' is registered already");
			
			_items[item.type] = item;
			_types.push(item.type);
			
			dispatchEvent(new ManagerEvent(EVENT_ITEM_REGISTERED, item));
		}
		
		public function get types():Array
		{
			return _types;
		}
		
		public function getItem(type:String):ITyped
		{
			return _items[type];
		}
	}
}