package com.mouse
{
	public class MouseSwitcher
	{
		private var _wrapper:MouseWrapper;
		private var _status:String;
		
		public function MouseSwitcher(wrapper:MouseWrapper, status:String = null)
		{
			_wrapper = wrapper;
			
			this.status = status;
		}
		
		[Bindable]
		public function get status():String
		{
			return _status;
		}
		
		public function set status(value:String):void
		{
			_wrapper.removeStatus(_status)
			_status = value;
			_wrapper.addStatus(_status);
		}
	}
}