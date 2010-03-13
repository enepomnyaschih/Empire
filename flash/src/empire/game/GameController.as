package empire.game
{
	import common.Controller;
	import common.ViewManager;
	
	import empire.map.MapController;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	
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
			_turn = turn;
			_mapController.switchState(turn);
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
			
			if (_tick % 120 == 0)
			{
				var state:GameState = new GameState({
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
							owner			: Math.floor(Math.random() * 16) - 1,
							units			: [3, 6, 9, 12, 15, 18, 21],
							fortLevel		: 2,
							fortHealth		: 250
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
						}, {
							owner			: Math.floor(Math.random() * 16) - 1,
							units			: [0, 0, 0, 0, 0, 0, 0],
							fortLevel		: 0,
							fortHealth		: 0
						}
					]
				});
				
				_game.setState(_turn + 1, state);
				
				switchState(_turn + 1);
			}
			
			if (_tick == 350)
			{
				Frame.instance.openGame(Frame.GAME_INFO_INITIAL);
			}
		}
	}
}