package empire.provincescreen
{
	import empire.army.UnitView;
	import empire.game.GameUtil;
	import empire.resources.Resources;
	
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	import util.ColorUtil;
	
	public class UnitRecruitBox extends UnitBox
	{
		public static const OFFSET:Number = 15;
		
		private var _fortLevel	:int;
		private var _fortHealth	:int;
		private var _recruits	:Array;
		private var _isFort		:Boolean;
		private var _isRecruits	:Array;
		
		private var _repairView:UnitView;
		
		/**
		 * Objects
		 * 	{
		 * 		view			: UnitView,
		 * 		rollOverHandler	: Function,
		 * 		rollOutHandler	: Function,
		 * 		clickHandler	: Function
		 * 	}
		 */
		
		public function UnitRecruitBox()
		{
			super();
		}
		
		public function update(fortLevel:int, fortHealth:int, recruits:Array, isFort:Boolean, isRecruits:Array):void
		{
			reset();
			
			_fortLevel	= fortLevel;
			_fortHealth	= fortHealth;
			_recruits	= recruits;
			_isFort		= isFort;
			_isRecruits	= isRecruits;
			
			drawFort();
			
			addOffset(OFFSET);
			
			drawRecruits();
		}
		
		private function drawFort():void
		{
			var fortView:UnitView = new UnitView(Resources.FORTS[_fortLevel], 0, 0, 0, 0);
			
			addItem(fortView);
			
			if (_fortHealth < GameUtil.FORT_MAX_HEALTH[_fortLevel])
				_repairView = new UnitView(Resources.REPAIR, 0, 0, 0, 0);
			else if (_fortLevel < GameUtil.FORT_MAX_LEVEL)
				_repairView = new UnitView(Resources.UPGRADE, 0, 0, 0, 0);
			else
				_repairView = null;
			
			if (_repairView)
			{
				_repairView.addEventListener(MouseEvent.CLICK, onRepairClick, false, 0, true);
				addItem(_repairView);
				updateRepair();
			}
		}
		
		private function updateRepair():void
		{
			_repairView.filters = _isFort ? [ new GlowFilter(ColorUtil.WHITE, 1, 12, 12) ] : [];
		}
		
		private function onRepairClick(e:MouseEvent):void
		{
		}
		
		private function drawRecruits():void
		{
		}
	}
}