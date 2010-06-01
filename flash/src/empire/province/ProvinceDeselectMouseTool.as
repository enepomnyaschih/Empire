package empire.province
{
	import com.cascade.mouse.mousetool.MouseTool;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ProvinceDeselectMouseTool extends MouseTool
	{
		public static const TYPE:String = "ProvinceDeselect";
		
		public static const EVENT_DESELECTED:String = "deselected";
		
		override public function get type():String
		{
			return TYPE;
		}
		
		override public function init():void
		{
			Frame.instance.addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
		}
		
		override public function free():void
		{
			Frame.instance.removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void
		{
			Frame.instance.broadcaster.dispatchEvent(new Event(EVENT_DESELECTED));
		}
	}
}