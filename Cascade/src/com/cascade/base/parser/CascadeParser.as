package com.cascade.base.parser
{
	import com.factory.BaseFactory;
	
	import util.ErrorUtil;
	
	public class CascadeParser extends BaseFactory implements ICascadeParser
	{
		virtual public function parse(source:String):*
		{
			return ErrorUtil.throwMustOverride();
		}
		
		virtual public function format(value:*):String
		{
			return ErrorUtil.throwMustOverride();
		}
		
		virtual public function equal(x:*, y:*):Boolean
		{
			return x == y;
		}
		
		protected function throwCantParse(source:String):*
		{
			return ErrorUtil.throwMsg("Can't parse '" + source + "' as " + type + ".");
		}
	}
}