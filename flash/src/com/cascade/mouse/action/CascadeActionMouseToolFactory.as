package com.cascade.mouse.action
{
	import com.cascade.base.actions.style.CascadeStyleActionFactory;

	public class CascadeActionMouseToolFactory extends CascadeStyleActionFactory implements ICascadeActionMouseToolFactory
	{
		override public function get type():String
		{
			return CascadeActionMouseTool.TYPE;
		}
		
		override public function get cls():Class
		{
			return CascadeActionMouseTool;
		}
	}
}