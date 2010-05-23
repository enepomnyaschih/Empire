package com.cascade.mouse.action
{
	import com.cascade.base.actions.style.CascadeStyleAction;
	import com.cascade.base.styles.base.ICascadeStyle;
	import com.cascade.mouse.managers.MouseManager;

	public class CascadeActionMouseTool extends CascadeStyleAction implements ICascadeActionMouseTool
	{
		public static const TYPE:String = "MouseTool";
		
		override public function get type():String
		{
			return TYPE;
		}
		
		override protected function update(oldStyle:ICascadeStyle):void
		{
			if (oldStyle)
				return;
			
			MouseManager.instance.addAction(this);
		}
		
		override public function free():void
		{
			MouseManager.instance.removeAction(this);
		}
	}
}