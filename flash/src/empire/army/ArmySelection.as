package empire.army
{
	import common.Controller;
	
	import empire.game.Game;

	public class ArmySelection extends Controller
	{
		private var _game:Game;
		private var _province:int;
		private var _units:Array;
		
		public function ArmySelection()
		{
			super();
		}
		
		public function select(province:int, unitType:int, count:int):void
		{
			
		}
	}
}