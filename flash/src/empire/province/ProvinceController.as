package empire.province
{
	import common.Controller;
	
	import empire.game.Game;
	import empire.map.MapViewMetrics;

	public class ProvinceController extends Controller
	{
		private var _game:Game;
		private var _index:int;
		
		private var _provinceView:ProvinceView;
		
		public function ProvinceController(game:Game, index:int, metrics:MapViewMetrics)
		{
			super();
			
			_game = game;
			_index = index;
			_provinceView = new ProvinceView(_game, _index, metrics);
		}
		
		public function get provinceView():ProvinceView
		{
			return _provinceView;
		}
		
		public function addCell(x:int, y:int):void
		{
			_provinceView.addCell(x, y);
		}
		
		public function switchState(turn:int):void
		{
			_provinceView.switchState(turn);
		}
		
		public function onTicker():void
		{
			_provinceView.animate();
		}
	}
}