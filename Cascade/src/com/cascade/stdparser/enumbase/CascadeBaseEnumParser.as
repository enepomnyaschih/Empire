package com.cascade.stdparser.enumbase
{
	import com.cascade.base.parser.CascadeParser;
	
	import util.ErrorUtil;

	public class CascadeBaseEnumParser extends CascadeParser implements ICascadeBaseEnumParser
	{
		virtual public function get values():Array
		{
			return ErrorUtil.throwMustOverride();
		}
		
		override public function parse(source:String):*
		{
			if (values.indexOf(source) == -1)
				return throwCantParse(source);
			
			return source;
		}
		
		override public function format(value:*):String
		{
			return value;
		}
	}
}