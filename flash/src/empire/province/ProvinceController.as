package empire.province
{
	import common.Controller;
	
	import empire.map.Map;
	import empire.map.MapViewMetrics;

	public class ProvinceController extends Controller
	{
		private var _map:Map;
		private var _index:int;
		
		private var _provinceView:ProvinceView;
		
		public function ProvinceController(map:Map, index:int, metrics:MapViewMetrics)
		{
			super();
			
			_map = map;
			_index = index;
			_provinceView = new ProvinceView(_map, _index, metrics);
		}
		
		public function get provinceView():ProvinceView
		{
			return _provinceView;
		}
		
		public function addCell(x:int, y:int):void
		{
			_provinceView.addCell(x, y);
		}
	}
}