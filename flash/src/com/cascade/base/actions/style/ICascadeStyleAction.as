package com.cascade.base.actions.style
{
	import com.cascade.base.actions.base.ICascadeAction;
	import com.cascade.base.styles.base.ICascadeStyle;

	public interface ICascadeStyleAction extends ICascadeAction
	{
		function get style():ICascadeStyle;
		function set style(value:ICascadeStyle):void;
	}
}