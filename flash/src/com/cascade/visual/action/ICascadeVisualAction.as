package com.cascade.visual.action
{
	import com.cascade.base.actions.style.ICascadeStyleAction;
	import com.cascade.visual.style.ICascadeVisualStyle;
	
	public interface ICascadeVisualAction extends ICascadeStyleAction
	{
		function get styleFlexStyle():ICascadeVisualStyle;
	}
}