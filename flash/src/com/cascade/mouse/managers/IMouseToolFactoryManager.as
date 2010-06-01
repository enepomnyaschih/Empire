package com.cascade.mouse.managers
{
	import com.cascade.base.managers.ICascadeActionFactoryManager;
	import com.cascade.mouse.mousetool.IMouseToolFactory;

	public interface IMouseToolFactoryManager extends ICascadeActionFactoryManager
	{
		function getMouseToolFactory(type:String):IMouseToolFactory;
	}
}