package game.province
{
	import common.View;
	
	import game.game.GameUtil;
	import game.map.Map;
	import game.map.MapViewMetrics;
	
	import util.ColorUtil;
	import util.Dir6;
	import util.GraphicsUtil;

	public class ProvinceView extends View
	{
		private static const MAX_TRANSITION_PROGRESS:int = 100;
		
		private static const BORDER_WIDTH_COEF:Number = 0.3;
		
		private var _map:Map;
		private var _index:int;
		
		private var _cells:Array = new Array(); // of {x, y} objects
		
		private var _color				:uint;
		private var _transitionColor	:uint = 0;
		private var _transitionProgress	:uint = 0;
		
		private var _metrics:MapViewMetrics;
		
		
		
		
		
		
		public function ProvinceView(map:Map, index:int, metrics:MapViewMetrics)
		{
			super();
			
			_map = map;
			_index = index;
			_color = GameUtil.getOwnerColor(province.owner);
			
			_metrics = metrics;
			
			invalidateGraphics(); 
		}
		
		public function get province():Province
		{
			return _map.provinces.getProvinceAt(_index);
		}
		
		public function addCell(x:int, y:int):void
		{
			_cells.push({
				x: x,
				y: y
			});
		}
		
		public function beginColorTransition():void
		{
			_transitionColor = _color;
			_transitionProgress = MAX_TRANSITION_PROGRESS;
		}
		
		public function processColorTransition():void
		{
			if (_transitionProgress == 0)
				return;
			
			--_transitionProgress;
			invalidateGraphics();
		}
		
		override public function validateGraphics():void
		{
			super.validateGraphics();
			
			var province:Province = this.province;
			var owner:int = province.owner;
			
			var provinceColor:uint =
				(owner == -1) ? GameUtil.NEUTRAL_COLOR : GameUtil.PLAYER_COLORS[province.owner];
			
			var colorMain:uint = ColorUtil.averageColor(
				provinceColor, _transitionColor, _transitionProgress / MAX_TRANSITION_PROGRESS)
			
			var colorDark:uint = ColorUtil.darkColor(colorMain, 0.5);
			
			graphics.clear();
			
			drawCells	(colorMain);
			drawBorders	(colorDark);
		}
		
		private function drawCells(color:uint):void
		{
			for (var i:int = 0; i < _cells.length; ++i)
			{
				var point:Object = _cells[i];
				var x:int = point.x;
				var y:int = point.y;
				
				var dx:Number = (y % 2 == 0) ? (_metrics.cellWidth / 2) : 0;
				
				var x1:Number = _metrics.marginLeft	+ _metrics.cellWidth	* x + dx;
				var y1:Number = _metrics.marginTop	+ _metrics.cellHeight	* y;
				var x2:Number = x1 + _metrics.cellWidth;
				var y2:Number = y1 + _metrics.cellHeight;
				
				graphics.beginFill(color);
				GraphicsUtil.drawHexoid(graphics, x1, y1, x2, y2);
				graphics.endFill();
			}
		}
		
		private function drawBorders(color:uint):void
		{
			
			for (var i:int = 0; i < _cells.length; ++i)
			{
				var point:Object = _cells[i];
				var x:int = point.x;
				var y:int = point.y;
				
				var cell:int = _map.getCell(x, y);
				
				var dx:Number = (y % 2 == 0) ? (_metrics.cellWidth / 2) : 0;
				
				var x1:Number = _metrics.marginLeft	+ _metrics.cellWidth	* x + dx;
				var y1:Number = _metrics.marginTop	+ _metrics.cellHeight	* y;
				var x2:Number = x1 + _metrics.cellWidth;
				var y2:Number = y1 + _metrics.cellHeight;
				
				for (var d:int = 0; d < 6; ++d)
				{
					var tx:int = Dir6.getTargetX(x, y, d);
					var ty:int = Dir6.getTargetY(x, y, d);
					
					if (tx >= 0 && tx < _map.width  &&
						ty >= 0 && ty < _map.height &&
						_map.getCell(tx, ty) == cell)
						continue;
					
					graphics.beginFill(color);
					GraphicsUtil.drawHexoidSegment(graphics, x1, y1, x2, y2, d, BORDER_WIDTH_COEF);
					graphics.endFill();
				}
			}
		}
	}
}