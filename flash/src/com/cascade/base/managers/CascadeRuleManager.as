package com.cascade.base.managers
{
	import com.cascade.base.rule.CascadeRule;
	import com.cascade.base.rule.ICascadeRule;
	import com.cascade.base.selector.CascadeSelector;
	import com.cascade.base.styles.base.ICascadeStyleFactory;
	
	import flash.utils.Dictionary;
	
	import mx.utils.StringUtil;
	
	import util.ErrorUtil;

	public class CascadeRuleManager implements ICascadeRuleManager
	{
		private var _rules:Array = new Array();
		
		public function get rules():Array
		{
			return _rules;
		}
		
		public function register(rule:ICascadeRule):void
		{
			_rules.push(rule);
		}
		
		public static function createByString(source:String):ICascadeRule
		{
			var styleFactoryManager	:ICascadeStyleFactoryManager = CascadeManager.instance.styleFactoryManager;
			
			var beginIndex			:int = source.indexOf("{");
			var endIndex			:int = source.indexOf("}");
			
			if (beginIndex == -1)
				ErrorUtil.throwMsg("Can't parse '", source, "' as CSS rule: '{' expected.");
			
			if (endIndex == -1)
				ErrorUtil.throwMsg("Can't parse '", source, "' as CSS rule: '}' expected.");
			
			var multiSelectorSource	:String = StringUtil.trim(source.substr(0, beginIndex));
			var selectorSources		:Array = multiSelectorSource.split(",");
			var selectors			:Array = new Array();
			
			for (var selectorIndex:int = 0; selectorIndex < selectorSources.length; ++selectorIndex)
				selectors.push(CascadeSelector.createByString(selectorSources[selectorIndex]));
			
			var bodySource			:String = source.substr(beginIndex + 1, endIndex - beginIndex - 1);
			var styleSources		:Array = bodySource.split(";");
			var styles				:Dictionary = new Dictionary();
			
			for (var styleIndex:int = 0; styleIndex < styleSources.length; ++styleIndex)
			{
				var styleSource:String = StringUtil.trim(styleSources[styleIndex]);
				if (styleSource.length == 0)
					continue;
				
				var separatorIndex:int = styleSource.indexOf(":");
				var styleName:String = StringUtil.trim(styleSource.substr(0, separatorIndex));
				var styleValue:String = StringUtil.trim(styleSource.substr(separatorIndex + 1));
				var styleFactory:ICascadeStyleFactory = styleFactoryManager.getCascadeStyleFactory(styleName);
				
				if (!styleFactory)
					ErrorUtil.throwMsg("Can't parse '", styleName, "' as CSS style name: CSS style factory of this type is not registered.");
				
				styles[styleName] = styleFactory.createStyle(styleValue);
			}
			
			return new CascadeRule(selectors, styles, 0);
		}
	}
}