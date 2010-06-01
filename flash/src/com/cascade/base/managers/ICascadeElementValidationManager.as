package com.cascade.base.managers
{
	import com.cascade.base.element.base.ICascadeElement;
	
	public interface ICascadeElementValidationManager
	{
		function invalidateElementStyle(element:ICascadeElement):void;
		function validateAllElementsStyle():void;
	}
}