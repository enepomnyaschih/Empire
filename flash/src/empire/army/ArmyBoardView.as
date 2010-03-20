package empire.army
{
	import empire.game.GameUtil;
	import empire.resources.Resources;

	public class ArmyBoardView extends UnitBoardView
	{
		private var _units		:Array;
		private var _left		:Array;
		private var _came		:Array;
		private var _fortLevel	:int;
		private var _fortHealth	:int;
		
		public function ArmyBoardView(units:Array, left:Array, came:Array, fortLevel:int, fortHealth:int)
		{
			_units		= units;
			_left		= left;
			_came		= came;
			_fortLevel	= fortLevel;
			_fortHealth	= fortHealth;
			
			super();
		}
		
		override protected function buildViews(views:Array):void
		{
			var i:int;
			
			for (i = 0; i < _units.length; ++i)
			{
				if (_units[i] == 0 && (!_came || _came[i] == 0))
					continue;
				
				views.push(new UnitView(
					Resources.UNITS[i],
					_units[i],
					_left ? _left[i] : 0,
					_came ? _came[i] : 0,
					0
				));
			}
			
			if (_fortLevel > 0)
			{
				views.push(new UnitView(
					Resources.FORTS[_fortLevel],
					0, 0, 0,
					_fortHealth / GameUtil.FORT_MAX_HEALTH[_fortLevel]
				));
			}
		}
	}
}