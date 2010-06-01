package empire.province
{
	import com.mvc.Model;

	public class ProvinceState extends Model
	{
		private var _owner:int;
		private var _units:Array;
		private var _fortLevel:int;
		private var _fortHealth:int;
		
		
		
		
		
		
		public function ProvinceState(data:Object)
		{
			super();
			
			_owner		= data.owner;
			_units		= data.units;
			_fortLevel	= data.fortLevel;
			_fortHealth	= data.fortHealth;
		}
		
		public function get owner():int
		{
			return _owner;
		}
		
		public function get units():Array
		{
			return _units;
		}
		
		public function get fortLevel():int
		{
			return _fortLevel;
		}
		
		public function get fortHealth():int
		{
			return _fortHealth;
		}
	}
}