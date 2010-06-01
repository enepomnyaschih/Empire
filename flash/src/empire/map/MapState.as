package empire.map
{
	import com.collections.Queue;
	import com.mvc.Model;
	
	import empire.province.Province;
	import empire.province.ProvinceState;

	public class MapState extends Model
	{
		private var _map:Map;
		private var _provinces:Array = new Array();
		
		
		
		
		
		
		public function MapState(map:Map, data:Object=null)
		{
			super();
			
			_map = map;
			
			for (var i:int = 0; i < data.provinces.length; ++i)
				_provinces.push(new ProvinceState(data.provinces[i]));
		}
		
		public function get provinces():Array
		{
			return _provinces;
		}
		
		public function getNeighbours(center:int, distance:int):Array
		{
			var result:Array = new Array();
			var labels:Array = new Array(_provinces.length);
			labels[center] = true;
			
			var q:Queue = new Queue();
			q.push({
				province	: center,
				distance	: 1
			});
			
			while (!q.empty)
			{
				var el:Object = q.pop();
				var province:Province = _map.provinces[el.province];
				var curDistance:int = el.distance;
				
				for (var i:int = 0; i < province.nearProvinces.length; ++i)
				{
					var index:int = province.nearProvinces[i];
					if (labels[index])
						continue;
					
					result.push(index);
					labels[index] = true;
					
					if (curDistance >= distance ||
						_provinces[index].owner != _provinces[center].owner)
						continue;
					
					q.push({
						province	: index,
						distance	: curDistance + 1
					});
				}
			}
			
			return result;
		}
	}
}