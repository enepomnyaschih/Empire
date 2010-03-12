package empire.map
{
	import common.Controller;
	
	import empire.province.ProvinceController;
	import empire.province.ProvinceControllerCollection;

	public class MapController extends Controller
	{
		private var _map:Map;
		
		private var _mapView:MapView;
		
		private var _provinceControllers:ProvinceControllerCollection = new ProvinceControllerCollection();
		
		public function MapController(map:Map)
		{
			super();
			
			_map = map;
			
			_mapView = new MapView(map);
			_mapView.updateMetrics();
			
			for (var i:int = 0; i < _map.provinces.length; ++i)
			{
				var provinceController:ProvinceController =
					new ProvinceController(_map, i, _mapView.metrics);
				
				_provinceControllers.addItem(provinceController);
				
				_mapView.addProvinceView(provinceController.provinceView);
			}
			
			for (var x:int = 0; x < _map.width; ++x)
			{
				for (var y:int = 0; y < _map.height; ++y)
				{
					var cell:int = _map.cells[x][y];
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
	}
}
