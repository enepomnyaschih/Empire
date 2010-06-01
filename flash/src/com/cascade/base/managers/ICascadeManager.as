package com.cascade.base.managers
{
	import flash.events.IEventDispatcher;
	
	public interface ICascadeManager extends IEventDispatcher
	{
		function get parserManager				():ICascadeParserManager;
		function get styleFactoryManager		():ICascadeStyleFactoryManager;
		function get actionFactoryManager		():ICascadeActionFactoryManager;
		function get elementValidationManager	():ICascadeElementValidationManager;
		function get ruleManager				():ICascadeRuleManager;
	}
}