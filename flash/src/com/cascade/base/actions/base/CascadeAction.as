package com.cascade.base.actions.base
{
	import com.cascade.base.element.base.ICascadeElement;
	
	import flash.events.EventDispatcher;
	
	import util.ErrorUtil;
	
	public class CascadeAction extends EventDispatcher implements ICascadeAction
	{
		private var _element:ICascadeElement;
		
		public function CascadeAction()
		{
			super();
		}
		
		virtual public function free():void
		{
		}
		
		virtual public function get type():String
		{
			return ErrorUtil.throwMustOverride();
		}
		
		public function get element():ICascadeElement
		{
			return _element;
		}
		
		public function set element(value:ICascadeElement):void
		{
			_element = value;
		}
	}
}