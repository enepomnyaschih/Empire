package com.cascade.base.element.base
{
	import com.IFreeable;
	
	import mx.core.UIComponent;
	
	public interface ICascadeElement extends IFreeable, ICascadeElementContainer, ICascadeStatusContainer
	{
		function get target():UIComponent;
		function get parent():ICascadeElement;
		function get name():String;
		
		function get isHover():Boolean;
		function set isHover(value:Boolean):void;
		
		function getElementsChain():Array;
		function fillElementsChain(chain:Array):void;
		
		function get autoValidate():Boolean;
		function set autoValidate(value:Boolean):void;
		
		function get isStyleValid():Boolean;
		function invalidateStyle():void;
		function validateStyle():void;
		
		function setParent(parent:ICascadeElement):void; // for internal use only
	}
}