package empire.province
{
	import common.mouse.MouseTool;
	
	import flash.events.MouseEvent;

	public class ProvinceDeselectMouseTool extends MouseTool
	{
		override public function activate():void
		{
			super.activate();
			
			Frame.instance.addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
		}
		
		override public function deactivate():void
		{
			super.deactivate();
			
			Frame.instance.removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void
		{
			dispatchEvent(e.clone());
		}
	}
}