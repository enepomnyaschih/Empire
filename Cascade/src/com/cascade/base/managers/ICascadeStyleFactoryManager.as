package com.cascade.base.managers
{
	import com.cascade.base.styles.base.ICascadeStyleFactory;
	import com.factory.IFactoryManager;

	public interface ICascadeStyleFactoryManager extends IFactoryManager
	{
		function getCascadeStyleFactory(styleName:String):ICascadeStyleFactory;
	}
}