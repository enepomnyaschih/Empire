package com.factory
{
	import com.manager.IManager;

	public interface IFactoryManager extends IManager
	{
		function getFactory(type:String):IBaseFactory;
	}
}