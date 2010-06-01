package empire.map
{
	import com.geom.IntPoint;
	import com.mvc.Model;
	
	import empire.province.Province;
	
	import util.Base64;
	
	public class Map extends Model
	{
		private var _width:int;
		private var _height:int;
		
		private var _cells:Array;
		
		private var _provinces:Array = new Array();
		
		
		
		
		
		
		public function Map(data:Object)
		{
			super();
			
			_width	= data.mapWidth;
			_height	= data.mapHeight;
			
			var i:int;
			
			var centers	:Array = new Array(data.provinces.length);
			var counts	:Array = new Array(data.provinces.length);
			
			for (i = 0; i < data.provinces.length; ++i)
			{
				centers[i] = new IntPoint(0, 0);
				counts[i] = 0;
			}
			
			_cells	= new Array(_width);
			for (var x:int = 0; x < _width; ++x)
			{
				_cells[x] = new Array(_height);
				for (var y:int = 0; y < _height; ++y)
				{
					var char:String = data.landscape.charAt(x + y * _width);
					if (char == "/")
					{
						_cells[x][y] = -1;
						continue;
					}
					
					var index:int = Base64.instance.getBaseIndex(char);
					centers[index].x += x;
					centers[index].y += y;
					++counts[index];
					_cells[x][y] = index;
				}
			}
			
			for (i = 0; i < data.provinces.length; ++i)
			{
				_provinces.push(new Province(
					data.provinces[i],
					new IntPoint(
						Math.round(centers[i].x / counts[i]),
						Math.ceil (centers[i].y / counts[i])
					)
				));
			}
		}
		
		public function get width():int
		{
			return _width;
		}
		
		public function get height():int
		{
			return _height;
		}
		
		public function get cells():Array
		{
			return _cells;
		}
		
		public function get provinces():Array
		{
			return _provinces;
		}
	}
}