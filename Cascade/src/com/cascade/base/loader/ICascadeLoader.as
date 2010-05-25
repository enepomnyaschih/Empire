package com.cascade.base.loader
{
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	
	public interface ICascadeLoader extends IEventDispatcher
	{
		function load(request:URLRequest):void;
	}
}