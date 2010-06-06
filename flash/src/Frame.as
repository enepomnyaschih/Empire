package
{
	import com.cascade.base.element.base.CascadeElement;
	import com.cascade.base.element.base.ICascadeElement;
	import com.cascade.base.element.mouse.CascadeMouseElement;
	import com.cascade.base.loader.CascadeLoader;
	import com.cascade.base.loader.CascadeLoaderEvent;
	import com.cascade.base.loader.ICascadeLoader;
	import com.cascade.base.managers.CascadeManager;
	import com.cascade.mouse.managers.MouseManager;
	import com.cascade.visual.manager.CascadeVisualManager;
	
	import empire.effects.blink.BlinkEffectActionFactory;
	import empire.effects.blink.BlinkEffectStyleFactory;
	import empire.effects.darken.DarkenEffectActionFactory;
	import empire.effects.darken.DarkenEffectStyleFactory;
	import empire.game.Game;
	import empire.game.GameController;
	import empire.province.ProvinceDeselectMouseToolFactory;
	import empire.province.ProvinceSelectMouseToolFactory;
	import empire.provincescreen.ProvinceScreen;
	
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;
	
	import ui.IsothropicLayout;
	import ui.Mask;
	
	import util.ErrorUtil;

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
		
		private var _permanentCascadeElement	:ICascadeElement;
		private var _frameCascadeElement		:ICascadeElement;
		
		private var _game:Game;
		private var _gameController:GameController;
		
		private var _masterId:String;
		private var _baseUrl:String;
		
		private var _cssLoader:ICascadeLoader;
		
		private var _broadcaster:EventDispatcher = new EventDispatcher();
		
		public function Frame()
		{
			super();
			
			if (_instance)
				ErrorUtil.throwSingletonInstantiated("Frame");
			
			_instance = this;
			
			initMouse();
			initCss();
			loadCss();
		}
		
		public static function get instance():Frame
		{
			if (!_instance)
				new Frame();
			
			return _instance;
		}
		
		public function get permanentCascadeElement():ICascadeElement
		{
			return _permanentCascadeElement;
		}
		
		public function get frameCascadeElement():ICascadeElement
		{
			return _frameCascadeElement;
		}
		
		public function get masterId():String
		{
			return _masterId;
		}
		
		public function get baseUrl():String
		{
			return _baseUrl;
		}
		
		public function get mapMask():Mask
		{
			return _mapMask;
		}
		
		public function get provinceScreen():ProvinceScreen
		{
			return _provinceScreen;
		}
		
		public function get broadcaster():EventDispatcher
		{
			return _broadcaster;
		}
		
		public function start(masterId:String, baseUrl:String):void
		{
			_masterId	= masterId;
			_baseUrl	= baseUrl;
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
			
			graphics.clear();
			graphics.beginFill(0, 0);
			graphics.drawRect(0, 0, w, h);
			graphics.endFill();
		}
		
		public function createRequest(action:String, data:Object):URLRequest
		{
			var result:URLRequest = new URLRequest(_baseUrl + action);
			result.data = data;
			return result;
		}
		
		private function initMouse():void
		{
			MouseManager.instance.mouseToolFactoryManager.register(new ProvinceSelectMouseToolFactory());
			MouseManager.instance.mouseToolFactoryManager.register(new ProvinceDeselectMouseToolFactory());
		}
		
		private function initCss():void
		{
			CascadeVisualManager.instance;
			
			CascadeManager.instance.actionFactoryManager.register(new BlinkEffectActionFactory());
			CascadeManager.instance.styleFactoryManager .register(new BlinkEffectStyleFactory());
			
			CascadeManager.instance.actionFactoryManager.register(new DarkenEffectActionFactory());
			CascadeManager.instance.styleFactoryManager .register(new DarkenEffectStyleFactory());
		}
		
		private function loadCss():void
		{
			var request:URLRequest = new URLRequest("Empire.css");
			request.method = "GET";
			
			_cssLoader = new CascadeLoader();
			_cssLoader.addEventListener(CascadeLoaderEvent.SUCCESS, onCssLoadSuccess, false, 0, true);
			_cssLoader.addEventListener(CascadeLoaderEvent.FAILURE, onCssLoadFailure, false, 0, true);
			_cssLoader.load(request);
		}
		
//		public var cce:ICascadeElement;
		
		private function onCssLoadSuccess(e:CascadeLoaderEvent):void
		{
			_permanentCascadeElement	= new CascadeElement(this, "Permanent");
			_frameCascadeElement		= new CascadeMouseElement(this, "Frame");
			
/*			var ccc:Canvas = new Canvas();
			ccc.width = 100;
			ccc.height = 100;
			
			cce = new CascadeMouseElement(ccc, "ccc");
			_frameCascadeElement.addChild(cce);
			addChild(ccc);
*/			
			_permanentCascadeElement.isHover = true;
			_permanentCascadeElement.addChild(_frameCascadeElement);
			
			_mapLayout = new IsothropicLayout();
			_mapMask = new Mask();
			_provinceScreenLayout = new IsothropicLayout();
			_provinceScreen = new ProvinceScreen();
			
			addChild(_mapLayout);
			addChild(_mapMask);
			addChild(_provinceScreenLayout);
			
			_provinceScreenLayout.addChild(_provinceScreen);
			
			Application.application.addEventListener(ResizeEvent.RESIZE, this.onAppResize);
			
			openGame(GAME_INFO_INITIAL);
			start("YoGA", "http://localhost");
		}
		
		private function onCssLoadFailure(e:CascadeLoaderEvent):void
		{
			Alert.show(e.message);
		}
		
		private function onAppResize(e:ResizeEvent):void
		{
			doLayout();
		}
	}
}