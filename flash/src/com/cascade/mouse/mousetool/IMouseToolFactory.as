package com.cascade.mouse.mousetool
{
	import com.cascade.base.actions.base.ICascadeActionFactory;
	import com.cascade.base.element.base.ICascadeElement;

	public interface IMouseToolFactory extends ICascadeActionFactory
	{
		function createMouseTool(element:ICascadeElement):IMouseTool;
	}
}