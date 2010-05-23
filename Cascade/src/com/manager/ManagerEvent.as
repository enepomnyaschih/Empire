package com.manager
{
	import com.ITyped;
	
	import flash.events.Event;

	public class ManagerEvent extends Event
	{
		private var _item:ITyped;
		
		public function ManagerEvent(type:String, item:ITyped)
		{
			super(type);
			_item = item;
		}
		
		public function get item():ITyped
		{
			return _item;
		}
		
		override public function clone():Event
		{
			return new ManagerEvent(type, item);
		}
	}
}