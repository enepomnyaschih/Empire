package com.cascade.base.actions.style
{
	import com.cascade.base.actions.base.CascadeActionFactory;
	import com.cascade.base.element.base.ICascadeElement;
	import com.cascade.base.styles.base.ICascadeStyle;

	public class CascadeStyleActionFactory extends CascadeActionFactory implements ICascadeStyleActionFactory
	{
		public function createActionStyle(element:ICascadeElement, style:ICascadeStyle):ICascadeStyleAction
		{
			var action:ICascadeStyleAction = new cls();
			action.element = element;
			action.style   = style;
			
			return action;
		}
	}
}