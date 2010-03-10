package game.province
{
	import common.Collection;
	import common.Model;

	public class Province extends Model
	{
		/**
		 * Static properties.
		 */
		private var _index:int;
		private var _nearProvinces:Collection = new Collection(); // of int
		private var _owner:int;
		private var _income:int;
		private var _recruits:Collection = new Collection(); // index - recruit undex, value - unit type
		
		/**
		 * Dynamic properties.
		 */
		private var _units:Collection = new Collection(); // index - unit type, value - count of units
		private var _fortLevel:int;
		private var _fortHealth:int;
		
		
		
		
		
		
		public function Province(index:int, data:Object = null)
		{
			super(data);
			
			this.index = index;
		}
		
		/**
		 * Static properties.
		 */
		[Bindable]
		public function get index():int
		{
			return _index;
		}
		
		public function set index(value:int):void
		{
			_index = value;
		}
		
		[Bindable]
		public function get nearProvinces():Array
		{
			return _nearProvinces.toArray();
		}
		
		public function set nearProvinces(value:Array):void
		{
			_nearProvinces.fillItems(value);
		}
		
		[Bindable]
		public function get owner():int
		{
			return _owner;
		}
		
		public function set owner(value:int):void
		{
			_owner = value;
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
			return _recruits.toArray();
		}
		
		public function set recruits(value:Array):void
		{
			_recruits.fillItems(value);
		}
		
		/**
		 * Dynamic properties.
		 */
		[Bindable]
		public function get units():Array
		{
			return _units.toArray();
		}
		
		public function set units(value:Array):void
		{
			_units.fillItems(value);
		}
		
		[Bindable]
		public function get fortLevel():int
		{
			return _fortLevel;
		}
		
		public function set fortLevel(value:int):void
		{
			_fortLevel = value;
		}
		
		[Bindable]
		public function get fortHealth():int
		{
			return _fortHealth;
		}
		
		public function set fortHealth(value:int):void
		{
			_fortHealth = value;
		}
		
		/**
		 * Special getters.
		 */
		public function getNearProvinces():Collection
		{
			return _nearProvinces;
		}
		
		public function getRecruits():Collection
		{
			return _recruits;
		}
		
		public function getUnits():Collection
		{
			return _units;
		}
	}
}