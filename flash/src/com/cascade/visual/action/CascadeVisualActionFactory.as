package com.cascade.visual.action
{
	import com.cascade.base.actions.style.CascadeStyleActionFactory;

	public class CascadeVisualActionFactory extends CascadeStyleActionFactory implements ICascadeVisualActionFactory
	{
		override public function get type():String
		{
			return CascadeVisualAction.TYPE;
		}
		
		override public function get cls():Class
		{
			return CascadeVisualAction;
		}
	}
}