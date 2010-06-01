package com.cascade.base.managers
{
	import flash.events.EventDispatcher;
	
	import util.ErrorUtil;
	
	public class CascadeManager extends EventDispatcher implements ICascadeManager
	{
		private static var _instance:CascadeManager;
		
		private var _parserManager				:ICascadeParserManager				= new CascadeParserManager();
		private var _styleFactoryManager		:ICascadeStyleFactoryManager		= new CascadeStyleFactoryManager();
		private var _actionFactoryManager		:ICascadeActionFactoryManager		= new CascadeActionFactoryManager();
		private var _elementValidationManager	:ICascadeElementValidationManager	= new CascadeElementValidationManager();
		private var _ruleManager				:ICascadeRuleManager				= new CascadeRuleManager();
		
		public function CascadeManager()
		{
			if (_instance)
				ErrorUtil.throwSingletonInstantiated("CascadeManager");
			
			_instance = this;
		}
		
		public static function get instance():CascadeManager
		{
			if (!_instance)
				new CascadeManager();
			
			return _instance;
		}
		
		public function get parserManager():ICascadeParserManager
		{
			return _parserManager;
		}
		
		public function get styleFactoryManager():ICascadeStyleFactoryManager
		{
			return _styleFactoryManager;
		}
		
		public function get actionFactoryManager():ICascadeActionFactoryManager
		{
			return _actionFactoryManager;
		}
		
		public function get elementValidationManager():ICascadeElementValidationManager
		{
			return _elementValidationManager;
		}
		
		public function get ruleManager():ICascadeRuleManager
		{
			return _ruleManager;
		}
	}
}