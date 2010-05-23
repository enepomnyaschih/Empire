package com.cascade.base.actions.style
{
	import com.cascade.base.actions.base.ICascadeActionFactory;
	import com.cascade.base.element.base.ICascadeElement;
	import com.cascade.base.styles.base.ICascadeStyle;
	
	public interface ICascadeStyleActionFactory extends ICascadeActionFactory
	{
		function createActionStyle(element:ICascadeElement, style:ICascadeStyle):ICascadeStyleAction;
	}
}