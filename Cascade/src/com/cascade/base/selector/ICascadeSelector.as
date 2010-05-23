package com.cascade.base.selector
{
	public interface ICascadeSelector
	{
		function get words():Array;
		function get hover():Boolean;
		
		function fits(elements:Array):Boolean;
	}
}