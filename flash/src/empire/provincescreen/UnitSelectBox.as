package empire.provincescreen
{
	import empire.army.UnitView;
	import empire.resources.Resources;
	
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
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
				view.alpha = 0.5;
				
				_views.push(view);
				addChild(view);
			}
			
			setPreview(0);
		}
		
		private function setValue(value:int):void
		{
			var i:int;
			
			for (i = value; i < _value; ++i)
				_views[i].filters = [];
			
			for (i = _value; i < value; ++i)
			{
				var filter:GlowFilter = new GlowFilter();
				_views[i].filters = [filter];
			}
			
			_value = value;
		}
		
		private function setPreview(preview:int):void
		{
			var i:int;
			
			for (i = preview; i < _preview; ++i)
				_views[i].alpha = 0.5;
			
			for (i = _preview; i < preview; ++i)
				_views[i].alpha = 1.0;
			
			_preview = preview;
		}
		
		private function getUnitRollOverHandler(index:int):Function
		{
			return function(e:MouseEvent):void
			{
				setPreview(index + 1);
			}
		}
		
		private function getUnitRollOutHandler(index:int):Function
		{
			return function(e:MouseEvent):void
			{
				setPreview(1);
			}
		}
		
		private function getUnitClickHandler(index:int):Function
		{
			return function(e:MouseEvent):void
			{
				setValue(index);
			}
		}
	}
}