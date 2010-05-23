package com.cascade.base.managers
{
	import com.cascade.base.styles.base.ICascadeStyleFactory;
	import com.factory.FactoryManager;

	public class CascadeStyleFactoryManager extends FactoryManager implements ICascadeStyleFactoryManager
	{
		public function CascadeStyleFactoryManager()
		{
			super();
		}
		
		public function getCascadeStyleFactory(styleName:String):ICascadeStyleFactory
		{
			return ICascadeStyleFactory(getFactory(styleName));
		}
	}
}