package com.cascade.base.actions.base
{
	import com.IFreeable;
	import com.ITyped;
	import com.cascade.base.element.base.ICascadeElement;
	
	import flash.events.IEventDispatcher;
	
	public interface ICascadeAction extends IEventDispatcher, ITyped, IFreeable
	{
		function get element():ICascadeElement;
		function set element(value:ICascadeElement):void;
	}
}