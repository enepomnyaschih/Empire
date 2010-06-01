package com.cascade.base.element.base
{
	public interface ICascadeElementContainer
	{
		function addChild(element:ICascadeElement):ICascadeElement;
		function addChildAt(element:ICascadeElement, index:int):ICascadeElement
		
		function contains(element:ICascadeElement):Boolean;
		
		function getChildAt(index:int):ICascadeElement;
		function getChildIndex(element:ICascadeElement):int;
		
		function removeChild(element:ICascadeElement):ICascadeElement;
		function removeChildAt(index:int):ICascadeElement;
	}
}