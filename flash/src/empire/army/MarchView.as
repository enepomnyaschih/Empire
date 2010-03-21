package empire.army
{
	import common.geom.IntPoint;
	import common.mvc.View;
	
	import empire.game.GameUtil;
	import empire.map.Map;
	import empire.map.MapView;
	import empire.map.MapViewMetrics;
	import empire.orders.MoveOrder;
	
	import flash.geom.Point;
	
	import util.ArrayUtil;
	import util.ColorUtil;
	
	public class MarchView extends View
	{
		private var _map			:Map;
		private var _player			:int;
		private var _orders			:Array = new Array();
		private var _metrics		:MapViewMetrics;
		
		private var _units			:Array;
		
		private var _arrowView		:ArrowView;
		private var _armyView		:ArmyBoardView;
		
		private var _center1		:Point;
		private var _center2		:Point;
		
		private var _opposite		:Boolean = false;
		
		public function MarchView(map:Map, player:int, order:MoveOrder, metrics:MapViewMetrics)
		{
			super();
			
			alpha = 0.7;
			
			_map			= map;
			_player			= player;
			_metrics		= metrics;
			
			_units = new Array(GameUtil.UNIT_TYPE_COUNT);
			for (var i:int = 0; i < GameUtil.UNIT_TYPE_COUNT; ++i)
				_units[i] = 0;
			
			var c1:IntPoint = _map.provinces[order.provinceFrom].getCenter();
			var c2:IntPoint = _map.provinces[order.provinceTo  ].getCenter();
			
			_center1 = MapView.getCellCenter(c1.x, c1.y, _metrics);
			_center2 = MapView.getCellCenter(c2.x, c2.y, _metrics);
			
			drawArrow();
			addOrder(order);
		}
		
		public function addOrder(order:MoveOrder):void
		{
			_orders.push(order);
			
			for (var i:int = 0; i < GameUtil.UNIT_TYPE_COUNT; ++i)
				_units[i] += order.units[i];
			
			drawArmy();
		}
		
		/**
		 * Returns true if no orders remaining and march must be destroyed.
		 */
		public function removeOrder(order:MoveOrder):Boolean
		{
			if (ArrayUtil.removeItem(_orders, order) == -1)
				return false;
			
			for (var i:int = 0; i < GameUtil.UNIT_TYPE_COUNT; ++i)
				_units[i] -= order.units[i];
			
			drawArmy();
			
			return _orders.length == 0;
		}
		
		[Bindable]
		public function get opposite():Boolean
		{
			return _opposite;
		}
		
		public function set opposite(value:Boolean):void
		{
			if (_opposite == value)
				return;
			
			_opposite = value;
			
			drawArrow();
			locateArmy();
		}
		
		private function drawArrow():void
		{
			if (_arrowView)
				removeChild(_arrowView);
			
			_arrowView = new ArrowView(ColorUtil.brightColor(GameUtil.getOwnerColor(_player), 0.3), 1.0, _center1, _center2, _opposite);
			addChildAt(_arrowView, 0);
		}
		
		private function drawArmy():void
		{
			if (_armyView)
				removeChild(_armyView);
			
			_armyView = new ArmyBoardView(_units, null, null, 0, 0);
			
			locateArmy();
			
			addChildAt(_armyView, 1);
		}
		
		private function locateArmy():void
		{
			_armyView.x = _center1.x * 0.7 + _center2.x * 0.3 - (_opposite ? 0.1 * (_center1.y - _center2.y) : 0);
			_armyView.y = _center1.y * 0.7 + _center2.y * 0.3 - (_opposite ? 0.1 * (_center2.x - _center1.x) : 0) + 10;
		}
	}
}