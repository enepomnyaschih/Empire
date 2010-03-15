package common.factory
{
	import flash.events.Event;

	public class FactoryEvent extends Event
	{
		private var _factory:Factory;
		
		public function FactoryEvent(type:String, factory:Factory)
		{
			super(type);
			_factory = factory;
		}
		
		public function get factory():Factory
		{
			return _factory;
		}
		
		override public function clone():Event
		{
			return new FactoryEvent(type, factory);
		}
	}
}