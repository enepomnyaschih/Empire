package com.cascade.base.managers
{
	import com.cascade.base.actions.style.ICascadeStyleActionFactory;
	import com.factory.FactoryManager;
	
	public class CascadeActionFactoryManager extends FactoryManager implements ICascadeActionFactoryManager
	{
		public function getActionFactory(type:String):ICascadeStyleActionFactory
		{
			return ICascadeStyleActionFactory(getFactory(type));
		}
	}
}