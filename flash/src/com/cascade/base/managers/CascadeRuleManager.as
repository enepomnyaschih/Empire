package com.cascade.base.managers
{
	import com.cascade.base.rule.CascadeRule;
	import com.cascade.base.rule.ICascadeRule;
	import com.cascade.base.selector.CascadeSelector;
	import com.cascade.base.selector.ICascadeSelector;
	import com.cascade.base.styles.base.ICascadeStyleFactory;
	
	import flash.utils.Dictionary;
	
	import mx.utils.StringUtil;

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
			var styleFactoryManager	:ICascadeStyleFactoryManager	= CascadeManager.instance.styleFactoryManager;
			
			var beginIndex		:int = source.indexOf("{");
			var endIndex		:int = source.indexOf("}");
			var selectorSource	:String = StringUtil.trim(source.substr(0, beginIndex));
			var selector		:ICascadeSelector = CascadeSelector.createByString(selectorSource);
			var bodySource		:String = source.substr(beginIndex + 1, endIndex - beginIndex - 1);
			var styleSources	:Array = bodySource.split(";");
			var styles			:Dictionary = new Dictionary();
			
			for (var styleIndex:int = 0; styleIndex < styleSources.length; ++styleIndex)
			{
				var styleSource:String = StringUtil.trim(styleSources[styleIndex]);
				if (styleSource.length == 0)
					continue;
				
				var separatorIndex:int = styleSource.indexOf(":");
				var styleName:String = StringUtil.trim(styleSource.substr(0, separatorIndex));
				var styleValue:String = StringUtil.trim(styleSource.substr(separatorIndex + 1));
				var styleFactory:ICascadeStyleFactory = styleFactoryManager.getCascadeStyleFactory(styleName);
				
				styles[styleName] = styleFactory.createStyle(styleValue);
			}
			
			return new CascadeRule(selector, styles, 0);
		}
	}
}