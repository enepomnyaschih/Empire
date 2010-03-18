package empire.province
{
	import common.mouse.MouseManager;
	import common.mouse.MouseTool;
	
	import flash.events.MouseEvent;

	public class ProvinceSelectMouseTool extends MouseTool
	{
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
		
		private function onClick(e:MouseEvent):void
		{
			Frame.instance.provinceScreen.show(_target.game, _target.game.turnCount - 1, _target.provinceIndex);
		}
	}
}