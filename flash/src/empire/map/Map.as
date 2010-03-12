package empire.map
{
	import common.Model;
	
	import empire.province.Province;
	import empire.province.ProvinceCollection;
	
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
			
			_cells	= new Array(_width);
			for (var x:int = 0; x < _width; ++x)
			{
				_cells[x] = new Array(_height);
				for (var y:int = 0; y < _height; ++y)
				{
					var char:String = data.landscape.charAt(x + y * _width);
					_cells[x][y] = (char == "/") ? -1 : Base64.instance.getBaseIndex(char);
				}
			}
			
			for (var i:int = 0; i < data.provinces.length; ++i)
				_provinces.push(new Province(data.provinces[i]));
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