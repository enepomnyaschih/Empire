package com.cascade.stdparser.string
{
	import com.cascade.base.parser.CascadeParser;

	public class CascadeStringParser extends CascadeParser implements ICascadeStringParser
	{
		public static const TYPE:String = "String";
		
		override public function get type():String
		{
			return TYPE;
		}
		
		override public function parse(source:String):*
		{
			return source;
		}
		
		override public function format(value:*):String
		{
			return value;
		}
	}
}