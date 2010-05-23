package com.cascade.stdparser.float
{
	import com.cascade.base.parser.CascadeParser;

	public class CascadeFloatParser extends CascadeParser implements ICascadeFloatParser
	{
		public static const TYPE:String = "Float";
		
		override public function get type():String
		{
			return TYPE;
		}
		
		override public function parse(source:String):*
		{
			return parseFloat(source);
		}
		
		override public function format(value:*):String
		{
			return Number(value).toString();
		}
	}
}