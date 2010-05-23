package com.cascade.visual.manager
{
	import com.cascade.base.managers.CascadeManager;
	import com.cascade.base.managers.ICascadeActionFactoryManager;
	import com.cascade.base.managers.ICascadeParserManager;
	import com.cascade.base.managers.ICascadeStyleFactoryManager;
	import com.cascade.stdparser.color.CascadeColorParser;
	import com.cascade.stdparser.enum.CascadeEnumParser;
	import com.cascade.stdparser.float.CascadeFloatParser;
	import com.cascade.stdparser.manager.CascadeStdParserManager;
	import com.cascade.stdparser.string.CascadeStringParser;
	import com.cascade.visual.action.CascadeVisualActionFactory;
	import com.cascade.visual.style.CascadeVisualStyleFactory;
	
	import flash.events.EventDispatcher;
	
	import util.ErrorUtil;

	public class CascadeVisualManager extends EventDispatcher implements ICascadeVisualManager
	{
		private static var _instance:CascadeVisualManager;
		
		private static const BLEND_MODE:String = "BlendMode";
		private static const BLEND_MODE_VALUES:Array = [
			BlendMode.ADD,
			BlendMode.ALPHA,
			BlendMode.DARKEN,
			BlendMode.DIFFERENCE,
			BlendMode.ERASE,
			BlendMode.HARDLIGHT,
			BlendMode.INVERT,
			BlendMode.LAYER,
			BlendMode.LIGHTEN,
			BlendMode.MULTIPLY,
			BlendMode.NORMAL,
			BlendMode.OVERLAY,
			BlendMode.SCREEN,
			BlendMode.SUBTRACT
		];
		
		private static const BORDER_STYLE:String = "BorderStyle";
		private static const BORDER_STYLE_VALUES:Array = [
			"none",
			"solid",
			"inset",
			"outset"
		];
		
		public function CascadeVisualManager()
		{
			super();
			
			if (_instance)
				ErrorUtil.throwSingletonInstantiated("CascadeFlexStyleManager");
			
			initParsers();
			initActions();
		}
		
		public static function get instance():CascadeVisualManager
		{
			if (!_instance)
				new CascadeVisualManager();
			
			return _instance;
		}
		
		private function initParsers():void
		{
			CascadeStdParserManager.instance;
			
			var manager:ICascadeParserManager = CascadeManager.instance.parserManager;
			manager.register(new CascadeEnumParser(BLEND_MODE,		BLEND_MODE_VALUES));
			manager.register(new CascadeEnumParser(BORDER_STYLE,	BORDER_STYLE_VALUES));
		}
		
		private function initActions():void
		{
			var manager:ICascadeActionFactoryManager = CascadeManager.instance.actionFactoryManager;
			manager.register(new CascadeVisualActionFactory());
		}
		
		private function initStyles():void
		{
			var manager:ICascadeStyleFactoryManager = CascadeManager.instance.styleFactoryManager;
			manager.register(new CascadeVisualStyleFactory("backgroundColor",	"backgroundColor",	CascadeColorParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("baseline",			"baseline",			CascadeFloatParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("borderColor",		"borderColor",		CascadeColorParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("borderStyle",		"borderStyle",		BORDER_STYLE));
			manager.register(new CascadeVisualStyleFactory("borderThickness",	"borderThickness",	CascadeFloatParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("bottom",			"bottom",			CascadeFloatParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("errorColor",		"errorColor",		CascadeColorParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("focusBlendMode",	"focusBlendMode",	BLEND_MODE));
			manager.register(new CascadeVisualStyleFactory("focusSkin",			"focusSkin",		CascadeStringParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("focusThickness",	"focusThickness",	CascadeFloatParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("horizontalCenter",	"horizontalCenter",	CascadeFloatParser.TYPE));
		}
	}
}