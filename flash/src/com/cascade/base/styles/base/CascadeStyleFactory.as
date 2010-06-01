package com.cascade.base.styles.base
{
	import com.cascade.base.managers.CascadeManager;
	import com.cascade.base.parser.ICascadeParser;
	import com.factory.BaseFactory;
	
	import util.ErrorUtil;
	
	public class CascadeStyleFactory extends BaseFactory implements ICascadeStyleFactory
	{
		public function get styleName():String
		{
			return type;
		}
		
		public function get parser():ICascadeParser
		{
			return CascadeManager.instance.parserManager.getParser(parserType);
		}
		
		virtual public function get styleCls():Class
		{
			return ErrorUtil.throwMustOverride();
		}
		
		public function createStyle(source:String):ICascadeStyle
		{
			return new styleCls(parser.parse(source));
		}
		
		virtual protected function get parserType():String
		{
			return ErrorUtil.throwMustOverride();
		}
	}
}