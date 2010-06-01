package com.cascade.base.rule
{
	import com.cascade.base.selector.ICascadeSelector;
	
	import flash.utils.Dictionary;
	
	public interface ICascadeRule
	{
		function get selectors():Array;
		function get styles():Dictionary;
		function get priority():Number;
	}
}