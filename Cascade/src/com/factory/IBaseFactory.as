package com.factory
{
	import com.ITyped;
	
	import flash.events.IEventDispatcher;
	
	public interface IBaseFactory extends IEventDispatcher, ITyped
	{
		function get cls():Class;
	}
}