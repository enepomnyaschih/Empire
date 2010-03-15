package empire.ordermodel
{
	import common.mvc.Model;
	
	import empire.game.Game;
	import empire.game.GameUtil;
	import empire.province.Province;
	
	import flash.events.Event;

	public class ProvinceOrderModel extends Model
	{
		public static const EVENT_UNITS_LEFT		:String = "unitsLeft";
		public static const EVENT_UNITS_CAME		:String = "unitsCame";
		public static const EVENT_RECRUIT_TRAINED	:String = "recruitTrained";
		public static const EVENT_FORT_BUILT		:String = "fortBuilt";
		
		private var _game				:Game;
		private var _provinceIndex		:int;
		private var _turn				:int;
		
		private var _unitsLeft			:Array = new Array(GameUtil.UNIT_TYPE_COUNT);
		private var _unitsCame			:Array = new Array(GameUtil.UNIT_TYPE_COUNT);
		private var _recruitsTrained	:Array; // index - recruits index, value - true/false
		private var _fortBuilt			:Boolean = false;
		
		public function ProvinceOrderModel(game:Game, provinceIndex:int, turn:int)
		{
			super();
			
			_game = game;
			_provinceIndex = provinceIndex;
			_turn = turn;
			
			var province:Province = this.province;
			var i:int;
			
			for (i = 0; i < GameUtil.UNIT_TYPE_COUNT; ++i)
			{
				_unitsLeft[i] = 0;
				_unitsCame[i] = 0;
			}
			
			_recruitsTrained = new Array(province.recruits.length);
			for (i = 0; i < province.recruits.length; ++i)
				_recruitsTrained[i] = false;
		}
		
		public function get province():Province
		{
			return _game.map.provinces[_provinceIndex];
		}
		
		public function get unitsLeft():Array
		{
			return _unitsLeft;
		}
		
		public function get unitsCame():Array
		{
			return _unitsCame;
		}
		
		public function get recruitsTrained():Array
		{
			return _recruitsTrained;
		}
		
		public function get fortBuilt():Boolean
		{
			return _fortBuilt;
		}
		
		public function leaveUnits(units:Array):void
		{
			for (var i:int = 0; i < GameUtil.UNIT_TYPE_COUNT; ++i)
				_unitsLeft[i] += units[i];
			
			dispatchEvent(new Event(EVENT_UNITS_LEFT));
		}
		
		public function comeUnits(units:Array):void
		{
			for (var i:int = 0; i < GameUtil.UNIT_TYPE_COUNT; ++i)
				_unitsCame[i] += units[i];
			
			dispatchEvent(new Event(EVENT_UNITS_CAME));
		}
		
		public function trainRecruit(index:int):void
		{
			_recruitsTrained[index] = true;
			
			dispatchEvent(new Event(EVENT_RECRUIT_TRAINED));
		}
		
		public function buildFort():void
		{
			_fortBuilt = true;
			
			dispatchEvent(new Event(EVENT_FORT_BUILT));
		}
	}
}