package empire.game
{
	import common.Model;
	
	import empire.map.MapState;
	import empire.player.PlayerState;
	
	public class GameState extends Model
	{
		private var _winnerIndex:int;
		private var _players:Array = new Array();
		private var _map:MapState;
		
		
		
		
		
		
		public function GameState(data:Object)
		{
			super();
			
			_winnerIndex	= data.winnerIndex;
			
			for (var i:int = 0; i < data.players.length; ++i)
				_players.push(new PlayerState(data.players[i]));
			
			_map			= new MapState(data);
		}
		
		public function get winnerIndex():int
		{
			return _winnerIndex;
		}
		
		public function get players():Array
		{
			return _players;
		}
		
		public function get map():MapState
		{
			return _map;
		}
	}
}