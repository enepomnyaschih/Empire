package
{
	import common.mouse.MouseManager;
	import common.mouse.MouseWrapper;
	
	import empire.game.Game;
	import empire.game.GameController;
	import empire.province.ProvinceSelectMouseTool;
	import empire.provincescreen.ProvinceScreen;
	
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;
	
	import ui.IsothropicLayout;
	import ui.Mask;

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
					income			: 2,
					recruits		: [6, 2]
				}, {
					nearProvinces	: [0, 3],
					income			: 1,
					recruits		: [3, 3, 4]
				}, {
					nearProvinces	: [0, 3],
					income			: 3,
					recruits		: [0]
				}, {
					nearProvinces	: [1, 2],
					income			: 2,
					recruits		: [1, 5]
				}
			]
		};
		
		private static var _instance:Frame;
		
		private var _mapLayout:IsothropicLayout;
		private var _mapMask:Mask;
		private var _provinceScreenLayout:IsothropicLayout;
		private var _provinceScreen:ProvinceScreen;
		
		private var _permanentMouseWrapper	:MouseWrapper;
		private var _frameMouseWrapper		:MouseWrapper;
		
		private var _game:Game;
		private var _gameController:GameController;
		
		private var _masterId:String;
		
		public function Frame()
		{
			super();
			
			initMouse();
			
			_mapLayout = new IsothropicLayout();
			_mapMask = new Mask();
			_provinceScreenLayout = new IsothropicLayout();
			_provinceScreen = new ProvinceScreen();
			
			addChild(_mapLayout);
			addChild(_mapMask);
			addChild(_provinceScreenLayout);
			
			_provinceScreenLayout.addChild(_provinceScreen);
			
			Application.application.addEventListener(ResizeEvent.RESIZE, this.onAppResize);
		}
		
		public static function init():void
		{
			if (_instance)
				return;
			
			_instance = new Frame();
			
			_instance.openGame(GAME_INFO_INITIAL);
			_instance.setMasterId("YoGA");
		}
		
		public static function get instance():Frame
		{
			init();
			return _instance;
		}
		
		public function get permanentMouseWrapper():MouseWrapper
		{
			return _permanentMouseWrapper;
		}
		
		public function get frameMouseWrapper():MouseWrapper
		{
			return _frameMouseWrapper;
		}
		
		public function get masterId():String
		{
			return _masterId;
		}
		
		public function get mapMask():Mask
		{
			return _mapMask;
		}
		
		public function get provinceScreen():ProvinceScreen
		{
			return _provinceScreen;
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
			
			_mapLayout.addChild(_gameController.gameView);
		}
		
		public function closeGame():void
		{
			if (!_gameController)
				return;
			
			_mapLayout.removeChild(_gameController.gameView);
			
			_gameController.free();
			
			_game = null;
			_gameController = null;
		}
		
		public function doLayout():void
		{
			var w:Number = Application.application.width;
			var h:Number = Application.application.height;
			
			setActualSize(w, h);
			_mapLayout.setActualSize(w, h);
			_mapLayout.doLayout();
			_mapMask.setActualSize(w, h);
			_provinceScreenLayout.setActualSize(w, h);
			_provinceScreenLayout.doLayout();
		}
		
		private function initMouse():void
		{
			_permanentMouseWrapper	= new MouseWrapper(null, "Permanent");
			_frameMouseWrapper		= new MouseWrapper(this, "Frame");
			
			MouseManager.instance.addRule("Game.select Province.own",	new ProvinceSelectMouseTool());
//			MouseManager.instance.addRule("Game.move Province.near",	new ArmyMoveMouseTool());
			
			_permanentMouseWrapper.activate();
		}
		
		private function onAppResize(e:ResizeEvent):void
		{
			doLayout();
		}
	}
}