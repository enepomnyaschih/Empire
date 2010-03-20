package empire.army
{
	import common.geom.IntPoint;
	import common.mvc.View;
	
	import empire.game.GameUtil;
	import empire.map.Map;
	import empire.map.MapView;
	import empire.map.MapViewMetrics;
	
	import flash.geom.Point;
	
	import util.ColorUtil;
	import util.GraphicsUtil;
	
	public class MarchView extends View
	{
		private var _map			:Map;
		private var _player			:int;
		private var _provinceFrom	:int;
		private var _provinceTo		:int;
		private var _units			:Array;
		private var _metrics		:MapViewMetrics;
		
		private var _armyView		:ArmyBoardView;
		
		public function MarchView(map:Map, player:int, provinceFrom:int, provinceTo:int, units:Array, metrics:MapViewMetrics)
		{
			super();
			
			alpha = 0.7;
			
			_map			= map;
			_player			= player;
			_provinceFrom	= provinceFrom;
			_provinceTo		= provinceTo;
			_units			= units;
			_metrics		= metrics;
			
			var c1:IntPoint = _map.provinces[_provinceFrom].getCenter();
			var c2:IntPoint = _map.provinces[_provinceTo  ].getCenter();
			
			var p1:Point = MapView.getCellCenter(c1.x, c1.y, _metrics);
			var p2:Point = MapView.getCellCenter(c2.x, c2.y, _metrics);
			
			drawArrow(p1, p2);
			drawArmy (p1, p2);
		}
		
		private function drawArrow(p1:Point, p2:Point):void
		{
			graphics.beginFill(ColorUtil.brightColor(GameUtil.getOwnerColor(_player), 0.3));
			GraphicsUtil.drawArrow(graphics, p1.x, p1.y, p2.x, p2.y);
			graphics.endFill();
		}
		
		private function drawArmy(p1:Point, p2:Point):void
		{
			_armyView = new ArmyBoardView(_units, null, null, 0, 0);
			_armyView.x = p1.x * 0.7 + p2.x * 0.3;
			_armyView.y = p1.y * 0.7 + p2.y * 0.3;
			
			addChild(_armyView);
		}
	}
}