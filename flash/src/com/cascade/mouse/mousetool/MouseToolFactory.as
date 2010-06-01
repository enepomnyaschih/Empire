package com.cascade.mouse.mousetool
{
	import com.cascade.base.actions.base.CascadeActionFactory;
	import com.cascade.base.element.base.ICascadeElement;

	public class MouseToolFactory extends CascadeActionFactory implements IMouseToolFactory
	{
		public function createMouseTool(element:ICascadeElement):IMouseTool
		{
			var mouseTool:IMouseTool = new cls();
			mouseTool.element = element;
			
			return mouseTool;
		}
	}
}