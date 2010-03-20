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
	import empire.province.ProvinceController;
	import empire.province.ProvinceSelectMouseTool;
	import empire.province.ProvinceView;
	import empire.provincescreen.ProvinceScreen;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.net.sendToURL;
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
			
			provinceScreen.addEventListener(ProvinceScreen.EVENT_MARCH_CLICKED, onMarchClicked, false, 0, true);
			provinceSelectMouseTool.addEventListener(ProvinceSelectMouseTool.EVENT_SELECTED, onProvinceSelected, false, 0, true);
			
			_orderAddedHandlers[MoveOrder .TYPE] = onMoveOrderAdded;
			_orderAddedHandlers[TrainOrder.TYPE] = onTrainOrderAdded;
			_orderAddedHandlers[BuildOrder.TYPE] = onBuildOrderAdded;
			
			_mainTicker.addEventListener(TimerEvent.TIMER, onTicker, false, 0, true);
			_mainTicker.start();
		}
		
		override public function free():void
		{
			super.free();
			
			_mainTicker.stop();
			
			provinceScreen.removeEventListener(ProvinceScreen.EVENT_MARCH_CLICKED, onMarchClicked);
			provinceSelectMouseTool.removeEventListener(ProvinceSelectMouseTool.EVENT_SELECTED, onProvinceSelected);
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
			clearMovement();
			
			_selectedProvince	= province;
			_selectedUnits		= units;
			
			if (province == -1)
			{
				_gameView.mouseSwitcher.status = "select";
				return;
			}
			
			_gameView.mouseSwitcher.status = "move";
			
			var commonSpeed:int = 0;
			for (var i:int = 0; i < GameUtil.UNIT_TYPE_COUNT; ++i)
			{
				if (!_selectedUnits[i])
					continue;
				
				if (commonSpeed > GameUtil.UNIT_TYPE_SPEED[i] || commonSpeed == 0)
					commonSpeed = GameUtil.UNIT_TYPE_SPEED[i];
			}
			
			setMovement(_selectedProvince, commonSpeed);
		}
		
		private function get provinceScreen():ProvinceScreen
		{
			return Frame.instance.provinceScreen;
		}
		
		private function get provinceSelectMouseTool():ProvinceSelectMouseTool
		{
			return Frame.instance.provinceSelectMouseTool;
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
								owner			: 0,
								units			: [1, 1, 0, 0, 0, 0, 0],
								fortLevel		: 0,
								fortHealth		: 0
							}, {
								owner			: 1,
								units			: [0, 0, 0, 0, 0, 0, 0],
								fortLevel		: 0,
								fortHealth		: 0
							}, {
								owner			: 1,
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
		
		private function onMarchClicked(e:Event):void
		{
			if (provinceScreen.game != _game)
				return;
			
			selectArmy(provinceScreen.province, provinceScreen.marchUnits);
		}
		
		private function setMovement(province:int, speed:int):void
		{
			var neighbours:Array = _game.getMapState(_turn).getNeighbours(province, speed);
			neighbours.sort();
			
			var neighbourIndex:int = 0;
			
			for (var i:int = 0; i < _game.map.provinces.length; ++i)
			{
				var provinceController:ProvinceController = _mapController.provinceControllers.getProvinceControllerAt(i);
				if (neighbourIndex == neighbours.length ||
					neighbours[neighbourIndex] != i)
				{
					provinceController.provinceView.darken = true;
					provinceController.provinceView.mouseWrapper.addStatus("far");
				}
				else
				{
					provinceController.provinceView.mouseWrapper.addStatus("near");
					++neighbourIndex;
				}
			}
		}
		
		private function clearMovement():void
		{
			for (var i:int = 0; i < _mapController.provinceControllers.length; ++i)
			{
				var provinceController:ProvinceController = _mapController.provinceControllers.getProvinceControllerAt(i);
				provinceController.provinceView.darken = false;
				provinceController.provinceView.mouseWrapper.removeStatus("near");
				provinceController.provinceView.mouseWrapper.removeStatus("far");
			}
		}
		
		private function onProvinceSelected(e:Event):void
		{
			var target:ProvinceView = provinceSelectMouseTool.target;
			if (target.game != _game)
				return;
			
			if (_selectedProvince == -1)
			{
				Frame.instance.provinceScreen.show(_game, _turn, target.provinceIndex);
				return;
			}
			
			_game.getState(_turn).sendMoveOrder(_selectedProvince, target.provinceIndex, _selectedUnits);
			selectArmy();
		}
	}
}