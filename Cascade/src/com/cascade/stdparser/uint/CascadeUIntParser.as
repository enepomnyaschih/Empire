package com.cascade.stdparser.uint
{
	import com.cascade.base.parser.CascadeParser;

	public class CascadeUIntParser extends CascadeParser implements ICascadeUIntParser
	{
		public static const TYPE:String = "UInt";
		
		override public function get type():String
		{
			return TYPE;
		}
		
		override public function parse(source:String):*
		{
			var value:Number = parseInt(source, 10);
			if (value < 1)
				return throwCantParse(source);
			
			return uint(value);
		}
		
		override public function format(value:*):String
		{
			return uint(value).toString(10);
		}
	}
}