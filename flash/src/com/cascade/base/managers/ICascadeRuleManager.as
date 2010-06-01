package com.cascade.base.managers
{
	import com.cascade.base.rule.ICascadeRule;
	
	public interface ICascadeRuleManager
	{
		function get rules():Array;
		function register(rule:ICascadeRule):void;
	}
}