package com.cascade.stdparser.color
{
	import com.cascade.base.parser.CascadeParser;

	public class CascadeColorParser extends CascadeParser implements ICascadeColorParser
	{
		public static const TYPE:String = "Color";
		
		override public function get type():String
		{
			return TYPE;
		}
		
		override public function parse(source:String):*
		{
			if (source.length != 7 || source.charAt(0) != "#")
				throwCantParse(source);
			
			return parseInt(source.substr(1), 16);
		}
		
		override public function format(value:*):String
		{
			return "#" + uint(value).toString(16);
		}
	}
}