package com.cascade.base.actions.style
{
	import com.cascade.base.actions.base.CascadeAction;
	import com.cascade.base.styles.base.ICascadeStyle;

	public class CascadeStyleAction extends CascadeAction implements ICascadeStyleAction
	{
		private var _style:ICascadeStyle;
		
		public function get style():ICascadeStyle
		{
			return _style;
		}
		
		public function set style(value:ICascadeStyle):void
		{
			if (_style == value)
				return;
			
			var oldStyle:ICascadeStyle = _style;
			_style = value;
			update(oldStyle);
		}
		
		virtual protected function update(oldStyle:ICascadeStyle):void
		{
		}
	}
}