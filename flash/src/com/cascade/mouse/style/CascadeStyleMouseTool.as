package com.cascade.mouse.style
{
	import com.cascade.base.styles.base.CascadeStyle;
	import com.cascade.mouse.action.CascadeActionMouseTool;
	
	public class CascadeStyleMouseTool extends CascadeStyle implements ICascadeStyleMouseTool
	{
		public static const STYLE_NAME:String = "mouseTool";
		
		public function CascadeStyleMouseTool(param:*=null)
		{
			super(param);
		}
		
		public function get mouseToolType():String
		{
			return String(param);
		}
		
		override public function get styleName():String
		{
			return STYLE_NAME;
		}
		
		override protected function get actionType():String
		{
			return CascadeActionMouseTool.TYPE;
		}
	}
}