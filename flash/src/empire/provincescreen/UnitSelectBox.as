package empire.provincescreen
{
	import common.mvc.View;
	
	import empire.army.UnitView;
	import empire.resources.Resources;
	
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	import util.ColorUtil;
	
	public class UnitSelectBox extends UnitBox
	{
		private var _unitType	:int;
		private var _count		:int;
		private var _left		:int;
		
		private var _views		:Array;
		
		private var _value		:int;
		private var _preview	:int;
		
		public function UnitSelectBox(unitType:int)
		{
			super();
			
			_unitType = unitType;
			
			update(0);
		}
		
		public function get value():int
		{
			return _value;
		}
		
		public function update(count:int):void
		{
			_count = count;
			_value = 0;
			_preview = 0;
			
			removeAllChildren();
			
			_views = new Array(count);
			
			for (var i:int = 0; i <= _count; ++i)
			{
				var imageCls:Class = (i == 0) ? Resources.CANCEL : Resources.UNITS[_unitType];
				var view:UnitView = new UnitView(imageCls, 0, 0, 0, 0);
				
				view.addEventListener(MouseEvent.ROLL_OVER, getUnitRollOverHandler(i), false, 0, true);
				view.addEventListener(MouseEvent.ROLL_OUT,  getUnitRollOutHandler (i), false, 0, true);
				view.addEventListener(MouseEvent.CLICK,     getUnitClickHandler   (i), false, 0, true);
				view.alpha = (i == 0) ? 1.0 : 0.5;
				
				_views[i] = view;
				addItem(view);
			}
		}
		
		private function setValue(value:int):void
		{
			if (value == _value)
				return;
			
			_value = value;
			
			updateViews();
		}
		
		private function setPreview(preview:int):void
		{
			if (preview == _preview)
				return;
			
			_preview = preview;
			
			updateViews();
		}
		
		private function getUnitRollOverHandler(index:int):Function
		{
			return function(e:MouseEvent):void
			{
				setPreview(index);
			}
		}
		
		private function getUnitRollOutHandler(index:int):Function
		{
			return function(e:MouseEvent):void
			{
				setPreview(0);
			}
		}
		
		private function getUnitClickHandler(index:int):Function
		{
			return function(e:MouseEvent):void
			{
				setValue(index);
			}
		}
		
		private function updateViews():void
		{
			for (var i:int = 0; i < _count; ++i)
			{
				var view:View = _views[i + 1];
				var isAlpha :Boolean = _value > i;
				var isFilter:Boolean = _preview > i;
				
				view.alpha = isAlpha ? 1.0 : 0.5;
				view.filters = isFilter ? [ new GlowFilter(ColorUtil.WHITE, 1, 12, 12) ] : [];
			}
		}
	}
}