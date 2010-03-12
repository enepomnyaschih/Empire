package empire.province
{
	import common.IntPoint;
	import common.View;
	
	import empire.army.ArmyView;
	import empire.game.Game;
	import empire.game.GameUtil;
	import empire.map.Map;
	import empire.map.MapView;
	import empire.map.MapViewMetrics;
	
	import flash.geom.Point;
	
	import util.ColorUtil;
	import util.Dir6;
	import util.GraphicsUtil;

	public class ProvinceView extends View
	{
		private static const MAX_TRANSITION_PROGRESS:int = 80;
		
		private static const BORDER_WIDTH_COEF:Number = 0.3;
		
		private var _game:Game;
		private var _index:int;
		
		private var _cells:Array = new Array(); // of {x, y} objects
		private var _center:IntPoint = null;
		
		private var _turn:int = -1;
		
		private var _owner				:int = -1;
		private var _color				:uint;
		private var _transitionColor	:uint = 0;
		private var _transitionProgress	:uint = 0;
		
		private var _armyView:ArmyView;
		
		private var _metrics:MapViewMetrics;
		
		
		
		
		
		
		public function ProvinceView(game:Game, index:int, metrics:MapViewMetrics)
		{
			super();
			
			_game = game;
			_index = index;
			_color = GameUtil.getOwnerColor(_owner);
			
			_metrics = metrics;
			
			invalidateGraphics(); 
		}
		
		public function get game():Game
		{
			return _game;
		}
		
		public function get map():Map
		{
			return _game.map;
		}
		
		public function get province():Province
		{
			return map.provinces[_index];
		}
		
		public function get provinceState():ProvinceState
		{
			return _game.getProvinceState(_turn, _index);
		}
		
		public function addCell(x:int, y:int):void
		{
			_cells.push(new IntPoint(x, y));
			
			_center = null;
		}
		
		public function switchState(turn:int):void
		{
			_turn = turn;
			
			var state:ProvinceState = provinceState;
			switchOwner(state ? state.owner : -1);
			switchArmy(state);
			
			invalidateGraphics();
		}
		
		public function animate():void
		{
			if (_transitionProgress == 0)
				return;
			
			--_transitionProgress;
			
			var coef:Number = _transitionProgress / MAX_TRANSITION_PROGRESS;
			
			if (coef > 0.5)
				_color = ColorUtil.brightColor(_transitionColor, coef * 2 - 1);
			else
				_color = ColorUtil.brightColor(GameUtil.getOwnerColor(_owner), 1 - coef * 2);
			
			invalidateGraphics();
		}
		
		override public function validateGraphics():void
		{
			super.validateGraphics();
			
			validateCenter();
			
			graphics.clear();
			
			drawCells	(_color);
			drawBorders	(ColorUtil.darkColor(_color, 0.5));
		}
		
		private function drawCells(color:uint):void
		{
			for (var i:int = 0; i < _cells.length; ++i)
			{
				var point:Object = _cells[i];
				var x:int = point.x;
				var y:int = point.y;
				
				var cellPoint:Point = MapView.getCellCenter(x, y, _metrics);
				
				var x1:Number = cellPoint.x - _metrics.cellWidth  / 2;
				var y1:Number = cellPoint.y - _metrics.cellHeight / 2;
				var x2:Number = cellPoint.x + _metrics.cellWidth  / 2;
				var y2:Number = cellPoint.y + _metrics.cellHeight / 2;
				
				graphics.beginFill(color);
				GraphicsUtil.drawHexoid(graphics, x1, y1, x2, y2);
				graphics.endFill();
			}
		}
		
		private function drawBorders(color:uint):void
		{
			for (var i:int = 0; i < _cells.length; ++i)
			{
				var point:IntPoint = _cells[i];
				var x:int = point.x;
				var y:int = point.y;
				
				var cell:int = map.cells[x][y];
				
				var cellPoint:Point = MapView.getCellCenter(x, y, _metrics);
				
				var x1:Number = cellPoint.x - _metrics.cellWidth  / 2;
				var y1:Number = cellPoint.y - _metrics.cellHeight / 2;
				var x2:Number = cellPoint.x + _metrics.cellWidth  / 2;
				var y2:Number = cellPoint.y + _metrics.cellHeight / 2;
				
				for (var d:int = 0; d < 6; ++d)
				{
					var tx:int = Dir6.getTargetX(x, y, d);
					var ty:int = Dir6.getTargetY(x, y, d);
					
					if (tx >= 0 && tx < map.width  &&
						ty >= 0 && ty < map.height &&
						map.cells[tx][ty] == cell)
						continue;
					
					graphics.beginFill(color);
					GraphicsUtil.drawHexoidSegment(graphics, x1, y1, x2, y2, d, BORDER_WIDTH_COEF);
					graphics.endFill();
				}
			}
		}
		
		private function switchOwner(owner:int):void
		{
			if (owner == _owner)
				return;
			
			_owner = owner;
			_transitionColor = _color;
			_transitionProgress = MAX_TRANSITION_PROGRESS;
		}
		
		private function switchArmy(state:ProvinceState):void
		{
			if (_armyView)
				removeChild(_armyView);
			
			if (!state)
				return;
			
			var centerPoint:Point = MapView.getCellCenter(_center.x, _center.y, _metrics);
			
			_armyView = new ArmyView(state.units, state.fortLevel, state.fortHealth);
			_armyView.x = centerPoint.x;
			_armyView.y = centerPoint.y + 100;
			
			addChild(_armyView);
		}
		
		private function validateCenter():void
		{
			var cx:int = 0;
			var cy:int = 0;
			
			for (var i:int = 0; i < _cells.length; ++i)
			{
				cx += _cells[i].x;
				cy += _cells[i].y;
			}
			
			_center = new IntPoint(
				Math.round(cx / _cells.length),
				Math.round(cy / _cells.length)
			);
		}
	}
}