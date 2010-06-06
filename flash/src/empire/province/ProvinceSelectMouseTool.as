package empire.province
{
	import com.cascade.mouse.mousetool.MouseTool;
	
	import flash.events.MouseEvent;

	public class ProvinceSelectMouseTool extends MouseTool
	{
		public static const TYPE:String = "ProvinceSelect";
		
		public static const EVENT_SELECTED:String = "selected";
		
		private var _target:ProvinceView;
		
		override public function get type():String
		{
			return TYPE;
		}
		
		override public function init():void
		{
			_target = element.target as ProvinceView;
			if (!_target)
				return;
			
			_target.addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
		}
		
		override public function free():void
		{
			if (!_target)
				return;
			
			_target.removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		public function get target():ProvinceView
		{
			return _target;
		}
		
		private function onClick(e:MouseEvent):void
		{
			Frame.instance.broadcaster.dispatchEvent(new ProvinceSelectedEvent(EVENT_SELECTED, ProvinceView(element.target)));
		}
	}
}