package com.cascade.visual.action
{
	import com.cascade.base.actions.style.CascadeStyleAction;
	import com.cascade.base.styles.base.ICascadeStyle;
	import com.cascade.visual.style.ICascadeVisualStyle;
	
	public class CascadeVisualAction extends CascadeStyleAction implements ICascadeVisualAction
	{
		public static const TYPE:String = "FlexStyle";
		
		override public function free():void
		{
			setFlexStyle(null);
		}
		
		override public function get type():String
		{
			return TYPE;
		}
		
		public function get styleFlexStyle():ICascadeVisualStyle
		{
			return ICascadeVisualStyle(style);
		}
		
		override protected function update(oldStyle:ICascadeStyle):void
		{
			setFlexStyle(style.param);
		}
		
		private function setFlexStyle(param:*):void
		{
			element.target.setStyle(styleFlexStyle.flexStyleName, param);
		}
	}
}