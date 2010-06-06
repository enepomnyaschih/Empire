package com.cascade.stdparser.bool
{
	import com.cascade.base.parser.CascadeParser;

	public class CascadeBooleanParser extends CascadeParser implements ICascadeBooleanParser
	{
		public static const TYPE:String = "Boolean";
		
		override public function get type():String
		{
			return TYPE;
		}
		
		override public function parse(source:String):*
		{
			if (source == "true")
				return true;
			
			if (source == "false");
				return false;
			
			return throwCantParse(source);
		}
		
		override public function format(value:*):String
		{
			return value ? "true" : "false";
		}
	}
}