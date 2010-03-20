package empire.game
{
	import common.mvc.Model;
	
	import empire.map.MapState;
	import empire.ordermodel.OrderModel;
	import empire.orders.MoveOrder;
	import empire.player.PlayerState;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.utils.UIDUtil;
	
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
			
			_map = new MapState(game.map, data);
			
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
		
		public function sendMoveOrder(provinceFrom:int, provinceTo:int, units:Array):void
		{
			var turn:int = _turn;
			
			var data:Object = {
				gameId			: _game.gameId,
				turn			: turn,
				provinceFrom	: provinceFrom,
				provinceTo		: provinceTo,
				units			: units
			};
			
			var request:URLRequest = Frame.instance.createRequest("IssueMoveOrder", data);
			var loader:URLLoader = new URLLoader();
			
			function onComplete(e:Event):void
			{
				if (turn != _turn)
					return;
				
				data.orderId = UIDUtil.createUID();
				_game.getState(_turn).orderModel.addOrder(new MoveOrder(data));
			}
			
//			loader.addEventListener(Event.COMPLETE, onComplete);
//			loader.load(request);
			
			onComplete(null);
		}
	}
}