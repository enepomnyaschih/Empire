package empire.province
{
	import common.geom.IntPoint;
	import common.mouse.MouseWrapper;
	import common.mvc.View;
	
	import empire.army.ArmyBoardView;
	import empire.army.ProvinceBoardView;
	import empire.game.Game;
	import empire.game.GameUtil;
	import empire.map.Map;
	import empire.map.MapView;
	import empire.map.MapViewMetrics;
	import empire.ordermodel.ProvinceOrderModel;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import util.ColorUtil;
	import util.Dir6;
	import util.GraphicsUtil;

	public class ProvinceView extends View
	{
		private static const MAX_TRANSITION_PROGRESS:int = 80;
		private static const MAX_BLICK:int = 50;
		
		private static const BORDER_WIDTH_COEF:Number = 0.3;
		
		private var _game:Game;
		private var _index:int;
		
		private var _state:ProvinceState;
		private var _orderModel:ProvinceOrderModel;
		
		private var _cells:Array = new Array(); // of {x, y} objects
		
		private var _turn:int = -1;
		
		private var _owner				:int = -1;
		private var _color				:uint;
		private var _transitionColor	:uint = 0;
		private var _transitionProgress	:uint = 0;
		
		private var _isBlick:Boolean = false;
		private var _blick:int = 0;
		
		private var _boardView:ProvinceBoardView;
		private var _armyView:ArmyBoardView;
		
		private var _metrics:MapViewMetrics;
		
		private var _mouseWrapper:MouseWrapper;
		
		
		
		
		
		
		public function ProvinceView(game:Game, index:int, metrics:MapViewMetrics)
		{
			super();
			
			_game = game;
			_index = index;
			_color = GameUtil.getOwnerColor(_owner);
			
			_metrics = metrics;
			
			_mouseWrapper = new MouseWrapper(this, "Province");
			
			invalidateGraphics();
			
			addBoardView();
		}
		
		public function get game():Game
		{
			return _game;
		}
		
		public function get map():Map
		{
			return _game.map;
		}
		
		public function get provinceIndex():int
		{
			return _index;
		}
		
		public function get province():Province
		{
			return map.provinces[_index];
		}
		
		public function addCell(x:int, y:int):void
		{
			_cells.push(new IntPoint(x, y));
		}
		
		public function switchState(turn:int):void
		{
			_turn = turn;
			
			_state = _game.getProvinceState(_turn, _index);
			switchOwner();
			switchOrderModel();
			
			invalidateGraphics();
		}
		
		[Bindable]
		public function get isBlick():Boolean
		{
			return _isBlick;
		}
		
		public function set isBlick(value:Boolean):void
		{
			_isBlick = value;
		}
		
		override public function animate():void
		{
			if (_transitionProgress == 0 && !_isBlick && _blick == 0)
				return;
			
			if (_transitionProgress != 0)
				--_transitionProgress;
			
			if (_isBlick || _blick != 0)
				_blick = (_blick + 1) % MAX_BLICK;
			
			var coef:Number = _transitionProgress / MAX_TRANSITION_PROGRESS;
			
			if (coef > 0.5)
				_color = ColorUtil.brightColor(_transitionColor, coef * 2 - 1);
			else
				_color = ColorUtil.brightColor(GameUtil.getOwnerColor(_owner), 1 - coef * 2);
			
			_color = ColorUtil.brightColor(_color, Math.abs(2 * _blick / MAX_BLICK - 1));
			
			invalidateGraphics();
		}
		
		override public function validateGraphics():void
		{
			super.validateGraphics();
			
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
		
		private function switchOwner():void
		{
			var owner:int = _state ? _state.owner : -1;
			if (owner == _owner)
				return;
			
			freeOwner();
			
			_owner = owner;
			_transitionColor = _color;
			_transitionProgress = MAX_TRANSITION_PROGRESS;
			
			initOwner();
		}
		
		private function initOwner():void
		{
			var memberId:String = _game.getMemberId(_owner);
			if (memberId == null)
				return;
			
			if (memberId == Frame.instance.masterId)
			{
				_mouseWrapper.addStatus("own");
			}
			else
			{
				_mouseWrapper.addStatus("foe");
			}
		}
		
		private function freeOwner():void
		{
			_mouseWrapper.removeStatus("own");
			_mouseWrapper.removeStatus("foe");
		}
		
		private function switchOrderModel():void
		{
			var orderModel:ProvinceOrderModel = _game.getState(_turn).orderModel.provinces[_index];
			if (orderModel == _orderModel)
				return;
			
			freeOrderModel();
			_orderModel = orderModel;
			initOrderModel();
			
			switchArmy();
		}
		
		private function initOrderModel():void
		{
			if (!_orderModel)
				return;
			
			_orderModel.addEventListener(ProvinceOrderModel.EVENT_UNITS_LEFT,		onUnitsLeft,		false, 0, true);
			_orderModel.addEventListener(ProvinceOrderModel.EVENT_UNITS_CAME,		onUnitsCame,		false, 0, true);
			_orderModel.addEventListener(ProvinceOrderModel.EVENT_RECRUIT_TRAINED,	onRecruitTrained,	false, 0, true);
			_orderModel.addEventListener(ProvinceOrderModel.EVENT_FORT_BUILT,		onFortBuilt,		false, 0, true);
		}
		
		private function freeOrderModel():void
		{
			if (!_orderModel)
				return;
			
			_orderModel.removeEventListener(ProvinceOrderModel.EVENT_UNITS_LEFT,		onUnitsLeft);
			_orderModel.removeEventListener(ProvinceOrderModel.EVENT_UNITS_CAME,		onUnitsCame);
			_orderModel.removeEventListener(ProvinceOrderModel.EVENT_RECRUIT_TRAINED,	onRecruitTrained);
			_orderModel.removeEventListener(ProvinceOrderModel.EVENT_FORT_BUILT,		onFortBuilt);
		}
		
		private function switchArmy():void
		{
			if (_armyView)
				removeChild(_armyView);
			
			if (!_state || !_orderModel)
				return;
			
			var centerPoint:Point = MapView.getCellCenter(province.getCenter().x, province.getCenter().y, _metrics);
			
			_armyView = new ArmyBoardView(
				_state.units, _orderModel.unitsLeft, _orderModel.unitsCame,
				_state.fortLevel, _state.fortHealth);
			
			_armyView.x = centerPoint.x;
			_armyView.y = centerPoint.y - 50;
			
			addChild(_armyView);
		}
		
		private function addBoardView():void
		{
			var centerPoint:Point = MapView.getCellCenter(province.getCenter().x, province.getCenter().y, _metrics);
			
			_boardView = new ProvinceBoardView(province.income, province.recruits);
			_boardView.x = centerPoint.x;
			_boardView.y = centerPoint.y + 20;
			
			addChild(_boardView);
		}
		
		private function onUnitsLeft(e:Event):void
		{
			switchArmy();
		}
		
		private function onUnitsCame(e:Event):void
		{
			switchArmy();
		}
		
		private function onRecruitTrained(e:Event):void
		{
		}
		
		private function onFortBuilt(e:Event):void
		{
		}
	}
}