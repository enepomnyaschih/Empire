package empire.map
{
	import common.View;
	
	import empire.province.ProvinceView;

	public class MapView extends View
	{
		private static const MIN_MARGIN		:Number = 20;
		private static const CELL_WIDTH		:Number = 173.21; // 100 * sqrt(3)
		private static const CELL_HEIGHT	:Number = 120.00;
		
		private var _map:Map;
		
		private var _metrics:MapViewMetrics = new MapViewMetrics();
		
		private var _provinceViewContainer:View = new View();
		
		public function MapView(map:Map)
		{
			super();
			
			_map = map;
			
			addChild(_provinceViewContainer);
		}
		
		public function get map():Map
		{
			return _map;
		}
		
		public function get metrics():MapViewMetrics
		{
			return _metrics;
		}
		
		public function updateMetrics():void
		{
			_metrics.cellWidth	= CELL_WIDTH;
			_metrics.cellHeight	= CELL_HEIGHT;
			_metrics.marginLeft	= MIN_MARGIN;
			_metrics.marginTop	= MIN_MARGIN + CELL_HEIGHT / 6;
			
			width  = _metrics.cellWidth  * (_map.width  + 0.5) + 2 * MIN_MARGIN;
			height = _metrics.cellHeight * (_map.height + 1/3) + 2 * MIN_MARGIN;
		}
		
		public function addProvinceView(provinceView:ProvinceView):void
		{
			_provinceViewContainer.addChild(provinceView);
		}
	}
}