package com.cascade.base.loader
{
	import flash.events.Event;
	
	public class CascadeLoaderEvent extends Event
	{
		public static const SUCCESS:String = "success";
		public static const FAILURE:String = "failure";
		
		public function CascadeLoaderEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			return new CascadeLoaderEvent(type);
		}
	}
}