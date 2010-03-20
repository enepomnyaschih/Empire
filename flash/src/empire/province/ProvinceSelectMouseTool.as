package empire.province
{
	import common.mouse.MouseManager;
	import common.mouse.MouseTool;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ProvinceSelectMouseTool extends MouseTool
	{
		public static const EVENT_SELECTED:String = "selected";
		
		private var _target:ProvinceView;
		
		override public function activate():void
		{
			super.activate();
			
			_target = MouseManager.instance.getActiveTarget("Province") as ProvinceView;
			if (!_target)
				return;
			
			_target.isBlick = true;
			_target.addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
		}
		
		override public function deactivate():void
		{
			super.deactivate();
			
			if (!_target)
				return;
			
			_target.isBlick = false;
			_target.removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		public function get target():ProvinceView
		{
			return _target;
		}
		
		private function onClick(e:MouseEvent):void
		{
			dispatchEvent(new Event(EVENT_SELECTED));
		}
	}
}