package common.factory
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import util.ErrorUtil;
	
	public class FactoryManager extends EventDispatcher
	{
		public static const EVENT_FACTORY_REGISTERED:String = "factoryRegistered";
		
		private var _types:Array = new Array();
		private var _factories:Dictionary = new Dictionary();
		
		public function register(factory:Factory):void
		{
			if (_factories[factory.type])
				ErrorUtil.throwMsg("Factory '" + factory.type + "' is registered already");
			
			_factories[factory.type] = factory;
			_types.push(factory.type);
			
			dispatchEvent(new FactoryEvent(EVENT_FACTORY_REGISTERED, factory));
		}
		
		public function get types():Array
		{
			return _types;
		}
		
		public function getFactory(type:String):Factory
		{
			return _factories[type];
		}
	}
}