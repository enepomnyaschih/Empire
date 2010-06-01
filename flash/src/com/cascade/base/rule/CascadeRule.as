package com.cascade.base.rule
{
	import com.cascade.base.selector.ICascadeSelector;
	
	import flash.utils.Dictionary;
	
	public class CascadeRule implements ICascadeRule
	{
		private var _selectors:Array;
		private var _styles:Dictionary;
		private var _priority:Number;
		
		public function CascadeRule(selectors:Array, styles:Dictionary, priority:Number)
		{
			_selectors	= selectors;
			_styles		= styles;
			_priority	= priority;
		}
		
		public function get selectors():Array
		{
			return _selectors;
		}
		
		public function get styles():Dictionary
		{
			return _styles;
		}
		
		public function get priority():Number
		{
			return _priority;
		}
	}
}