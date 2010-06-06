package com.cascade.stdparser.manager
{
	import com.cascade.base.managers.CascadeManager;
	import com.cascade.base.managers.ICascadeParserManager;
	import com.cascade.stdparser.bool.CascadeBooleanParser;
	import com.cascade.stdparser.color.CascadeColorParser;
	import com.cascade.stdparser.float.CascadeFloatParser;
	import com.cascade.stdparser.string.CascadeStringParser;
	import com.cascade.stdparser.uint.CascadeUIntParser;
	
	import flash.events.EventDispatcher;
	
	import util.ErrorUtil;

	public class CascadeStdParserManager extends EventDispatcher implements ICascadeStdParserManager
	{
		private static var _instance:CascadeStdParserManager;
		
		public function CascadeStdParserManager()
		{
			super();
			
			if (_instance)
				ErrorUtil.throwSingletonInstantiated("CascadeStdParserManager");
			
			var manager:ICascadeParserManager = CascadeManager.instance.parserManager;
			manager.register(new CascadeColorParser());
			manager.register(new CascadeFloatParser());
			manager.register(new CascadeStringParser());
			manager.register(new CascadeUIntParser());
			manager.register(new CascadeBooleanParser());
		}
		
		public static function get instance():CascadeStdParserManager
		{
			if (!_instance)
				new CascadeStdParserManager();
			
			return _instance;
		}
	}
}