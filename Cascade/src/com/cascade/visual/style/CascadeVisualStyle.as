package com.cascade.visual.style
{
	import com.cascade.base.styles.base.CascadeStyle;
	import com.cascade.visual.action.CascadeVisualAction;

	public class CascadeVisualStyle extends CascadeStyle implements ICascadeVisualStyle
	{
		private var _styleName:String;
		private var _flexStyleName:String;
		
		public function CascadeVisualStyle(styleName:String, flexStyleName:String, param:*=null)
		{
			super(param);
			
			_styleName = styleName;
			_flexStyleName = flexStyleName;
		}
		
		override public function get styleName():String
		{
			return _styleName;
		}
		
		public function get flexStyleName():String
		{
			return _flexStyleName;
		}
		
		override protected function get actionType():String
		{
			return CascadeVisualAction.TYPE;
		}
	}
}