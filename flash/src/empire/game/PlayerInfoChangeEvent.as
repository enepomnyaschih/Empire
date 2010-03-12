package empire.game
{
	import flash.events.Event;

	public class PlayerInfoChangeEvent extends Event
	{
		private var _index:int;
		
		public function PlayerInfoChangeEvent(type:String, index:int)
		{
			super(type);
			
			_index = index;
		}
		
		public function get index():int
		{
			return _index;
		}
		
		override public function clone():Event
		{
			return new PlayerInfoChangeEvent(type, index);
		}
	}
}