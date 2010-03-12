package
{
	import empire.game.Game;
	import empire.game.GameController;
	
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;
	
	import ui.IsothropicLayout;

	public class Frame extends UIComponent
	{
		public static const GAME_INFO_INITIAL:Object = {
			gameId			: "daspddpiapf",
			gameName		: "Empire Game",
			turnDuration	: 0,
			isStarted		: true,
			isJoined		: true,
			winnerIndex		: -1,
			turnCount		: 0,
			players			: [
				{
					memberId	: "YoGA"
				}, {
					memberId	: "NightMR"
				}, {
					memberId	: "Enotniy"
				}
			],
			
			mapWidth		: null,
			mapHeight		: null,
			landscape		: null,
			provinces		: null
		};
		
		public static const GAME_INFO_UPDATED:Object = {
			gameId			: "daspddpiapf",
			gameName		: "Empire Game",
			turnDuration	: 0,
			isStarted		: true,
			isJoined		: true,
			winnerIndex		: -1,
			turnCount		: 0,
			players			: [
				{
					memberId	: "YoGA"
				}, {
					memberId	: "NightMR"
				}, {
					memberId	: "Enotniy"
				}
			],
			
			mapWidth		: 10,
			mapHeight		: 10,
			landscape		: "/AAAA//////AAAAAA/////AAAAABBBCCCCAABBBBCCCC/BBBBB/CCC//BBBBCCCCDDDD//////DDDDD//////DDD/////DDDDD//",
			provinces		: [
				{
					nearProvinces	: [1, 2],
					income			: 1,
					recruits		: []
				}, {
					nearProvinces	: [0, 2],
					income			: 1,
					recruits		: []
				}, {
					nearProvinces	: [0, 1],
					income			: 1,
					recruits		: []
				}, {
					nearProvinces	: [2],
					income			: 1,
					recruits		: []
				}
			]
		};
		
		private static var _instance:Frame;
		
		private var _layout:IsothropicLayout;
		
		private var _game:Game;
		private var _gameController:GameController;
		
		private var _masterId:String;
		
		public function Frame()
		{
			super();
			
			_layout = new IsothropicLayout();
			
			addChild(_layout);
			
			Application.application.addEventListener(ResizeEvent.RESIZE, this.onAppResize);
		}
		
		public static function init():void
		{
			if (_instance)
				return;
			
			_instance = new Frame();
			
			_instance.openGame(GAME_INFO_INITIAL);
		}
		
		public static function get instance():Frame
		{
			init();
			return _instance;
		}
		
		public function get masterId():String
		{
			return _masterId;
		}
		
		public function setMasterId(masterId:String):void
		{
			_masterId = masterId;
		}
		
		public function openGame(data:Object):void
		{
			closeGame();
			
			_game = new Game(data);
			_gameController = new GameController(_game);
			_game.updateGameInfo(data);
			
			_layout.addChild(_gameController.gameView);
		}
		
		public function closeGame():void
		{
			if (!_gameController)
				return;
			
			_layout.removeChild(_gameController.gameView);
			
			_gameController.free();
			
			_game = null;
			_gameController = null;
		}
		
		public function doLayout():void
		{
			var w:Number = Application.application.width;
			var h:Number = Application.application.height;
			
			setActualSize(w, h);
			_layout.setActualSize(w, h);
			_layout.doLayout();
		}
		
		private function onAppResize(e:ResizeEvent):void
		{
			doLayout();
		}
	}
}