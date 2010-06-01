package com.cascade.base.switcher
{
	import com.cascade.base.element.base.ICascadeElement;
	
	public class CascadeSwitcher implements ICascadeSwitcher
	{
		private var _element:ICascadeElement;
		private var _status:String;
		
		public function CascadeSwitcher(element:ICascadeElement, status:String = null)
		{
			_element = element;
			
			this.status = status;
		}
		
		[Bindable]
		public function get status():String
		{
			return _status;
		}
		
		public function set status(value:String):void
		{
			_element.removeStatus(_status)
			_status = value;
			_element.addStatus(_status);
		}
	}
}