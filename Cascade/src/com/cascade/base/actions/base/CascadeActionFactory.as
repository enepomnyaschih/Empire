package com.cascade.base.actions.base
{
	import com.cascade.base.element.base.ICascadeElement;
	import com.factory.BaseFactory;
	
	public class CascadeActionFactory extends BaseFactory implements ICascadeActionFactory
	{
		public function createAction(element:ICascadeElement):ICascadeAction
		{
			var action:ICascadeAction = new cls();
			action.element = element;
			
			return action;
		}
	}
}