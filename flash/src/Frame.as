package
{
	import com.IsothropicLayout;
	
	import mx.containers.Canvas;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;

	public class Frame extends UIComponent
	{
		private var _layout:IsothropicLayout;
		private var _canvas:Canvas;
		
		public function Frame()
		{
			super();
			
			_layout = new IsothropicLayout();
			_layout.wh = 4 / 3;
			
			_canvas = new Canvas();
			_canvas.setStyle("backgroundColor", 0xFF0000);
			
			_layout.addChild(_canvas);
			
			addChild(_layout);
			
			doLayout();
			
			Application.application.addEventListener(ResizeEvent.RESIZE, this.onAppResize);
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