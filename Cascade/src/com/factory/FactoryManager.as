package com.factory
{
	import com.manager.Manager;
	
	public class FactoryManager extends Manager
	{
		public function getFactory(type:String):IBaseFactory
		{
			return IBaseFactory(getItem(type));
		}
	}
}