package com.manager
{
	import com.ITyped;
	
	import flash.events.IEventDispatcher;

	public interface IManager extends IEventDispatcher
	{
		function register(item:ITyped):void;
		function get types():Array;
		function getItem(type:String):ITyped;
	}
}