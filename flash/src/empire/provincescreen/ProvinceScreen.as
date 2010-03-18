package empire.provincescreen
{
	import common.mvc.View;
	
	import empire.game.Game;
	import empire.game.GameUtil;
	import empire.ordermodel.ProvinceOrderModel;
	import empire.province.ProvinceState;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.controls.Button;

	public class ProvinceScreen extends View
	{
		public static const EVENT_MARCH_CLICKED:String = "marchClicked";
		
		private var _game:Game;
		private var _turn:int = -1;
		private var _province:int = -1;
		
		private var _marchUnits:Array = null;
		
		private var _unitSelectBoxes:Array = new Array();
		private var _marchButton:Button;
		private var _closeButton:Button;
		
		public function ProvinceScreen()
		{
			super();
			
			width  = 800;
			height = 600;
			
			visible = false;
			
			for (var i:int = 0; i < GameUtil.UNIT_TYPE_COUNT; ++i)
			{
				var unitSelectBox:UnitSelectBox = new UnitSelectBox(i);
				unitSelectBox.x = 50;
				unitSelectBox.y = 50 + i * 60;
				
				_unitSelectBoxes.push(unitSelectBox);
				addChild(unitSelectBox);
			}
			
			_marchButton = new Button();
			_marchButton.label = "March";
			_marchButton.x = 50;
			_marchButton.y = 50 + GameUtil.UNIT_TYPE_COUNT * 60;
			_marchButton.addEventListener(MouseEvent.CLICK, onMarchClick, false, 0, true);
			
			addChild(_marchButton);
			
			_closeButton = new Button();
			_closeButton.label = "Close";
			_closeButton.x = 680;
			_closeButton.y = 50 + GameUtil.UNIT_TYPE_COUNT * 60;
			_closeButton.addEventListener(MouseEvent.CLICK, onCloseClick, false, 0, true);
			
			addChild(_closeButton);
		}
		
		public function get marchUnits():Array
		{
			return _marchUnits;
		}
		
		public function show(game:Game, turn:int, province:int):void
		{
			_game = game;
			_turn = turn;
			_province = province;
			
			var state:ProvinceState = _game.getProvinceState(turn, province);
			var orderModel:ProvinceOrderModel = _game.getProvinceOrderModel(turn, province);
			if (!state || !orderModel)
				return;
			
			for (var i:int = 0; i < GameUtil.UNIT_TYPE_COUNT; ++i)
			{
				var unitSelectBox:UnitSelectBox = _unitSelectBoxes[i];
				unitSelectBox.update(state.units[i] - orderModel.unitsLeft[i]);
			}
			
			visible = true;
		}
		
		public function hide():void
		{
			visible = false;
		}
		
		private function onMarchClick(e:MouseEvent):void
		{
			var count:int = 0;
			var units:Array = new Array(GameUtil.UNIT_TYPE_COUNT);
			for (var i:int = 0; i < GameUtil.UNIT_TYPE_COUNT; ++i)
			{
				var unitSelectBox:UnitSelectBox = _unitSelectBoxes[i];
				units[i] = unitSelectBox.value;
				count += units[i];
			}
			
			if (count == 0)
			{
				Alert.show("Select at least one unit to march.");
				return;
			}
			
			_marchUnits = units;
			
			dispatchEvent(new Event(EVENT_MARCH_CLICKED));
		}
		
		private function onCloseClick(e:MouseEvent):void
		{
			hide();
		}
	}
}