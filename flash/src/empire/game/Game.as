package empire.game
{
	import common.Model;
	
	import empire.map.Map;
	import empire.player.Player;
	
	public class Game extends Model
	{
		public static const EVENT_GAME_JOINED	:String = "gameJoined";
		public static const EVENT_GAME_STARTED	:String = "gameStarted";
		public static const EVENT_GAME_FINISHED	:String = "gameFinished";
		public static const EVENT_TURN_ADDED	:String = "turnAdded";
		
		
		
		
		
		
		private var _gameId			:String;
		private var _gameName		:String;
		private var _turnDuration	:int;
		
		private var _isStarted		:Boolean = false;
		private var _isJoined		:Boolean = false;
		
		private var _winnerIndex	:int;
		private var _turnCount		:int;
		
		private var _players		:Array;
		private var _map			:Map;
		
		private var _states			:Array = new Array();
		
		
		
		
		
		
		public function Game(data:Object)
		{
			super();
			
			_gameId			= data.gameId;
			_gameName		= data.gameName;
			_turnDuration	= data.turnDuration;
			
			_isStarted		= data.isStarted;
			_isJoined		= data.isJoined;
			
			_winnerIndex	= data.winnerIndex;
			_turnCount		= data.turnCount;
			
			_players		= new Array(data.players.length);
			
			for (var i:int = 0; i < data.players.length; ++i)
			{
				if (data.players[i])
					_players[i] = new Player(data.players[i]);
			}
			
			_map			= new Map(data);
		}
		
		public function get gameId():String
		{
			return _gameId;
		}
		
		public function get gameName():String
		{
			return _gameName;
		}
		
		public function get turnDuration():int
		{
			return _turnDuration;
		}
		
		public function get isStarted():Boolean
		{
			return _isStarted;
		}
		
		public function get isJoined():Boolean
		{
			return _isJoined;
		}
		
		public function get winnerIndex():int
		{
			return _winnerIndex;
		}
		
		public function get turnCount():int
		{
			return _turnCount;
		}
		
		public function get players():Array
		{
			return _players;
		}
		
		public function get map():Map
		{
			return _map;
		}
		
		public function get states():Array
		{
			return _states;
		}
	}
}