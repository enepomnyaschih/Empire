// TODO: inherit everything from EventDispatcher
// TODO: add possibility to configure MouseTools, like { mouseTool: MapMouseTool(1, 2, 3); }
// TODO: implement Parser as ITyped, not as IBaseFactory
// TODO: test all source files
// TODO: secure exceptions interception while reading and else
// TODO: support commentaries in CSS file
// TODO: support default priorities for mouse tools

package app
{
	import com.cascade.base.element.base.CascadeElement;
	import com.cascade.base.element.base.ICascadeElement;
	import com.cascade.base.loader.CascadeLoader;
	import com.cascade.base.loader.CascadeLoaderEvent;
	import com.cascade.base.loader.ICascadeLoader;
	import com.cascade.base.managers.CascadeManager;
	import com.cascade.mouse.managers.IMouseToolFactoryManager;
	import com.cascade.mouse.managers.MouseManager;
	import com.cascade.visual.manager.CascadeVisualManager;
	
	import flash.net.URLRequest;
	
	import mx.core.UIComponent;

	public class CascadeApplication extends UIComponent
	{
		private var _cascadeElement:ICascadeElement;
		private var _map:Map;
		private var _loader:ICascadeLoader;
		
		public function CascadeApplication()
		{
			super();
			
			CascadeVisualManager.instance;
			
			initMouseTools();
			initCascadeRules();
		}
		
		public function buildUI():void
		{
			_cascadeElement = new CascadeElement(this, "Application");
			
			_map = new Map();
			addChild(_map);
			_cascadeElement.addChild(_map.cascadeElement);
			
			CascadeManager.instance.elementValidationManager.validateAllElementsStyle();
		}
		
		public function get cascadeElement():ICascadeElement
		{
			return _cascadeElement;
		}
		
		public function get map():Map
		{
			return _map;
		}
		
		private function initMouseTools():void
		{
			var manager:IMouseToolFactoryManager = MouseManager.instance.mouseToolFactoryManager;
			manager.register(new BorderMouseToolFactory());
		}
		
		private function initCascadeRules():void
		{
			var request:URLRequest = new URLRequest("../src/Cascade.css");
			request.method = "GET";
			
			_loader = new CascadeLoader();
			_loader.addEventListener(CascadeLoaderEvent.SUCCESS, onCascadeLoadSuccess, false, 0, true);
			_loader.load(request);
		}
		
		private function onCascadeLoadSuccess(e:CascadeLoaderEvent):void
		{
			buildUI();
		}
	}
}