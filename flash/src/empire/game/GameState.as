package empire.game
{
	import common.mvc.Model;
	
	import empire.map.MapState;
	import empire.ordermodel.OrderModel;
	import empire.player.PlayerState;
	
	public class GameState extends Model
	{
		private var _game:Game;
		private var _turn:int;
		
		private var _winnerIndex:int;
		private var _players:Array = new Array();
		private var _map:MapState;
		
		private var _orderModel:OrderModel;
		
		
		
		
		
		
		public function GameState(game:Game, turn:int, data:Object)
		{
			super();
			
			_game = game;
			_turn = turn;
			
			_winnerIndex = data.winnerIndex;
			
			for (var i:int = 0; i < data.players.length; ++i)
				_players.push(new PlayerState(data.players[i]));
			
			_map = new MapState(data);
			
			_orderModel = new OrderModel(game, turn);
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
		
		public function get orderModel():OrderModel
		{
			return _orderModel;
		}
	}
}