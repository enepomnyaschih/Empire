package com.cascade.base.styles.base
{
	import com.cascade.base.actions.style.ICascadeStyleAction;
	import com.cascade.base.actions.style.ICascadeStyleActionFactory;
	import com.cascade.base.element.base.ICascadeElement;
	
	public interface ICascadeStyle
	{
		function get styleName():String;
		function get param():*;
		function get actionFactory():ICascadeStyleActionFactory;
		
		function createAction(element:ICascadeElement):ICascadeStyleAction;
	}
}