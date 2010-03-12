package
{
	import common.ViewManager;
	
	import empire.game.Game;
	import empire.game.GameController;
	
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;
	
	import ui.IsothropicLayout;

	public class Frame extends UIComponent
	{
		private static var _instance:Frame;
		
		private var _layout:IsothropicLayout;
		
		private var _game:Game;
		private var _gameController:GameController;
		
		public function Frame()
		{
			super();
			
			_layout = new IsothropicLayout();
			
			addChild(_layout);
			
			_game = new Game({
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
			});
			
			_gameController = new GameController(_game);
			
			_layout.addChild(_gameController.gameView);
			
			ViewManager.instance.validateAllViewsGraphics();
			
			doLayout();
			
			Application.application.addEventListener(ResizeEvent.RESIZE, this.onAppResize);
		}
		
		public static function init():void
		{
			if (_instance)
				return;
			
			_instance = new Frame();
		}
		
		public static function get instance():Frame
		{
			init();
			return _instance;
		}
		
		public function doLayout():void
		{
			var w:Number = Application.application.width;
			var h:Number = Application.application.height;
			
			setActualSize(w, h);
			_layout.setActualSize(w, h);
		}
		
		private function onAppResize(e:ResizeEvent):void
		{
			doLayout();
		}
	}
}