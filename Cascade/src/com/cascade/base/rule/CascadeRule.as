package com.cascade.base.rule
{
	import com.cascade.base.selector.ICascadeSelector;
	
	import flash.utils.Dictionary;
	
	public class CascadeRule implements ICascadeRule
	{
		private var _selector:ICascadeSelector;
		private var _styles:Dictionary;
		private var _priority:Number;
		
		public function CascadeRule(selector:ICascadeSelector, styles:Dictionary, priority:Number)
		{
			_selector	= selector;
			_styles		= styles;
			_priority	= priority;
		}
		
		public function get selector():ICascadeSelector
		{
			return _selector;
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