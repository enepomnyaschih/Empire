package empire.map
{
	import common.Controller;
	
	import empire.game.Game;
	import empire.province.ProvinceController;
	import empire.province.ProvinceControllerCollection;

	public class MapController extends Controller
	{
		private var _game:Game;
		
		private var _mapView:MapView;
		
		private var _provinceControllers:ProvinceControllerCollection = new ProvinceControllerCollection();
		
		public function MapController(game:Game)
		{
			super();
			
			_game = game;
			
			_mapView = new MapView(_game.map);
			_mapView.updateMetrics();
			
			for (var i:int = 0; i < _game.map.provinces.length; ++i)
			{
				var provinceController:ProvinceController =
					new ProvinceController(_game, i, _mapView.metrics);
				
				_provinceControllers.addItem(provinceController);
				
				_mapView.addProvinceView(provinceController.provinceView);
			}
			
			for (var x:int = 0; x < _game.map.width; ++x)
			{
				for (var y:int = 0; y < _game.map.height; ++y)
				{
					var cell:int = _game.map.cells[x][y];
					if (cell == -1)
						continue;
					
					_provinceControllers.getProvinceControllerAt(cell).addCell(x, y);
				}
			}
		}
		
		public function get mapView():MapView
		{
			return _mapView;
		}
		
		public function switchState(turn:int):void
		{
			for (var i:int = 0; i < _provinceControllers.length; ++i)
				_provinceControllers.getProvinceControllerAt(i).switchState(turn);
		}
		
		public function onTicker():void
		{
			for (var i:int = 0; i < _provinceControllers.length; ++i)
				_provinceControllers.getProvinceControllerAt(i).onTicker();
		}
	}
}
