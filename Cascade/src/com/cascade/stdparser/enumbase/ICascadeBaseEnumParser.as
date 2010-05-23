package com.cascade.stdparser.enumbase
{
	import com.cascade.base.parser.ICascadeParser;
	
	public interface ICascadeBaseEnumParser extends ICascadeParser
	{
		function get values():Array;
	}
}