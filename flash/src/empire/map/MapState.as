package empire.map
{
	import common.Model;
	
	import empire.province.ProvinceState;

	public class MapState extends Model
	{
		private var _provinces:Array = new Array();
		
		
		
		
		
		
		public function MapState(data:Object=null)
		{
			super();
			
			for (var i:int = 0; i < data.provinces.length; ++i)
				_provinces.push(new ProvinceState(data.provinces[i]));
		}
		
		public function get provinces():Array
		{
			return _provinces;
		}
	}
}