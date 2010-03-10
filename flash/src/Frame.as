package
{
	import common.ViewManager;
	
	import game.map.Map;
	import game.map.MapController;
	
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;
	
	import ui.IsothropicLayout;

	public class Frame extends UIComponent
	{
		private static var _instance:Frame;
		
		private var _layout:IsothropicLayout;
		
		private var _map:Map;
		private var _mapController:MapController;
		
		public function Frame()
		{
			super();
			
			_layout = new IsothropicLayout();
			
			addChild(_layout);
			
			_map = new Map(
				10, 10, "/AAAA//////AAAAAA/////AAAAABBBCCCCAABBBBCCCC/BBBBB/CCC//BBBBCCCCDDDD//////DDDDD//////DDD/////DDDDD//",
				[
					{
						nearProvinces	: [1, 2],
						owner			: 0
					}, {
						nearProvinces	: [0, 2],
						owner			: 1
					}, {
						nearProvinces	: [0, 1],
						owner			: 2
					}, {
						nearProvinces	: [2],
						owner			: -1
					}
				]
			);
			
			_mapController = new MapController(_map);
			
			_layout.addChild(_mapController.mapView);
			
			ViewManager.instance.validateAllViewsGraphics();
			
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