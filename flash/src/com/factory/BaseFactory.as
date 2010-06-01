package com.factory
{
	import flash.events.EventDispatcher;
	
	import util.ErrorUtil;
	
	public class BaseFactory extends EventDispatcher implements IBaseFactory
	{
		virtual public function get type():String
		{
			return ErrorUtil.throwMustOverride();
		}
		
		virtual public function get cls():Class
		{
			return ErrorUtil.throwMustOverride();
		}
	}
}