package com.cascade.mouse.mousetool
{
	import com.cascade.base.actions.base.CascadeAction;
	
	import util.ErrorUtil;
	
	public class MouseTool extends CascadeAction implements IMouseTool
	{
		public function init():void
		{
			ErrorUtil.throwMustOverride();
		}
	}
}