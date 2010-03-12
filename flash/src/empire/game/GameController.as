package empire.game
{
	import common.Controller;
	
	import empire.map.MapController;

	public class GameController extends Controller
	{
		private var _game:Game;
		private var _gameView:GameView;
		
		private var _mapController:MapController;
		
		public function GameController(game:Game)
		{
			super();
			
			_game = game;
			_gameView = new GameView(game);
			
			_mapController = new MapController(game.map);
			
			_gameView.addChild(_mapController.mapView);
			_gameView.width  = _mapController.mapView.initialWidth;
			_gameView.height = _mapController.mapView.initialHeight;
		}
		
		public function get gameView():GameView
		{
			return _gameView;
		}
	}
}