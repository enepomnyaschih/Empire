package com.cascade.base.loader
{
	import flash.events.Event;
	
	public class CascadeLoaderEvent extends Event
	{
		public static const SUCCESS:String = "success";
		public static const FAILURE:String = "failure";
		
		private var _message:String;
		
		public function CascadeLoaderEvent(type:String, message:String = null)
		{
			super(type);
			
			_message = message;
		}
		
		public function get message():String
		{
			return _message;
		}
		
		override public function clone():Event
		{
			return new CascadeLoaderEvent(type, message);
		}
	}
}