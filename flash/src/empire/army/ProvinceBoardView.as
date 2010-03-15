package empire.army
{
	import empire.resources.Resources;

	public class ProvinceBoardView extends UnitBoardView
	{
		private var _gold:int;
		private var _recruits:Array;
		
		public function ProvinceBoardView(gold:int, recruits:Array)
		{
			_gold = gold;
			_recruits = recruits;
			
			super();
		}
		
		override protected function buildViews(views:Array):void
		{
			var i:int;
			
			for (i = 0; i < _gold; ++i)
				views.push(new UnitView(Resources.GOLD, 0, 0, 0, 0));
			
			for (i = 0; i < _recruits.length; ++i)
				views.push(new UnitView(Resources.UNITS[_recruits[i]], 0, 0, 0, 0));
		}
	}
}