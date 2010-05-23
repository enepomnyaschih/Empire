package com.cascade.mouse.managers
{
	import com.cascade.base.managers.CascadeActionFactoryManager;
	import com.cascade.mouse.mousetool.IMouseToolFactory;

	public class MouseToolFactoryManager extends CascadeActionFactoryManager implements IMouseToolFactoryManager
	{
		public function getMouseToolFactory(type:String):IMouseToolFactory
		{
			return IMouseToolFactory(getItem(type));
		}
	}
}