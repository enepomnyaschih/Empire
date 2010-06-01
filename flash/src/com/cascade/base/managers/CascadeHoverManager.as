package com.cascade.base.managers
{
	import com.cascade.base.element.base.ICascadeElement;
	
	import flash.events.EventDispatcher;
	
	public class CascadeHoverManager extends EventDispatcher
	{
		private var _hoverElements:Array = new Array();
		
		public function CascadeHoverManager()
		{
			super();
		}
		
		public function get hoverElements():Array
		{
			return _hoverElements;
		}
		
		public function addHoverElement(element:ICascadeElement):void
		{
			if (_hoverElements.indexOf(element) != -1)
				return;
			
			_hoverElements.push(element);
		}
		
		public function removeHoverElement(element:ICascadeElement):void
		{
			var index = _hoverElements.indexOf(element);
			if (index == -1)
				return;
			
			_hoverElements.splice(index, 1);
		}
	}
}