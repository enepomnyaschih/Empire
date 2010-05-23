package com.cascade.base.selector
{
	import com.cascade.base.element.base.ICascadeElement;
	
	public interface ICascadeSelectorWord
	{
		function get name():String;
		function get statuses():Array;
		
		function fits(element:ICascadeElement):Boolean;
	}
}