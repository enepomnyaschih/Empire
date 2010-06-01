package com.cascade.base.parser
{
	import com.ITyped;
	
	public interface ICascadeParser extends ITyped
	{
		function parse(source:String):*;
		function format(value:*):String;
		
		function equal(x:*, y:*):Boolean;
	}
}