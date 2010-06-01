package com.cascade.base.actions.base
{
	import com.cascade.base.element.base.ICascadeElement;
	import com.factory.IBaseFactory;

	public interface ICascadeActionFactory extends IBaseFactory
	{
		function createAction(element:ICascadeElement):ICascadeAction;
	}
}