package empire.game
{
	import com.mvc.Model;
	
	import empire.map.Map;
	import empire.map.MapState;
	import empire.ordermodel.ProvinceOrderModel;
	import empire.player.Player;
	import empire.province.ProvinceState;
	
	import flash.events.Event;
	
	import util.ArrayUtil;
	
	public class Game extends Model
	{
		public static const EVENT_PLAYER_JOINED	:String = "playerJoined";
		public static const EVENT_PLAYER_LEFT	:String = "playerLeft";
		public static const EVENT_MAP_GENERATED	:String = "mapGenerated";
		public static const EVENT_GAME_JOINED	:String = "gameJoined";
		public static const EVENT_GAME_STARTED	:String = "gameStarted";
		public static const EVENT_GAME_FINISHED	:String = "gameFinished";
		
		
		
		
		
		
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
			_turnCount		= data.turnCount;
			
			_players		= new Array(data.players.length);
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
		
		public function setState(turn:int, state:GameState):void
		{
			if (_turnCount < turn + 1)
				_turnCount = turn + 1;
			
			ArrayUtil.lng(_states, turn + 1);
			_states[turn] = state;
		}
		
		public function getState(turn:int):GameState
		{
			if (turn < 0 || turn >= _states.length)
				return null;
			
			return _states[turn];
		}
		
		public function getMapState(turn:int):MapState
		{
			var gameState:GameState = getState(turn);
			if (!gameState)
				return null;
			
			return gameState.map;
		}
		
		public function getProvinceState(turn:int, provinceIndex:int):ProvinceState
		{
			var mapState:MapState = getMapState(turn);
			if (!mapState)
				return null;
			
			return mapState.provinces[provinceIndex];
		}
		
		public function getProvinceOrderModel(turn:int, provinceIndex:int):ProvinceOrderModel
		{
			var gameState:GameState = getState(turn);
			if (!gameState)
				return null;
			
			return gameState.orderModel.provinces[provinceIndex];
		}
		
		public function updateGameInfo(data:Object):void
		{
			var events:Array = new Array();
			var i:int;
			
			for (i = 0; i < _players.length; ++i)
			{
				if (_players[i])
				{
					if (data.players[i] && (data.players[i].memberId == _players[i].memberId))
						continue;
					
					_players[i] = null;
					events.push(new PlayerInfoChangeEvent(EVENT_PLAYER_LEFT, i));
				}
				
				if (data.players[i])
				{
					_players[i] = new Player(data.players[i]);
					events.push(new PlayerInfoChangeEvent(EVENT_PLAYER_JOINED, i));
				}
			}
			
			if (!map && data.landscape)
			{
				_map = new Map(data);
				events.push(new Event(EVENT_MAP_GENERATED));
			}
			
			if (!_isJoined && data.isJoined)
			{
				_isJoined = true;
				events.push(new Event(EVENT_GAME_JOINED));
			}
			
			if (!_isStarted && data.isStarted)
			{
				_isStarted = true;
				events.push(new Event(EVENT_GAME_STARTED));
			}
			
			if (_winnerIndex == -1 && data.winnerIndex != -1)
			{
				_winnerIndex = data.winnerIndex;
				events.push(new Event(EVENT_GAME_FINISHED));
			}
			
			for (i = 0; i < events.length; ++i)
				dispatchEvent(events[i]);
		}
		
		public function getMemberId(slot:int):String
		{
			if (slot == -1)
				return null;
			
			var player:Player = _players[slot];
			if (!player)
				return null;
			
			return player.memberId;
		}
	}
}