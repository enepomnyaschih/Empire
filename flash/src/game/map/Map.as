package game.map
{
	import common.Model;
	
	import game.province.Province;
	import game.province.ProvinceCollection;
	
	import util.Base64;
	
	public class Map extends Model
	{
		private var _width:int;
		private var _height:int;
		
		private var _cells:Array;
		
		private var _provinces:ProvinceCollection = new ProvinceCollection();
		
		
		
		
		
		
		public function Map(width:int, height:int, landscape:String, provincesData:Array)
		{
			super();
			
			_width	= width;
			_height	= height;
			
			_cells = new Array(_width);
			for (var x:int = 0; x < _width; ++x)
			{
				_cells[x] = new Array(_height);
				for (var y:int = 0; y < _height; ++y)
				{
					var char:String = landscape.charAt(x + y * _width);
					_cells[x][y] = (char == "/") ? -1 : Base64.instance.getBaseIndex(char);
				}
			}
			
			for (var i:int = 0; i < provincesData.length; ++i)
				_provinces.addItem(new Province(i, provincesData[i]));
		}
		
		public function get width():int
		{
			return _width;
		}
		
		public function get height():int
		{
			return _height;
		}
		
		public function getCell(x:int, y:int):int
		{
			return _cells[x][y];
		}
		
		public function get provinces():ProvinceCollection
		{
			return _provinces;
		}
	}
}