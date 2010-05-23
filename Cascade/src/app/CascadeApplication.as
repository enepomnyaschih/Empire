// TODO: inherit everything from EventDispatcher
// TODO: add possibility to configure MouseTools, like { mouseTool: MapMouseTool(1, 2, 3); }
// TODO: implement Parser as ITyped, not as IBaseFactory
// TODO: reading of .css files
// TODO: test all source files

package app
{
	import com.cascade.base.element.base.CascadeElement;
	import com.cascade.base.element.base.ICascadeElement;
	import com.cascade.base.managers.CascadeManager;
	import com.cascade.base.managers.CascadeRuleManager;
	import com.cascade.base.managers.ICascadeRuleManager;
	import com.cascade.mouse.managers.IMouseToolFactoryManager;
	import com.cascade.mouse.managers.MouseManager;
	import com.cascade.visual.manager.CascadeVisualManager;
	
	import mx.core.UIComponent;

	public class CascadeApplication extends UIComponent
	{
		private var _cascadeElement:ICascadeElement;
		private var _map:Map;
		
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
			var manager:ICascadeRuleManager = CascadeManager.instance.ruleManager;
			manager.register(CascadeRuleManager.createByString("{ backgroundColor: #00FFFF; }"));
			manager.register(CascadeRuleManager.createByString("Application Map.mapka .red   { backgroundColor: #FF0000; }"));
			manager.register(CascadeRuleManager.createByString("Application Map.mapka .green { backgroundColor: #00FF00; }"));
			manager.register(CascadeRuleManager.createByString("Application Map.mapka .blue  { backgroundColor: #0000FF; }"));
			manager.register(CascadeRuleManager.createByString("MegaCanvas.hover { borderStyle: solid; borderThickness: 5; borderColor: #000000; }"));
//			manager.register(CascadeRuleManager.createByString("MegaCanvas.hover { mouseTool: Border 1p; }"));
		}
	}
}