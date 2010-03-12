package empire.army
{
	import common.View;
	
	import empire.game.GameUtil;
	import empire.resources.Resources;

	public class ArmyView extends View
	{
		private var VIEW_WIDTH	:Number = 50;
		private var VIEW_GAP	:Number = 10;
		
		private var _units		:Array;
		private var _fortLevel	:int;
		private var _fortHealth	:int;
		
		private var _views		:Array = new Array();
		
		public function ArmyView(units:Array, fortLevel:int, fortHealth:int)
		{
			super();
			
			_units		= units;
			_fortLevel	= fortLevel;
			_fortHealth	= fortHealth;
			
			var i:int;
			
			for (i = 0; i < _units.length; ++i)
			{
				if (_units[i] == 0)
					continue;
				
				_views.push(new UnitView(Resources.UNITS[i], _units[i], 0));
			}
			
			if (fortLevel > 0)
			{
				_views.push(new UnitView(
					Resources.FORTS[fortLevel], 0, fortHealth / GameUtil.FORT_MAX_HEALTH[fortLevel]));
			}
			
			var s:Number = (_views.length - 1) * (VIEW_WIDTH + VIEW_GAP) / 2;
			
			for (i = 0; i < _views.length; ++i)
			{
				_views[i].x = i * (VIEW_WIDTH + VIEW_GAP) - s;
				addChild(_views[i]);
			}
			
			mouseChildren	= false;
			mouseEnabled	= false;
		}
	}
}