package com.cascade.visual.manager
{
	import com.cascade.base.managers.CascadeManager;
	import com.cascade.base.managers.ICascadeActionFactoryManager;
	import com.cascade.base.managers.ICascadeParserManager;
	import com.cascade.base.managers.ICascadeStyleFactoryManager;
	import com.cascade.stdparser.bool.CascadeBooleanParser;
	import com.cascade.stdparser.color.CascadeColorParser;
	import com.cascade.stdparser.enum.CascadeEnumParser;
	import com.cascade.stdparser.float.CascadeFloatParser;
	import com.cascade.stdparser.manager.CascadeStdParserManager;
	import com.cascade.stdparser.string.CascadeStringParser;
	import com.cascade.visual.action.CascadeVisualActionFactory;
	import com.cascade.visual.style.CascadeVisualStyleFactory;
	
	import flash.display.BlendMode;
	import flash.events.EventDispatcher;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	
	import util.ErrorUtil;

	public class CascadeVisualManager extends EventDispatcher implements ICascadeVisualManager
	{
		private static var _instance:CascadeVisualManager;
		
		private static const ANTI_ALIAS_TYPE:String = "AntiAliasType";
		private static const ANTI_ALIAS_TYPE_VALUES:Array = [
			AntiAliasType.NORMAL,
			AntiAliasType.ADVANCED
		];
		
		private static const ATTACHMENT_STYLE:String = "AttachmentStyle";
		private static const ATTACHMENT_STYLE_VALUES:Array = [
			"fixed",
			"scroll"
		];
		
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
		
		private static const GRID_FIT_TYPE:String = "GridFitType";
		private static const GRID_FIT_TYPE_VALUES:Array = [
			GridFitType.NONE,
			GridFitType.PIXEL,
			GridFitType.SUBPIXEL
		];
		
		public function CascadeVisualManager()
		{
			super();
			
			if (_instance)
				ErrorUtil.throwSingletonInstantiated("CascadeFlexStyleManager");
			
			initParsers();
			initActions();
			initStyles();
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
			manager.register(new CascadeEnumParser(ANTI_ALIAS_TYPE,		ANTI_ALIAS_TYPE_VALUES));
			manager.register(new CascadeEnumParser(ATTACHMENT_STYLE,	ATTACHMENT_STYLE_VALUES));
			manager.register(new CascadeEnumParser(BLEND_MODE,			BLEND_MODE_VALUES));
			manager.register(new CascadeEnumParser(BORDER_STYLE,		BORDER_STYLE_VALUES));
			manager.register(new CascadeEnumParser(GRID_FIT_TYPE,		GRID_FIT_TYPE_VALUES));
		}
		
		private function initActions():void
		{
			var manager:ICascadeActionFactoryManager = CascadeManager.instance.actionFactoryManager;
			manager.register(new CascadeVisualActionFactory());
		}
		
		private function initStyles():void
		{
			var manager:ICascadeStyleFactoryManager = CascadeManager.instance.styleFactoryManager;
			manager.register(new CascadeVisualStyleFactory("backgroundAlpha",				"backgroundAlpha",				CascadeFloatParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("backgroundAttachment",			"backgroundAttachment",			ATTACHMENT_STYLE));
			manager.register(new CascadeVisualStyleFactory("backgroundColor",				"backgroundColor",				CascadeColorParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("backgroundDisabledColor",		"backgroundDisabledColor",		CascadeColorParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("backgroundImage",				"backgroundImage",				CascadeStringParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("backgroundSize",				"backgroundSize",				CascadeFloatParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("barColor",						"barColor",						CascadeColorParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("baseline",						"baseline",						CascadeFloatParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("borderColor",					"borderColor",					CascadeColorParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("borderSides",					"borderSides",					CascadeStringParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("borderSkin",					"borderSkin",					CascadeStringParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("borderStyle",					"borderStyle",					BORDER_STYLE));
			manager.register(new CascadeVisualStyleFactory("borderThickness",				"borderThickness",				CascadeFloatParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("bottom",						"bottom",						CascadeStringParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("color",							"color",						CascadeColorParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("cornerRadius",					"cornerRadius",					CascadeFloatParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("disabledColor",					"disabledColor",				CascadeColorParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("disabledOverlayAlpha",			"disabledOverlayAlpha",			CascadeFloatParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("dropShadowColor",				"dropShadowColor",				CascadeColorParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("dropShadowEnabled",				"dropShadowEnabled",			CascadeBooleanParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("errorColor",					"errorColor",					CascadeColorParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("focusBlendMode",				"focusBlendMode",				BLEND_MODE));
			manager.register(new CascadeVisualStyleFactory("focusSkin",						"focusSkin",					CascadeStringParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("focusThickness",				"focusThickness",				CascadeFloatParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("fontAntiAliasType",				"fontAntiAliasType",			ANTI_ALIAS_TYPE));
			manager.register(new CascadeVisualStyleFactory("fontFamily",					"fontFamily",					CascadeStringParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("fontGridFitType",				"fontGridFitType",				GRID_FIT_TYPE));
			manager.register(new CascadeVisualStyleFactory("fontSharpness",					"fontSharpness",				CascadeFloatParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("fontSize",						"fontSize",						CascadeFloatParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("fontStyle",						"fontStyle",					CascadeStringParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("fontThickness",					"fontThickness",				CascadeFloatParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("fontWeight",					"fontWeight",					CascadeStringParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("horizontalCenter",				"horizontalCenter",				CascadeFloatParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("horizontalScrollBarStyleName",	"horizontalScrollBarStyleName",	CascadeStringParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("kerning",						"kerning",						CascadeBooleanParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("left",							"left",							CascadeStringParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("letterSpacing",					"letterSpacing",				CascadeFloatParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("right",							"right",						CascadeStringParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("shadowDirection",				"shadowDirection",				CascadeStringParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("shadowDistance",				"shadowDistance",				CascadeFloatParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("textAlign",						"textAlign",					CascadeStringParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("textDecoration",				"textDecoration",				CascadeStringParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("textIndent",					"textIndent",					CascadeFloatParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("themeColor",					"themeColor",					CascadeColorParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("top",							"top",							CascadeStringParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("verticalCenter",				"verticalCenter",				CascadeStringParser.TYPE));
			manager.register(new CascadeVisualStyleFactory("verticalScrollBarStyleName",	"verticalScrollBarStyleName",	CascadeStringParser.TYPE));
		}
	}
}