package com.cascade.base.managers
{
	import com.cascade.base.actions.style.ICascadeStyleActionFactory;
	import com.factory.IFactoryManager;

	public interface ICascadeActionFactoryManager extends IFactoryManager
	{
		function getActionFactory(type:String):ICascadeStyleActionFactory;
	}
}