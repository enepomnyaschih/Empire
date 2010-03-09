package
{
	import com.IsothropicLayout;
	
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;

	public class Frame extends UIComponent
	{
		private static var _instance:Frame;
		
		private var _layout:IsothropicLayout;
		
		public function Frame()
		{
			super();
			
			_layout = new IsothropicLayout();
			
			addChild(_layout);
			
			doLayout();
			
			Application.application.addEventListener(ResizeEvent.RESIZE, this.onAppResize);
		}
		
		public static function init():void
		{
			if (_instance)
				return;
			
			_instance = new Frame();
		}
		
		public static function get instance():Frame
		{
			init();
			return _instance;
		}
		
		public function doLayout():void
		{
			var w:Number = Application.application.width;
			var h:Number = Application.application.height;
			
			setActualSize(w, h);
			_layout.setActualSize(w, h);
		}
		
		private function onAppResize(e:ResizeEvent):void
		{
			doLayout();
		}
	}
}