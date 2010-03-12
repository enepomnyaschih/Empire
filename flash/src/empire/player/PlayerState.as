package empire.player
{
	import common.Model;

	public class PlayerState extends Model
	{
		private var _alive:Boolean;
		private var _gold:Boolean;
		
		
		
		
		
		
		public function PlayerState(data:Object)
		{
			super();
			
			_alive	= data.alive;
			_gold	= data.gold;
		}
		
		public function get alive():Boolean
		{
			return _alive;
		}
		
		public function get gold():Boolean
		{
			return _gold;
		}
	}
}