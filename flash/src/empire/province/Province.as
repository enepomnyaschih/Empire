package empire.province
{
	import common.Collection;
	import common.Model;

	public class Province extends Model
	{
		private var _nearProvinces:Array;
		private var _income:int;
		private var _recruits:Array; // index - recruit number, value - unit type
		
		
		
		
		
		
		public function Province(data:Object = null)
		{
			super();
			
			_nearProvinces	= data.nearProvinces;
			_income			= data.income;
			_recruits		= data.recruits;
		}
		
		[Bindable]
		public function get nearProvinces():Array
		{
			return _nearProvinces;
		}
		
		public function set nearProvinces(value:Array):void
		{
			_nearProvinces = value;
		}
		
		[Bindable]
		public function get income():int
		{
			return _income;
		}
		
		public function set income(value:int):void
		{
			_income = value;
		}
		
		[Bindable]
		public function get recruits():Array
		{
			return _recruits;
		}
		
		public function set recruits(value:Array):void
		{
			_recruits = value;
		}
	}
}