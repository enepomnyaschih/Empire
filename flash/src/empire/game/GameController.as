package empire.game
{
	import common.mvc.Controller;
	import common.mvc.ViewManager;
	
	import empire.army.MarchView;
	import empire.map.MapController;
	import empire.ordermodel.OrderModel;
	import empire.orders.BuildOrder;
	import empire.orders.MoveOrder;
	import empire.orders.OrderEvent;
	import empire.orders.TrainOrder;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	
	import util.Ticker;

	public class GameController extends Controller
	{
		public static const MAIN_MS_PERIOD:Number = 20;
		
		private var _game:Game;
		private var _gameView:GameView;
		
		private var _mapController:MapController;
		
		private var _turn:int = -1;
		
		private var _mainTicker:Ticker = new Ticker(MAIN_MS_PERIOD);
		private var _tick:int = 0;
		
		private var _orderAddedHandlers:Dictionary = new Dictionary();
		
		private var _selectedProvince:int = -1;
		private var _selectedUnits:Array = null;
		
		public function GameController(game:Game)
		{
			super();
			
			_game = game;
			_gameView = new GameView(game);
			
			_game.addEventListener(Game.EVENT_GAME_JOINED,		onGameJoined,	false, 0, true);
			_game.addEventListener(Game.EVENT_GAME_STARTED,		onGameStarted,	false, 0, true);
			_game.addEventListener(Game.EVENT_GAME_FINISHED,	onGameFinished,	false, 0, true);
			_game.addEventListener(Game.EVENT_MAP_GENERATED,	onMapGenerated,	false, 0, true);
			_game.addEventListener(Game.EVENT_PLAYER_JOINED,	onPlayerJoined,	false, 0, true);
			_game.addEventListener(Game.EVENT_PLAYER_LEFT,		onPlayerLeft,	false, 0, true);
			
			_mainTicker.addEventListener(TimerEvent.TIMER, onTicker, false, 0, true);
			_mainTicker.start();
			
			_orderAddedHandlers[MoveOrder .TYPE] = onMoveOrderAdded;
			_orderAddedHandlers[TrainOrder.TYPE] = onTrainOrderAdded;
			_orderAddedHandlers[BuildOrder.TYPE] = onBuildOrderAdded;
		}
		
		override public function free():void
		{
			super.free();
			
			_mainTicker.stop();
		}
		
		public function get gameView():GameView
		{
			return _gameView;
		}
		
		public function switchState(turn:int):void
		{
			freeOrderModel();
			
			_turn = turn;
			_mapController.switchState(turn);
			_gameView.mouseSwitcher.status = "select";
			
			initOrderModel();
		}
		
		public function openProvinceScreen(province:int):void
		{
		}
		
		public function selectArmy(province:int = -1, units:Array = null):void
		{
			_selectedProvince = province;
			_selectedUnits = units;
			
			_gameView.mouseSwitcher.status = (province == -1) ? "select" : "move";
		}
		
		private function onGameJoined(e:Event):void
		{
		}
		
		private function onGameStarted(e:Event):void
		{
		}
		
		private function onGameFinished(e:Event):void
		{
		}
		
		private function onMapGenerated(e:Event):void
		{
			_mapController = new MapController(_game);
			
			_gameView.addChild(_mapController.mapView);
			_gameView.width  = _mapController.mapView.initialWidth;
			_gameView.height = _mapController.mapView.initialHeight;
			
			Frame.instance.doLayout();
		}
		
		private function onPlayerJoined(e:PlayerInfoChangeEvent):void
		{
		}
		
		private function onPlayerLeft(e:PlayerInfoChangeEvent):void
		{
		}
		
		private function onTicker(e:TimerEvent):void
		{
			if (_mapController)
				_mapController.onTicker();
			
			ViewManager.instance.validateAllViewsGraphics();
			ViewManager.instance.validateAllViewsPosition();
			
			++_tick;
			
			if (_tick == 60)
			{
				_game.updateGameInfo(Frame.GAME_INFO_UPDATED);
			}
			
			if (_tick == 120)
			{
				var state:GameState = new GameState(
					_game,
					_tick / 120 - 1,
					{
						winnerIndex	: -1,
						players		: [
							{
								alive		: true,
								gold		: 5
							}, {
								alive		: true,
								gold		: 5
							}, {
								alive		: true,
								gold		: 5
							}
						],
						provinces	: [
							{
								owner			: 0,
								units			: [3, 6, 9, 12, 15, 18, 21],
								fortLevel		: 2,
								fortHealth		: 250
							}, {
								owner			: Math.floor(Math.random() * 16) - 1,
								units			: [1, 1, 0, 0, 0, 0, 0],
								fortLevel		: 0,
								fortHealth		: 0
							}, {
								owner			: Math.floor(Math.random() * 16) - 1,
								units			: [0, 0, 0, 0, 0, 0, 0],
								fortLevel		: 0,
								fortHealth		: 0
							}, {
								owner			: Math.floor(Math.random() * 16) - 1,
								units			: [0, 0, 0, 0, 0, 0, 0],
								fortLevel		: 0,
								fortHealth		: 0
							}
						]
					}
				);
				
				_game.setState(_turn + 1, state);
				
				switchState(_turn + 1);
			}
			
/*			if (_tick == 160)
			{
				_game.getState(_turn).orderModel.addOrder(new MoveOrder({
					provinceFrom	: 0,
					provinceTo		: 1,
					units			: [3, 4, 3, 5, 3, 4, 5]
				}));
			}
			
			if (_tick == 500)
			{
				Frame.instance.openGame(Frame.GAME_INFO_INITIAL);
			}
*/		}
		
		private function initOrderModel():void
		{
			var state:GameState = _game.getState(_turn);
			if (!state)
				return;
			
			var orderModel:OrderModel = state.orderModel;
			
			orderModel.addEventListener(OrderModel.EVENT_ORDER_ADDED, onOrderAdded, false, 0, true);
		}
		
		private function freeOrderModel():void
		{
			var state:GameState = _game.getState(_turn);
			if (!state)
				return;
			
			var orderModel:OrderModel = state.orderModel;
			
			orderModel.removeEventListener(OrderModel.EVENT_ORDER_ADDED, onOrderAdded);
		}
		
		private function onOrderAdded(e:OrderEvent):void
		{
			var handler:Function = _orderAddedHandlers[e.order.type];
			if (handler != null)
				handler(e.order);
		}
		
		private function onMoveOrderAdded(order:MoveOrder):void
		{
			_mapController.mapView.addMarchView(new MarchView(
				_game.map, _game.getProvinceState(_turn, order.provinceFrom).owner,
				order.provinceFrom, order.provinceTo, order.units, _mapController.mapView.metrics));
		}
		
		private function onTrainOrderAdded(order:TrainOrder):void
		{
		}
		
		private function onBuildOrderAdded(order:BuildOrder):void
		{
		}
	}
}