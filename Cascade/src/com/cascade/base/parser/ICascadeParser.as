package com.cascade.base.parser
{
	import com.factory.IBaseFactory;
	
	public interface ICascadeParser extends IBaseFactory
	{
		function parse(source:String):*;
		function format(value:*):String;
		
		function equal(x:*, y:*):Boolean;
	}
}