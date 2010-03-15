package empire.map
{
	import common.mvc.View;
	
	import empire.army.MarchView;
	import empire.province.ProvinceView;
	
	import flash.geom.Point;

	public class MapView extends View
	{
		private static const MARGIN_LEFT	:Number = 20;
		private static const MARGIN_RIGHT	:Number = 20;
		private static const MARGIN_TOP		:Number = 100;
		private static const MARGIN_BOTTOM	:Number = 20;
		
		private static const CELL_WIDTH		:Number = 173.21; // 100 * sqrt(3)
		private static const CELL_HEIGHT	:Number = 120.00;
		
		private var _map:Map;
		
		private var _metrics:MapViewMetrics = new MapViewMetrics();
		
		private var _provinceViewContainer:View = new View();
		private var _marchViewContainer:View = new View();
		
		public function MapView(map:Map)
		{
			super();
			
			_map = map;
			
			addChild(_provinceViewContainer);
			addChild(_marchViewContainer);
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
			_metrics.marginLeft	= MARGIN_LEFT;
			_metrics.marginTop	= MARGIN_TOP + CELL_HEIGHT / 6;
			
			width  = _metrics.cellWidth  * (_map.width  + 0.5) + MARGIN_LEFT + MARGIN_RIGHT;
			height = _metrics.cellHeight * (_map.height + 1/3) + MARGIN_TOP  + MARGIN_BOTTOM;
		}
		
		public function addProvinceView(provinceView:ProvinceView):void
		{
			_provinceViewContainer.addChild(provinceView);
		}
		
		public function addMarchView(marchView:MarchView):void
		{
			_marchViewContainer.addChild(marchView);
		}
		
		public static function getCellCenter(x:int, y:int, metrics:MapViewMetrics):Point
		{
			var dx:Number = (y % 2 == 0) ? (metrics.cellWidth / 2) : 0;
			
			return new Point(
				metrics.marginLeft + metrics.cellWidth  * (x + 0.5) + dx,
				metrics.marginTop  + metrics.cellHeight * (y + 0.5)
			);
		}
	}
}